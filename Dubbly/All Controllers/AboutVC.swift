//
//  AboutVC.swift
//  Dubbly
//
//  Created by Shachish Sneh on 07/02/24.
//

import Foundation
import UIKit

class AboutVC: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var roleTextfield: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var tick1: UIButton!
    @IBOutlet weak var tick2: UIButton!
    @IBOutlet weak var ceateAccountBtn: UIButton!
    
   // var countryCodes = [[String]]()
    let padding: CGFloat = 30.0
    let countries = ["India", "Canada", "UK", "Australia", "Germany", "France", "Kanada", "Canada", "UK", "Australia", "Germany", "France","USA", "Canada", "UK", "Australia", "Germany", "France", "USA", "Canada", "UK", "Australia", "Germany", "France"]
    var selectedCountry: String?

    override func viewDidLoad() {
        
        nameTextField.layer.cornerRadius = 8.0
        nameTextField.layer.borderWidth = 2.0
        nameTextField.layer.borderColor = UIColor.clear.cgColor
        nameTextField?.setPadding(left: padding)
        
        roleTextfield.layer.cornerRadius = 8.0
        roleTextfield.layer.borderWidth = 2.0
        roleTextfield.layer.borderColor = UIColor.clear.cgColor
        nameTextField?.setPadding(left: padding)
        
        ageTextField.layer.cornerRadius = 8.0
        ageTextField.layer.borderWidth = 2.0
        ageTextField.layer.borderColor = UIColor.clear.cgColor
        nameTextField?.setPadding(left: padding)
        
        countryTextField.layer.cornerRadius = 8.0
        countryTextField.layer.borderWidth = 2.0
        countryTextField.layer.borderColor = UIColor.clear.cgColor
        nameTextField?.setPadding(left: padding)
        
        tick1.layer.cornerRadius = tick1.frame.size.width/2
        tick1.layer.cornerRadius = 10;
        tick1.clipsToBounds = false;
        
        tick2.layer.cornerRadius = tick2.frame.size.width/2
        tick2.layer.cornerRadius = 10;
        tick2.clipsToBounds = false;
        
        ceateAccountBtn.layer.cornerRadius = ceateAccountBtn.frame.size.width/2
        ceateAccountBtn.layer.cornerRadius = 10;
        ceateAccountBtn.layer.shadowOffset = CGSizeZero;
        ceateAccountBtn.layer.shadowOpacity = 0.5;
        ceateAccountBtn.clipsToBounds = false;
        
        
        let pickerView = UIPickerView()
            pickerView.delegate = self
            pickerView.dataSource = self

            countryTextField.inputView = pickerView

            let toolbar = UIToolbar()
            toolbar.barStyle = .default
            toolbar.isTranslucent = true
            toolbar.tintColor = .black
            toolbar.sizeToFit()

            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePicker))
            toolbar.setItems([doneButton], animated: false)
            toolbar.isUserInteractionEnabled = true
            countryTextField.inputAccessoryView = toolbar
    }
    
    @objc func donePicker() {
            countryTextField.resignFirstResponder()
        }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        self.nameTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func createAccBtn_Action(_ sender: UIButton) {
        if let name = self.nameTextField.text, name.isEmpty{
            let alert = UIAlertController(title: "Alert", message: "Your name is empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: {
                return
            })
        }else{
//            let alert = UIAlertController(title: "Alert", message: "Your password is empty", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        }
//        
//        guard let name = self.nameTextField.text else{return}
//        guard let role = self.roleTextfield.text else{return}
//        guard let age = self.ageTextField.text else{return}
//        guard let country = self.countryTextField.text else{return}
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VideoVC") as! VideoVC
//        let about = AboutModel(name: name, role: role, age: age, country: country)
//        APIManager.sharedInstance.callingAboutAPI(about: about){
//            (message) in
//            if message == ""{
//                self.navigationController?.pushViewController(vc,
//                 animated: true)
//                self.view.makeToast("Please Try Again")
//            }
//            else{
//                self.view.makeToast(message)
//            }
//        }
        
//        if let vc = storyboard?.instantiateViewController(withIdentifier: "VideoVC") {
//                navigationController?.pushViewController(vc, animated: true)
//            }
    }
    
    @IBAction func bckBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension AboutVC : UIPickerViewDelegate,  UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count

    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row]

    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCountry = countries[row]
                countryTextField.text = selectedCountry
    }
    
}
