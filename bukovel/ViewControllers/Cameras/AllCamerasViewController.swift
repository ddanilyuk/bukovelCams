//
//  AllCamerasViewController.swift
//  bukovel
//
//  Created by Денис Данилюк on 17.01.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit
import AVKit

class AllCamerasViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let reuseID = "reuseID"
        
    var LIFT_NAMES_SERVER: [String] = ["01_full", "02_full", "03_full", "04_full", "05_full", "06_full", "07_full", "08_full", "09_full", "10_full", "12_full", "14_full", "15_full", "16_full", "17_full", "18_full", "19_full", "20_full", "21_full", "23_full"]
        
    let LIFT_NAMES_USER = ["Оглядова камера. Витяг 7, ковзанка, сноутюбінг", "Нижня станція витягу 2A", "Навчальний майданчик", "Оглядова камера. 7 витяг", "Кафе 'Bugi.L'", "Верхня станція витягів 11 та 16", "Верх 12 витягу", "Верхня станція витягу 17A", "Траса 5В", "Верх 2 витягу", "Дитячий майданчик", "Буковельський ярмарок", "Ковзанка", "Житлова резиденція", "Нижні станції витягів 8,15 та 11", "Верх 14, 15 витягів", "VODA club", "Готель «HVOYA»", "Вигляд на 'Bukovel Residence'", "Житлова резиденція. Рецепція"]
    
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
            self.navigationController?.navigationBar.prefersLargeTitles = true
        
            self.navigationController?.navigationBar.isTranslucent = true
    }
    
    func server(cameraName: String, cameraNumber: Int) {
        guard let url = URL(string: "https://bukovel.com/media/cams_th/\(cameraName).jpg?") else { return }

//            guard let url = URL(string: "https://bukovel.com/media/delays/\(cameraName).jpg") else { return }
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


extension AllCamerasViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LIFT_NAMES_SERVER.count
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
        let name = LIFT_NAMES_SERVER[indexPath.row]
        let id = String(name[..<2])
        
        let videoURLString = "https://5c463ef86ff69.streamlock.net:10443/bukovel/\(id)-audio.stream/playlist.m3u8"
                        
        guard let videoURL = URL(string: videoURLString) else { return }
        
        let video = AVPlayer(url: videoURL)
        let videoPlayer = AVPlayerViewController()
        videoPlayer.player = video
        
        present(videoPlayer, animated: true, completion:
        {
            video.play()
        })
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return screenWidth * (9/16) + 45
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showLiftDetailViewController" {
//            if let indexPath = tableView.indexPathForSelectedRow {
//                if let destination = segue.destination as? LiftDetailViewController {
//                    if liftImages[indexPath.row] != nil {
//                        destination.imageSeque = liftImages[indexPath.row] ?? UIImage()
//                        destination.liftNameSeque = LIFT_NAMES_SERVER[indexPath.row]
//                    }
//                }
//            }
//        }
//    }
}
