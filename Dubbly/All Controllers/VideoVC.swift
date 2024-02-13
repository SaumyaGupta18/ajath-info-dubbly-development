//
//  VideoVC.swift
//  Dubbly
//
//  Created by apple on 08/02/24.
//

import Foundation
import UIKit
import AVKit
import MobileCoreServices
import AWSS3

class VideoVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var uploadingURLTextfield: UITextField!
    
    var selectedVideoURL: URL?
    let imagePicker = UIImagePickerController()
    let padding: CGFloat = 30.0
    
    override func viewDidLoad() {
        
        uploadingURLTextfield.layer.cornerRadius = 8.0
        uploadingURLTextfield.layer.borderWidth = 2.0
        uploadingURLTextfield.layer.borderColor = UIColor.clear.cgColor
        uploadingURLTextfield?.setPadding(left: padding)
        
        imagePicker.delegate = self
    }
    
    @IBAction func bkBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func uploadOriginalVideo_Action(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
              imagePicker.sourceType = .photoLibrary
              imagePicker.mediaTypes = [kUTTypeMovie as String]
              present(imagePicker, animated: true, completion: nil)
          } else {
//              if let vc = storyboard?.instantiateViewController(withIdentifier: "UploadVideoFileVC") {
//                      navigationController?.pushViewController(vc, animated: true)
//                  }
              print("--------")
          }
    }
    
    @IBAction func sampleVideo_Action(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "UploadVideoFileVC") {
                navigationController?.pushViewController(vc, animated: true)
            }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let mediaURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
            selectedVideoURL = mediaURL
            uploadVideoToS3(mediaURL)
            dismiss(animated: true) {
                self.performSegue(withIdentifier: "showVideo", sender: self)
            }
        }
//        guard let mediaType = info[.mediaType] as? String else {
//            return
//        }

//        if mediaType == kUTTypeMovie as String {
//            if let videoURL = info[.mediaURL] as? URL {
//                // Use the videoURL
//                print("Selected video URL: \(videoURL)")
//            }
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showVideo" {
            if let destinationVC = segue.destination as? UploadVideoFileVC {
                destinationVC.videoURL = selectedVideoURL
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func uploadVideoToS3(_ videoURL: URL) {
        let expression = AWSS3TransferUtilityUploadExpression()
        expression.progressBlock = { (task, progress) in
            print("Upload Progress: \(progress.fractionCompleted * 100)%")
        }

        let transferUtility = AWSS3TransferUtility.default()
        let bucketName = "S3-bucket"
        let key = "videos/\(UUID().uuidString).mp4"

        transferUtility.uploadFile(videoURL,
                                   bucket: bucketName,
                                   key: key,
                                   contentType: "video/mp4",
                                   expression: expression) { (task, error) in
            if let error = error {
                print("Error uploading video: \(error.localizedDescription)")
                // Handle error
            } else {
                print("Video uploaded successfully!")
                // Handle success
            }
        }
    }

    func showPermissionDeniedAlert() {
        let alert = UIAlertController(title: "Permission Denied",
                                      message: "Please grant permission to access the photo library in settings.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func showPermissionNotDeterminedAlert() {
        let alert = UIAlertController(title: "Permission Not Determined",
                                      message: "Please grant permission to access the photo library in settings.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
}
