//
//  ViewController.swift
//  bukovel
//
//  Created by Денис Данилюк on 12.01.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit

class AllLiftsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let reuseID = "reuseID"
    
    let LIFT_NAMES_SERVER = ["lift1r", "lift2", "lift2r", "lift3", "lift5", "lift7", "lift8", "lift11", "lift12", "lift13", "lift14", "lift15", "lift16", "lift22"]
    
    let LIFT_NAMES_USER = ["Витяг 1R", "Витяг 2", "Витяг 2R", "Витяг 3", "Витяг 5", "Витяг 7", "Витяг 8", "Витяг 11", "Витяг 12", "Витяг 13", "Витяг 14", "Витяг 15", "Витяг 16", "Витяг 22"]
    
    var liftImages: [UIImage?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupLiftImages()
        getAllImages()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    func setupLiftImages() {
        for _ in 0..<LIFT_NAMES_SERVER.count {
            liftImages.append(nil)
        }
    }
    
    func getAllImages() {
        for i in 0..<LIFT_NAMES_SERVER.count {
            server(cameraName: LIFT_NAMES_SERVER[i], cameraNumber: i)
        }
    }

    private func setupTableView() {
            tableView.register(UINib(nibName: QueueTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: QueueTableViewCell.identifier)
            tableView.delegate = self
            tableView.dataSource = self
    }
    
    func server(cameraName: String, cameraNumber: Int) {
        guard let url = URL(string: "https://bukovel.com/media/delays/\(cameraName).jpg") else { return }
            print(url)
            var image = UIImage()
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard data != nil else { return }
                do {
                    guard let data = try? Data(contentsOf: url) else { return }
                    image = UIImage(data: data) ?? UIImage()
                    DispatchQueue.main.async {
                        self.liftImages[cameraNumber] = image
                        self.tableView.reloadData()
                    }
                }
            }
            task.resume()
    }
}


extension AllLiftsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 14
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QueueTableViewCell.identifier, for: indexPath) as? QueueTableViewCell else { return UITableViewCell() }
        
        cell.liftLabel.text = LIFT_NAMES_USER[indexPath.row]
        
        if liftImages[indexPath.row] != nil {
            cell.liftImage.image = liftImages[indexPath.row]
            cell.liftImage.layer.cornerRadius = 20
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showLiftDetailViewController", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return screenWidth * (9/16) + 45
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLiftDetailViewController" {
            if let indexPath = tableView.indexPathForSelectedRow {
                if let destination = segue.destination as? LiftDetailViewController {
                    if liftImages[indexPath.row] != nil {
                        destination.imageSeque = liftImages[indexPath.row] ?? UIImage()
                        destination.liftNameSeque = LIFT_NAMES_USER[indexPath.row]
                    }
                }
            }
        }
    }
}
