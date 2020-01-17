//
//  LiftDetailViewController.swift
//  bukovel
//
//  Created by Денис Данилюк on 13.01.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit

class LiftDetailViewController: UIViewController, UIScrollViewDelegate {
    
    var imageSeque = UIImage()
    var liftNameSeque = String()

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = liftNameSeque
        imageView.image = imageSeque
        scrollView.delegate = self
    }
    

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

}
