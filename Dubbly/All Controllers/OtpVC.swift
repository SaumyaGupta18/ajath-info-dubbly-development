//
//  OtpVC.swift
//  Dubbly
//
//  Created by apple on 08/02/24.
//

import Foundation
import UIKit

class OtpVC: UIViewController {
    
    @IBOutlet weak var otp1: UITextField!
    @IBOutlet weak var otp2: UITextField!
    @IBOutlet weak var otp3: UITextField!
    @IBOutlet weak var otp4: UITextField!
    @IBOutlet weak var continueBtn: UIButton!
    
    let padding: CGFloat = 30.0
    var email: String?
    
    override func viewDidLoad() {
        
        otp1.layer.cornerRadius = 8.0
        otp1.layer.borderWidth = 2.0
        otp1.layer.borderColor = UIColor.clear.cgColor
        otp1?.setPadding(left: padding)
        
        otp2.layer.cornerRadius = 8.0
        otp2.layer.borderWidth = 2.0
        otp2.layer.borderColor = UIColor.clear.cgColor
        otp2?.setPadding(left: padding)
        
        otp3.layer.cornerRadius = 8.0
        otp3.layer.borderWidth = 2.0
        otp3.layer.borderColor = UIColor.clear.cgColor
        otp2?.setPadding(left: padding)
        
        otp4.layer.cornerRadius = 8.0
        otp4.layer.borderWidth = 2.0
        otp4.layer.borderColor = UIColor.clear.cgColor
        otp2?.setPadding(left: padding)
        
        continueBtn.layer.cornerRadius = continueBtn.frame.size.width/2
        continueBtn.layer.cornerRadius = 10;
        continueBtn.clipsToBounds = false;
    }
    
    @IBAction func backBtn_Action(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func contueBtn_Action(_ sender: UIButton) {
        let otp = (self.otp1.text! as NSString).intValue
        
        let verify = VerifyModel(email: email!, otp: Int(otp))
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "Reset") else { return }
        APIManager.sharedInstance.OTPVerify(verify: verify){
            (message) in
            if message.flag == 0 {
                self.view.makeToast(message.message, duration: 5.0)
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            else if message.flag == 1 {
                self.view.makeToast(message.message, duration: 5.0)
            }
            else{
                self.view.makeToast("Please Try Again")
            }
        }
        
//        if let vc = storyboard?.instantiateViewController(withIdentifier: "ResetPasswordVC") {
//                navigationController?.pushViewController(vc, animated: true)
//            }
    }
    
    
}
