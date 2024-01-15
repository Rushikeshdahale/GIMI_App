//
//  SecondViewController.swift
//  WorkoutApp
//
//  Created by Rushikesh Dahale on 26/12/23.
//

import UIKit

class SecondViewController: UIViewController {
    
    
    @IBOutlet weak var image: UIImageView!
    var containerr : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        image.image = UIImage(named: containerr!)
    }
    
}
