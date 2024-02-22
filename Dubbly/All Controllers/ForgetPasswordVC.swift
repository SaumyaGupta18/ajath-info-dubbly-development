//
//  ForgetPasswordVC.swift
//  Dubbly
//
//  Created by apple on 08/02/24.
//

import Foundation
import UIKit
import SVProgressHUD

class ForgetPasswordVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var continueBtn: UIButton!
    
    let padding: CGFloat = 30.0
    
    override func viewDidLoad() {
        
        emailTextField.layer.cornerRadius = 8.0
        emailTextField.layer.borderWidth = 2.0
        emailTextField.layer.borderColor = UIColor.clear.cgColor
        emailTextField?.setPadding(left: padding)
        
        continueBtn.layer.cornerRadius = continueBtn.frame.size.width/2
        continueBtn.layer.cornerRadius = 10;
        continueBtn.clipsToBounds = false;
    }
    
    @IBAction func backBtn_Action(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func continueBtn_Action(_ sender: UIButton) {
        SVProgressHUD.show()
        guard let email = self.emailTextField.text else { return }
        let forgetPassword = ForgetPasswordModel(email: email)
        let vc = (self.storyboard?.instantiateViewController(withIdentifier: "OtpVC") as! OtpVC)
        vc.email = email
        APIManager.sharedInstance.ForgotPassword(forgetPassword: forgetPassword){[weak self] message in
            // Hide loading indicator
            SVProgressHUD.dismiss()
            //(message) in
            if message.flag == 0 {
                let alert = UIAlertController(title: "OTP", message: "You OTP is \(message.message)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Close", comment: "This closes alert"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                    
                    //self.navigationController?.pushViewController(vc,
                    // animated: true)
//                }))
//                self.present(alert, animated: true)
//                
//            }
//            else if message.flag == 1 {
//                self.view.makeToast(message.message, duration: 5.0)
//            }
//            else{
//                self.view.makeToast("Please Try Again")
//            }
//        }
        if let navigationController = self?.navigationController {
                navigationController.pushViewController(vc, animated: true)
            } else {
            print("Error: Unable to push view controller. Navigation controller is nil.")
                }
                    }))
                    self?.present(alert, animated: true)
                } else if message.flag == 1 {
                    self?.view.makeToast(message.message, duration: 5.0)
                } else {
                self?.view.makeToast("Please Try Again")
                    }
              }
        }
        
//        if let vc = storyboard?.instantiateViewController(withIdentifier: "OtpVC") {
//                navigationController?.pushViewController(vc, animated: true)
//            }
    }
    
    
    
//}
