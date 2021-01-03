//
//  ViewController.swift
//  benzin
//
//  Created by Александр Болотов on 04.12.2020.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    private var imageData: Data? {
        didSet {
            print(3)
            guard imageData != nil else {
                print(4)
                return
            }
            print(5)
            if let image = UIImage(data: imageData!) {
                print(6)
                imageView.image = image
            }
        }
    }
    private let urlString = "https://api.benzin.io/v1/removeBackground"
    
    @IBOutlet weak var responseLabel: UILabel!
    @IBOutlet weak var chooseImageButton: UIButton! {
        didSet {
            chooseImageButton.layer.cornerRadius = 7.0
            chooseImageButton.clipsToBounds = true
            print("didSet button")
        }
    }
    @IBOutlet weak var deleteBackgroundButton: UIButton! {
        didSet {
            deleteBackgroundButton.layer.cornerRadius = 7.0
            deleteBackgroundButton.clipsToBounds = true
        }
    }
    @IBOutlet weak var deleteBackgroundButton2: UIButton! {
        didSet {
            deleteBackgroundButton2.layer.cornerRadius = 7.0
            deleteBackgroundButton2.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var mkhj: Data?
    @IBAction func deleteBackground() {
        guard imageData != nil else {
            return
        }
        mkhj = removeBackgroundRequest(imageData: imageData!)
    }
    
    @IBAction func deleteBackgroundRemoveBG() {
        guard imageData != nil else {
            return
        }
        mkhj = removeBackground(imageData: imageData!)
    }
    
    
    @IBAction func chooseImage() {
        //        let cameraIcon = #imageLiteral(resourceName: "camera")  // image literal
        //        let imageIcon = #imageLiteral(resourceName: "photo")
        
        let actionSheet = UIAlertController(title: nil,message: nil, preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Camera", style: .default) { _ in
            self.chooseImagePicker(source: .camera)
        }
        //        camera.setValue(cameraIcon, forKey: "image")
        //        camera.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")
        
        let photo = UIAlertAction(title: "Photo", style: .default) { _ in
            self.chooseImagePicker(source: .photoLibrary)
        }
        //        photo.setValue(imageIcon, forKey: "image")
        //        photo.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        actionSheet.addAction(camera)
        actionSheet.addAction(photo)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true)
    }
    
    private func removeBackgroundRequest(imageData: Data) -> Data {
        
        imageView.image = UIImage(data: imageData)

        let header = HTTPHeader(name: "X-Api-Key", value: key) // заголовок запроса
        let headers = HTTPHeaders([header])

        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(self.imageView.image!.jpegData(compressionQuality: 0.5)!, withName: "image_file" , fileName: "1", mimeType: "1")

        },
            to: "https://api.benzin.io/v1/removeBackground", method: .post , headers: headers)
            .response { resp in
                debugPrint(resp)
                self.imageView.image = UIImage(data: resp.data!)
                self.responseLabel.text = resp.data?.description
       }
        
        return Data()
    }
    
    private func removeBackground(imageData: Data) -> Data {
        
        imageView.image = UIImage(data: imageData)

        let header = HTTPHeader(name: "X-Api-Key", value: "KBCDYxcCEiaA6Tq8YwWFgn1K") // заголовок запроса
        let headers = HTTPHeaders([header])

        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(self.imageView.image!.jpegData(compressionQuality: 0.5)!, withName: "image_file" , fileName: "1", mimeType: "1")

        },
            to: "https://api.remove.bg/v1.0/removebg", method: .post , headers: headers)
            .response { resp in
                debugPrint(resp)
                self.imageView.image = UIImage(data: resp.data!)
        }
        return Data()
    }
    
}

extension ViewController: UINavigationControllerDelegate {
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self // UINavigationControllerDelegate, UIImagePickerControllerDelegate
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            
            present(imagePicker, animated: true)
        }
    }
}
//
extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.editedImage] as? UIImage
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        imageData = (info[.editedImage] as? UIImage)?.pngData()
        
        //        imageIsChanged = true
        
        dismiss(animated: true)
    }
}

