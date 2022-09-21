//
//  ProfileVC.swift
//  presentation
//
//  Created by AziK's  MAC on 07.09.22.
//

import UIKit
import FirebaseAuth

public class ProfileVC: BaseViewController<MovieViewModel> {
    let auth = Auth.auth()
    
    private lazy var signOutBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("Sigout", for: .normal)
        btn.addTarget(self, action: #selector(onClickSignout), for: .touchUpInside)
        return btn
    }()
    @objc func onClickSignout(){
        do {
            try auth.signOut()
            let loginvc:UIViewController = self.router.loginVC()
            let tabBar = self.router.tabbarController()
            tabBar.navigationController?.viewControllers = [loginvc]
//            tabBar.navigationController?.isNavigationBarHidden = true
//            tabBar.navigationController?.pushViewController(loginvc, animated: true)
        } catch {
            makeAlert(title: "Error!", message: error.localizedDescription)
        }
    }
    private lazy var username:UILabel = {
        let text = UILabel()
        text.text = auth.currentUser?.displayName
        text.font = UIFont(font: FontFamily.PTSans.regular, size: 30)
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
        //view.backgroundColor = .blue
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
        self.view.addSubview(signOutBtn)
        self.view.addSubview(username)
        self.view.addSubview(bio)
        self.view.addSubview(profileImage)
        self.view.addSubview(numberOfLikedMovie)
        self.view.addSubview(tableForLiked)
        profileImage.snp.makeConstraints { make in
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(16)
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
        signOutBtn.snp.makeConstraints { make in
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-16)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        numberOfLikedMovie.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.safeAreaLayoutGuide.snp.centerX)
            make.top.equalTo(self.profileImage.safeAreaLayoutGuide.snp.bottom).offset(6)
        }
        tableForLiked.snp.makeConstraints { make in
            make.top.equalTo(self.numberOfLikedMovie.safeAreaLayoutGuide.snp.bottom).offset(6)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(16)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-16)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }

}
