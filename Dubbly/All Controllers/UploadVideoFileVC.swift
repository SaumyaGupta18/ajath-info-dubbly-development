//
//  UploadVideoFileVC.swift
//  Dubbly
//
//  Created by apple on 08/02/24.
//

import Foundation
import UIKit
import AVKit

class UploadVideoFileVC: UIViewController{
    
    @IBOutlet weak var projectNameTextField: UITextField!
    @IBOutlet weak var translateBtn: UIButton!
    @IBOutlet weak var translateTextField: UITextField!
    @IBOutlet weak var dubbedBtn: UIButton!
    @IBOutlet weak var dubbedTextfield: UITextField!
    @IBOutlet weak var pasteLinkTextField: UITextField!
    @IBOutlet weak var proceedBtn: UIButton!
    
    var videoURL: URL?
    var playerVC: AVPlayerViewController!
    let padding: CGFloat = 30.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        projectNameTextField.layer.cornerRadius = 8.0
        projectNameTextField.layer.borderWidth = 2.0
        projectNameTextField.layer.borderColor = UIColor.clear.cgColor
        projectNameTextField?.setPadding(left: padding)
        
        translateBtn.layer.cornerRadius = translateBtn.frame.size.width/2
        translateBtn.layer.cornerRadius = 10;
        translateBtn.clipsToBounds = false;
        
        translateTextField.layer.cornerRadius = 8.0
        translateTextField.layer.borderWidth = 2.0
        translateTextField.layer.borderColor = UIColor.clear.cgColor
        translateTextField?.setPadding(left: padding)
        
        dubbedBtn.layer.cornerRadius = dubbedBtn.frame.size.width/2
        dubbedBtn.layer.cornerRadius = 10;
        dubbedBtn.clipsToBounds = false;
        
        dubbedTextfield.layer.cornerRadius = 8.0
        dubbedTextfield.layer.borderWidth = 2.0
        dubbedTextfield.layer.borderColor = UIColor.clear.cgColor
        dubbedTextfield?.setPadding(left: padding)
        
        pasteLinkTextField.layer.cornerRadius = 8.0
        pasteLinkTextField.layer.borderWidth = 2.0
        pasteLinkTextField.layer.borderColor = UIColor.clear.cgColor
        pasteLinkTextField?.setPadding(left: padding)
        
        proceedBtn.layer.cornerRadius = proceedBtn.frame.size.width/2
        proceedBtn.layer.cornerRadius = 10;
        proceedBtn.layer.shadowOffset = CGSizeZero;
        proceedBtn.layer.shadowOpacity = 0.5;
        proceedBtn.clipsToBounds = false;
        
        guard let videoURL = videoURL else { return }
        
        let player = AVPlayer(url: videoURL)
        playerVC = AVPlayerViewController()
        playerVC.player = player
        
        addChild(playerVC)
        view.addSubview(playerVC.view)
        playerVC.view.frame = view.bounds
        playerVC.didMove(toParent: self)
        
        player.play()
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func proceedBtn_Action(_ sender: UIButton) {
        
    }
    
}
