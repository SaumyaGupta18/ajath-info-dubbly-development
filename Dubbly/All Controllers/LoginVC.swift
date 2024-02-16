//
//  ViewController.swift
//  Dubbly
//
//  Created by Shachish Sneh on 07/02/24.
//

import Foundation
import UIKit
import FBSDKLoginKit

//import GoogleSignIn


class LoginVC: UIViewController ,facebookBtnDelegate , GIDSignInDelegate {
    
    @IBOutlet weak var bacgoundImage: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var signInbtn: UIButton!
    @IBOutlet weak var googleBtn: UIButton!
    @IBOutlet weak var facebookBtn: UIButton!
    @IBOutlet weak var linkedInBtn: UIButton!
    @IBOutlet weak var starrtFrreeTrialBtn: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    let padding: CGFloat = 30.0
    //    let linkedinHelper = LinkedinSwiftHelper(configuration: LinkedinSwiftConfiguration(clientId: "YOUR_CLIENT_ID", clientSecret: "YOUR_CLIENT_SECRET", state: "YOUR_STATE", permissions: ["r_liteprofile", "r_emailaddress"], redirectUrl: "YOUR_REDIRECT_URL"))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // https://github.com/swift-aws/aws-sdk-swift.git
        emailTextField.layer.cornerRadius = 8.0
        emailTextField.layer.borderWidth = 2.0
        emailTextField.layer.borderColor = UIColor.clear.cgColor
        emailTextField?.setPadding(left: padding, right: padding)
        
        passTextField.layer.cornerRadius = 8.0
        passTextField.layer.borderWidth = 2.0
        passTextField.layer.borderColor = UIColor.clear.cgColor
        passTextField?.setPadding(left: padding, right: padding)
        
        signInbtn.layer.cornerRadius = signInbtn.frame.size.width/2
        signInbtn.layer.cornerRadius = 10;
        signInbtn.clipsToBounds = false;
        
        googleBtn.layer.borderWidth = 2
        googleBtn.layer.masksToBounds = false
        googleBtn.layer.borderColor = UIColor.clear.cgColor
        googleBtn.layer.cornerRadius = googleBtn.frame.height/2
        googleBtn.clipsToBounds = true
        
        facebookBtn.layer.borderWidth = 2
        facebookBtn.layer.masksToBounds = false
        facebookBtn.layer.borderColor = UIColor.clear.cgColor
        facebookBtn.layer.cornerRadius = facebookBtn.frame.height/2
        facebookBtn.clipsToBounds = true
        
        linkedInBtn.layer.borderWidth = 2
        linkedInBtn.layer.masksToBounds = false
        linkedInBtn.layer.borderColor = UIColor.clear.cgColor
        linkedInBtn.layer.cornerRadius = linkedInBtn.frame.height/2
        linkedInBtn.clipsToBounds = true
        
        starrtFrreeTrialBtn.layer.cornerRadius = starrtFrreeTrialBtn.frame.size.width/2
        starrtFrreeTrialBtn.layer.cornerRadius = 10;
        //        starrtFrreeTrialBtn.layer.shadowOffset = CGSizeZero;
        //        starrtFrreeTrialBtn.layer.shadowOpacity = 0.5;
        starrtFrreeTrialBtn.clipsToBounds = false;
        
//        GIDSignIn.sharedInstance().delegate = self
//        GIDSignIn.sharedInstance().presentingViewController = self
        
        if let token = AccessToken.current,
           !token.isExpired {
            // User is logged in, do work such as go to next view controller.
        }
        else{
            let facebookBtn = FBLoginButton()
            facebookBtn.center = view.center
            facebookBtn.delegate = self
            facebookBtn.permissions = ["public_profile", "email"]
              
            view.addSubview(facebookBtn)
        }
        

//
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        self.emailTextField.resignFirstResponder()
        self.passTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func signInBtn_Action(_ sender: UIButton) {
        if let textEmail = self.emailTextField.text, textEmail.isEmpty{
            let alert = UIAlertController(title: "Alert", message: "Your email is empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: {
                return
            })
        }else if let textPassword = self.passTextField.text, textPassword.isEmpty{
            let alert = UIAlertController(title: "Alert", message: "Your password is empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: {
                return
            })
        }
        
        guard let email = self.emailTextField.text else { return }
        guard let password = self.passTextField.text else { return }
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VideoVC") as! VideoVC
        let login = LoginModel(email: email, password: password)
        APIManager.sharedInstance.callLoginApi(login: login){
            (message) in
            print("Flag: \(message.flag)")
            print("Message: \(message.message)")
            
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
        
        //        if let vc = storyboard?.instantiateViewController(withIdentifier: "VideoVC") {
        //                navigationController?.pushViewController(vc, animated: true)
        //            }
    }
    
    
    @IBAction func forgetPassBtn_Action(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ForgetPasswordVC") {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func googleSignInBtn_Action(_ sender: UIButton) {
       // GIDSignIn.sharedInstance().signIn()
        
    }
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//        if let error = error {
//            print("Google sign in failed with error: \(error.localizedDescription)")
//            return
//        }
//        func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//            if let error = error {
//                print("Google sign in failed with error: \(error.localizedDescription)")
//                return
//            }
//            
            
    @IBAction func facebookSignInBtn_Action(_ facebookBtn: FBLoginButton, didCompleteWith result) {
//                let loginButton = FBLoginButton()
//                loginButton.center = view.center
//                view.addSubview(loginButton)
                

        }
        
        //    @IBAction func linkedInSignInBtn_Action(_ sender: UIButton) {
        //        linkedinHelper.authorizeSuccess({ (lsToken) in
        //             print("Login success with LinkedIn. Token: \(lsToken)")
        //         }, error: { (error) in
        //             print("Encountered error with LinkedIn login: \(error.localizedDescription)")
        //         }, cancel: {
        //             print("User cancelled LinkedIn login")
        //         })
        //    }
        
        @IBAction func starFreeTrialBtn_Action(_ sender: UIButton) {
            
        }
        
        @IBAction func doYouHaveAccBtn_Action(_ sender: UIButton) {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "RegisterVC") {
                navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    
    
    // Add this to the header of your file, e.g. in ViewController.swift
    
    // Add this to the body
//    class ViewController: UIViewController {
//        override func viewDidLoad() {
//            super.viewDidLoad()
//        
   //                 }
  //  }

    
    

