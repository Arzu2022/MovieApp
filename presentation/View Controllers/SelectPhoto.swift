//
//  selectPhoto.swift
//  presentation
//
//  Created by AziK's  MAC on 24.09.22.
//
//
//import UIKit
//
//class SelectPhoto: UIViewController {
//
//    private weak var imageView: UIImageView!
//    private lazy var imagePicker: ImagePicker = {
//        let imagePicker = ImagePicker()
//        imagePicker.delegate = self
//        return imagePicker
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "camera", style: .plain, target: self,
//                                                           action: #selector(cameraButtonTapped))
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "photo", style: .plain, target: self,
//                                                           action: #selector(photoButtonTapped))
//
//        let imageView = UIImageView(frame: CGRect(x: 40, y: 80, width: 200, height: 200))
//        imageView.backgroundColor = .lightGray
//        view.addSubview(imageView)
//        self.imageView = imageView
//    }
//
//    @objc func photoButtonTapped(_ sender: UIButton) { imagePicker.photoGalleryAsscessRequest() }
//    @objc func cameraButtonTapped(_ sender: UIButton) { imagePicker.cameraAsscessRequest() }
//}
//
//// MARK: ImagePickerDelegate
//
//extension SelectPhoto: ImagePickerDelegate {
//
//    func imagePicker(_ imagePicker: ImagePicker, didSelect image: UIImage) {
//        imageView.image = image
//        imagePicker.dismiss()
//    }
//
//    func cancelButtonDidClick(on imageView: ImagePicker) { imagePicker.dismiss() }
//    func imagePicker(_ imagePicker: ImagePicker, grantedAccess: Bool,
//                     to sourceType: UIImagePickerController.SourceType) {
//        guard grantedAccess else { return }
//        imagePicker.present(parent: self, sourceType: sourceType)
//    }
//}
