//
//  HomeVC.swift
//  Dubbly
//
//  Created by Shachish Sneh on 22/02/24.
//

import Foundation
import UIKit

class HomeVC: UIViewController{
    
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    sideMenuBtn.target = revealViewController()
    sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
    }
}
