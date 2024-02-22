//
//  MusicEditVC.swift
//  Dubbly
//
//  Created by Shachish Sneh on 22/02/24.
//

import Foundation
import UIKit

class MusicEditVC: UIViewController {
    
    @IBOutlet weak var cancelbtn: UIButton!
    
    @IBOutlet weak var usebtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancelbtn.layer.cornerRadius = cancelbtn.frame.size.width/2
        cancelbtn.layer.cornerRadius = 10;
        cancelbtn.clipsToBounds = false;
        cancelbtn.layer.borderColor = UIColor.black.cgColor
        cancelbtn.layer.borderWidth = 0.5
        
        usebtn.layer.cornerRadius = usebtn.frame.size.width/2
        usebtn.layer.cornerRadius = 10;
        usebtn.clipsToBounds = false;
        
        
    }
}
