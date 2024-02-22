//
//  RegisterVC.swift
//  Dubbly
//
//  Created by apple on 08/02/24.
//

import Foundation
import UIKit
import Toast
import SVProgressHUD

class RegisterVC: UIViewController {
    
    @IBOutlet weak var nameRegisterTextField: UITextField!
    @IBOutlet weak var emailRegisterTextField: UITextField!
    @IBOutlet weak var mobileRegisterTextField: UITextField!
    @IBOutlet weak var passRegisterTextField: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var gBtn: UIButton!
    @IBOutlet weak var fbBtn: UIButton!
    @IBOutlet weak var liBtn: UIButton!
    
    let padding: CGFloat = 30.0
    
    override func viewDidLoad() {
        
        nameRegisterTextField.layer.cornerRadius = 8.0
        nameRegisterTextField.layer.borderWidth = 2.0
        nameRegisterTextField.layer.borderColor = UIColor.clear.cgColor
        nameRegisterTextField?.setPadding(left: padding, right: padding)
        
        emailRegisterTextField.layer.cornerRadius = 8.0
        emailRegisterTextField.layer.borderWidth = 2.0
        emailRegisterTextField.layer.borderColor = UIColor.clear.cgColor
        emailRegisterTextField?.setPadding(left: padding)
        
        mobileRegisterTextField.layer.cornerRadius = 8.0
        mobileRegisterTextField.layer.borderWidth = 2.0
        mobileRegisterTextField.layer.borderColor = UIColor.clear.cgColor
        mobileRegisterTextField?.setPadding(left: padding)
        
        passRegisterTextField.layer.cornerRadius = 8.0
        passRegisterTextField.layer.borderWidth = 2.0
        passRegisterTextField.layer.borderColor = UIColor.clear.cgColor
        passRegisterTextField?.setPadding(left: padding)
        
        signUpBtn.layer.cornerRadius = signUpBtn.frame.size.width/2
        signUpBtn.layer.cornerRadius = 10;
        signUpBtn.clipsToBounds = false;
        
        gBtn.layer.borderWidth = 2
        gBtn.layer.masksToBounds = false
        gBtn.layer.borderColor = UIColor.clear.cgColor
        gBtn.layer.cornerRadius = gBtn.frame.height/2
        gBtn.clipsToBounds = true
        
        fbBtn.layer.borderWidth = 2
        fbBtn.layer.masksToBounds = false
        fbBtn.layer.borderColor = UIColor.clear.cgColor
        fbBtn.layer.cornerRadius = fbBtn.frame.height/2
        fbBtn.clipsToBounds = true
        
        liBtn.layer.borderWidth = 2
        liBtn.layer.masksToBounds = false
        liBtn.layer.borderColor = UIColor.clear.cgColor
        liBtn.layer.cornerRadius = liBtn.frame.height/2
        liBtn.clipsToBounds = true
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        self.nameRegisterTextField.resignFirstResponder()
        self.emailRegisterTextField.resignFirstResponder()
        self.mobileRegisterTextField.resignFirstResponder()
        self.passRegisterTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func signUpBtn_Action(_ sender: UIButton) {
        if let nameRegister = self.nameRegisterTextField.text, nameRegister.isEmpty{
            let alert = UIAlertController(title: "Alert", message: "Your Name is empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: {
                return
            })
        }else if let emailRegister = self.emailRegisterTextField.text, emailRegister.isEmpty {
            let alert = UIAlertController(title: "Alert", message: "Your Email is empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: {
                return
            })
        }else if let mobileRegister = self.mobileRegisterTextField.text, mobileRegister.isEmpty {
            let alert = UIAlertController(title: "Alert", message: "Enter Your mobile Number is empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: {
                return
            })
        }else if let passwordRegister = self.passRegisterTextField.text, passwordRegister.isEmpty {
            let alert = UIAlertController(title: "Alert", message: "Your Password is empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: {
                return
            })
        }
        
        
        guard let name = nameRegisterTextField.text,
            let email = emailRegisterTextField.text,
            let phone = mobileRegisterTextField.text,
            let password = passRegisterTextField.text else {
              return
          }
              signup(name: name, email: email, phone: phone, password: password)
//              signup(username: username, email: email, password: password)
        
//        guard let name = self.nameRegisterTextField.text else{return}
//        guard let email = self.emailRegisterTextField.text else{return}
//        guard let number = self.mobileRegisterTextField.text else{return}
//        guard let password = self.passRegisterTextField.text else{return}
////        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AboutVC") as! AboutVC
//        let register = RegisterModel(name: name, email: email, phone: number, password: password)
//        APIManager.sharedInstance.callingRegisterAPI(register: register){
//            (message) in
//            if message == ""{
////                self.navigationController?.pushViewController(vc, animated: true)
//                self.view.makeToast("Please Try Again")
//            }
//            else{
//                self.view.makeToast(message)
//            }
//        }
        
//        if let vc = storyboard?.instantiateViewController(withIdentifier: "AboutVC") {
//                navigationController?.pushViewController(vc, animated: true)
//            }
    }
    
    @IBAction func doYouHaveAccSignInBtn_Action(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") { 
                navigationController?.pushViewController(vc, animated: true)
            }
    }
    
    
    func signup(name: String, email: String, phone: String, password: String) {
          
            SVProgressHUD.show()
            var request = URLRequest(url: URL(string: BASE_URL)!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let requestBody: [String: Any] = [
                "name": name,
                "email": email,
                "phone": phone,
                "password": password
            ]

            guard let requestBodyData = try? JSONSerialization.data(withJSONObject: requestBody) else {
                
                SVProgressHUD.dismiss()

                return
            
            }

            request.httpBody = requestBodyData

            URLSession.shared.dataTask(with: request) { data, response, error in
               
                DispatchQueue.main.async {
                            SVProgressHUD.dismiss()
                        }
                
                if let error = error {
                    print("Error: \(error)")
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("HTTP Error")
                    return
                }

                if let data = data {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                        print("Response: \(jsonResponse)")
                    } catch {
                        print("JSON Error: \(error)")
                    }
                }
            }.resume()
        }
    
    
}
