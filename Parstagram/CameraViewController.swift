//
//  CameraViewController.swift
//  Parstagram
//
//  Created by Guillermo Hernandez on 11/12/19.
//  Copyright © 2019 Guillermo Hernandez. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentField: UITextField!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onSubmit(_ sender: Any) {
        let post = PFObject(className: "Posts")
        self.loadingIndicator.startAnimating()
        
        post["caption"] = commentField.text!
        post["author"] = PFUser.current()!
        
        let imageData = imageView.image!.pngData() //reduced image
        let file = PFFileObject(data: imageData!) //binary object
        
        post["image"] = file
        post.saveInBackground { (success, error) in
            if success {
                print("Saved")
                self.loadingIndicator.stopAnimating()
                self.dismiss(animated: true, completion: nil)
            } else {
                print("There was an error: \(error!)")
                self.loadingIndicator.stopAnimating()
                let alertController = UIAlertController(title: "Post Error", message: "\(error!)", preferredStyle: .alert)

                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func onCamera(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        //Check to see if camera is available
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        self.present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }


}
