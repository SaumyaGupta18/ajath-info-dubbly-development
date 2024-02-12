//
//  ResetPasswordVC.swift
//  Dubbly
//
//  Created by SHASHI'S MAC on 10/02/24.
//

import Foundation
import UIKit

class ResetPasswordVC: UIViewController {
    
    @IBOutlet weak var newPassTxtfield: UITextField!
    @IBOutlet weak var confirmTxtField: UITextField!
    @IBOutlet weak var resetPassBtn: UIButton!
    
    let padding: CGFloat = 30.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newPassTxtfield.layer.cornerRadius = 8.0
        newPassTxtfield.layer.borderWidth = 2.0
        newPassTxtfield.layer.borderColor = UIColor.clear.cgColor
        newPassTxtfield?.setPadding(left: padding, right: padding)
        
        confirmTxtField.layer.cornerRadius = 8.0
        confirmTxtField.layer.borderWidth = 2.0
        confirmTxtField.layer.borderColor = UIColor.clear.cgColor
        confirmTxtField?.setPadding(left: padding, right: padding)
        
        resetPassBtn.layer.cornerRadius = resetPassBtn.frame.size.width/2
        resetPassBtn.layer.cornerRadius = 10;
        resetPassBtn.clipsToBounds = false;
        
    }
    
    @IBAction func bkBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resetPassBtn_Action(_ sender: UIButton) {
        let newPassword = self.newPassTxtfield.text
        let confirmPassword = self.confirmTxtField.text
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        let passwordChange = ResetModel(password: confirmPassword!)
        if newPassword == confirmPassword{
            APIManager.sharedInstance.ResetPass(reset: passwordChange){
                (message) in
                if message.flag == 0 {
                    self.view.makeToast(message.message, duration: 5.0)
                    self.navigationController?.pushViewController(vc,
                     animated: true)
                }
                else if message.flag == 1 {
                    self.view.makeToast(message.message, duration: 5.0)
                }
                else{
                    self.view.makeToast("Please Try Again")
                }
            }
        }
    }
}
