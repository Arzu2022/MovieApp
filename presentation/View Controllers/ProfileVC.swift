//
//  ProfileVC.swift
//  presentation
//
//  Created by AziK's  MAC on 07.09.22.
//

import UIKit
import FirebaseAuth

public class ProfileVC: BaseViewController<MovieViewModel> {
    private func moveProfileTologin(){
        let loginvc:UIViewController = self.router.loginVC()
        let tabBar = self.router.tabbarController()
        tabBar.navigationController?.viewControllers = [loginvc]
    }
    var auth = Auth.auth()
    var newUsername = "wrap"
    private lazy var settingBtn:UIButton = {
        let btn = UIButton()
        btn.setImage(Asset.icSetting.image, for: .normal)
        btn.addTarget(self, action: #selector(onClickSetting), for: .touchUpInside)
        return btn
    }()
    @objc func onClickSetting(){
        let alert = UIAlertController(title: "Settings", message: nil, preferredStyle: .alert)
        let btn1 = UIAlertAction(title: "About Us", style: .default){ (action) in
            if let url = URL(string: "https://instagram.com/Heydarov.21?igshid=YmMyMTA2M2Y"){
                UIApplication.shared.open(url)
            }
        }
        alert.addAction(btn1)
        
        let btn2 = UIAlertAction(title: "Delete User", style: .default){ (action) in
            self.auth.currentUser?.delete(completion: { error in
                if let error = error {
                    self.makeAlert(title: "Error", message: error.localizedDescription)
                }
                else{
                    self.moveProfileTologin()
                    self.showToast(message: "Deleted successfully", seconds: 2.3)
                }
            })
        }
        alert.addAction(btn2)
        let btn3 = UIAlertAction(title: "Sign Out", style: .default){ (action) in
            do {
                try self.auth.signOut()
                self.moveProfileTologin()
                self.showToast(message: "Signed out successfully", seconds: 2.3)
                }
            catch {
                self.makeAlert(title: "Error!", message: error.localizedDescription)
            }
        }
        alert.addAction(btn3)
        
        let btn4 = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(btn4)
        
        self.present(alert, animated: true)
    }
    private lazy var editProfile:UIButton = {
        let btn = UIButton()
        btn.setTitle("Edit Profile", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(onClickEditProfile), for: .touchUpInside)
        return btn
    }()
    @objc func onClickEditProfile(){
        let alert = UIAlertController(title: "Edit", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Add new username"
            textField.addTarget(self, action: #selector(self.textFieldDidChange(_ :)), for: .editingChanged)
        }
        let btn1 = UIAlertAction(title: "Change Username", style: .default) { (action) in
            let changeDisplay = self.auth.currentUser?.createProfileChangeRequest()
            changeDisplay?.displayName = self.newUsername
            changeDisplay?.commitChanges { error in
                if let error = error {
                    self.makeAlert(title: "Error", message: error.localizedDescription)
                } else {
                    self.auth = Auth.auth()
                    self.username.text = self.auth.currentUser?.displayName
                }
            }
        }
        alert.addAction(btn1)
        let btn2 = UIAlertAction(title: "Change Password", style: .default){ (action) in
            self.auth.sendPasswordReset(withEmail: (self.auth.currentUser?.email)!) { error in
                if let error = error {
                    self.makeAlert(title: "Error", message: error.localizedDescription)
                }else {
                    self.moveProfileTologin()
                    self.showToast(message: "Password changed successfully", seconds: 2.3)
                }
            }
        }
        alert.addAction(btn2)
        let btn3 = UIAlertAction(title: "Change Image", style: .default){ (action) in
            //next time
            
            
        }
        alert.addAction(btn3)
        let btn4 = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(btn4)
        self.present(alert, animated: true)
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text?.isEmpty == false {
            self.newUsername = textField.text!
        }
        }
    private lazy var username:UILabel = {
        let text = UILabel()
        text.text = auth.currentUser?.displayName
        text.font = UIFont(font: FontFamily.PTSans.regular, size: 20)
        text.textColor = .black
        return text
    }()
    private lazy var profileImage:UIImageView = {
        let image = UIImageView()
        //image.image = From Storage
        image.image = Asset.icEmpty.image
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 30
        return image
    }()
    private lazy var bio:UILabel = {
        let text = UILabel()
        text.text = "From Firestore"
        text.font = UIFont(font: FontFamily.PTSans.regular, size: 16)
        text.textColor = .darkGray
        return text
    }()
    private lazy var numberOfLikedMovie:UILabel = {
        let text = UILabel()
        text.text = "From Firestore-Liked"
        text.font = UIFont(font: FontFamily.PTSans.regular, size: 18)
        text.textColor = .darkGray
        return text
    }()
    private lazy var tableForLiked:UITableView = {
        let view = UITableView()
        
        return view
    }()
    override init(vm: MovieViewModel, router: RouterProtocol) {
        super.init(vm: vm, router: router)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setup()
        
    }
    func makeAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let btn = UIAlertAction(title: "OK", style: .default)
        alert.addAction(btn)
        self.present(alert, animated: true)
    }
    private func setup(){
        self.title = "Profile Page"
        self.view.addSubview(settingBtn)
        self.view.addSubview(username)
        self.view.addSubview(bio)
        self.view.addSubview(profileImage)
        self.view.addSubview(numberOfLikedMovie)
        self.view.addSubview(editProfile)
        self.view.addSubview(tableForLiked)
        profileImage.snp.makeConstraints { make in
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(12)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.width.height.equalTo(60)
        }
        username.snp.makeConstraints { make in
            make.left.equalTo(self.profileImage.safeAreaLayoutGuide.snp.right).offset(6)
            make.top.equalTo(self.profileImage.safeAreaLayoutGuide.snp.top).offset(4)
        }
        bio.snp.makeConstraints { make in
            make.left.equalTo(self.username.safeAreaLayoutGuide.snp.left)
            make.top.equalTo(self.username.safeAreaLayoutGuide.snp.bottom).offset(3)
        }
        settingBtn.snp.makeConstraints { make in
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-12)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.height.width.equalTo(20)
        }
        editProfile.snp.makeConstraints { make in
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(12)
            make.top.equalTo(self.profileImage.safeAreaLayoutGuide.snp.bottom).offset(6)
        }
        numberOfLikedMovie.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.safeAreaLayoutGuide.snp.centerX)
            make.top.equalTo(self.editProfile.safeAreaLayoutGuide.snp.bottom).offset(6)
        }
        tableForLiked.snp.makeConstraints { make in
            make.top.equalTo(self.numberOfLikedMovie.safeAreaLayoutGuide.snp.bottom).offset(6)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(12)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-12)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
