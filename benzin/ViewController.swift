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
            imageView.image = UIImage(data: imageData!)
        }
    }
    private let urlString = "https://api.benzin.io/v1/removeBackground"
    
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
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func deleteBackground() {
        imageData = removeBackground(imageData: imageData!)
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
    
    private func removeBackground(imageData: Data) -> Data {
        
        
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

