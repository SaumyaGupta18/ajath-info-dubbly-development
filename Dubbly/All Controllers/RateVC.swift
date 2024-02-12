//
//  RateVC.swift
//  Dubbly
//
//  Created by SHASHI'S MAC on 10/02/24.
//

import Foundation
import UIKit

class RateVC: UIViewController {
        
    @IBOutlet weak var submitBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitBtn.layer.cornerRadius = submitBtn.frame.size.width/2
        submitBtn.layer.cornerRadius = 10;
        submitBtn.clipsToBounds = false;
    }
    
    @IBAction func submitBtn_Action(_ sender: UIButton) {
        
    }
    
    
}
