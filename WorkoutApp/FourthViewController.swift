//
//  FourthViewController.swift
//  WorkoutApp
//
//  Created by Rushikesh Dahale on 27/12/23.
//

import UIKit

class FourthViewController: UIViewController {
    
    @IBOutlet weak var gifImage: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var container: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     gifImage.image = UIImage.gifImageWithName(name: container!)
        
    }
}
