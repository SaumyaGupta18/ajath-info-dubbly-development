//
//  MusicVC.swift
//  Dubbly
//
//  Created by SHASHI'S MAC on 10/02/24.
//

import Foundation
import UIKit

class MusicVC: UIViewController {
    
    @IBOutlet weak var pasteUrlTxtField: UITextField!
    @IBOutlet weak var extractSoundFromVideo: UIButton!
    
    let padding: CGFloat = 30.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pasteUrlTxtField.layer.cornerRadius = 8.0
        pasteUrlTxtField.layer.borderWidth = 2.0
        pasteUrlTxtField.layer.borderColor = UIColor.clear.cgColor
        pasteUrlTxtField?.setPadding(left: padding, right: padding)
        
        extractSoundFromVideo.layer.cornerRadius = extractSoundFromVideo.frame.size.width/2
        extractSoundFromVideo.layer.cornerRadius = 10;
        extractSoundFromVideo.clipsToBounds = false;
        
    }
    
    @IBAction func extractSoundFromVideoBtn_Action(_ sender: UIButton) {
        
    }
    
    @IBAction func localMusicBtn_Action(_ sender: UIButton) {
    }
    
    @IBAction func extractAudio(_ sender: UIButton) {
    }
    
}
