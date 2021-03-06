//
//  LiftDetailViewController.swift
//  bukovel
//
//  Created by Денис Данилюк on 13.01.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit

class LiftDetailViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var navItem: UINavigationItem!
    var imageSeque = UIImage()
    var liftNameSeque = String()

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navItem?.title = liftNameSeque
        imageView.image = imageSeque
        scrollView.delegate = self
        if imageSeque == UIImage() {
            imageView.image = UIImage(named: "map")
        }
    }
    

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

}
