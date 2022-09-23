//
//  ProfileVC.swift
//  presentation
//
//  Created by AziK's  MAC on 07.09.22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import domain

public class ProfileVC: BaseViewController<MovieViewModel> {
    var auth = Auth.auth()
    let db = Firestore.firestore()
    var newUsername = "wrap"
    let baseImageUrl = "https://image.tmdb.org/t/p/w500"
    var dataForSaved : [MovieEntity.ResultEntity] = []
    func getDataFromDB(){
        db.collection("save_\(auth.currentUser?.uid ?? "save_WAJAxzk8eEZD22FYdFkohronlRR6")").getDocuments() { (querySnapshot, err) in
            if let err = err {
                self.makeAlert(title: "Error", message: err.localizedDescription)
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let q = MovieEntity.ResultEntity(adult: data["adult"] as? Bool ?? true, backdropPath: data["backdropPath"] as? String ?? "", genreIDS: data["genreIDS"] as? [Int] ?? [], id: data["id"] as! Int, originalLanguage: data["originalLanguage"] as? String ?? "", originalTitle: data["originalTitle"] as? String ?? "", overview: data["overview"] as? String ?? "", popularity: data["popularity"] as? Double ?? 0.0, posterPath: data["posterPath"] as? String ?? "", video: data["video"] as? Bool ?? false, releaseDate: data["releaseDate"] as? String ?? "", title: data["title"] as? String ?? "", voteAverage: data["voteAverage"] as? Double ?? 0.0, voteCount: (data["voteCount"] as? Int ?? 0))
                    self.dataForSaved.append(q)
                    self.tableForLiked.reloadData()
                }
            }
        }
    }
    private func moveProfileTologin(){
        let loginvc:UIViewController = self.router.loginVC()
        let tabBar = self.router.tabbarController()
        tabBar.navigationController?.viewControllers = [loginvc]
    }
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
        btn.setTitleColor(UIColor.blue, for: .normal)
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
        ////////////////
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
        text.font = UIFont.systemFont(ofSize: 20, weight: .bold)
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
    private lazy var savedMovie:UILabel = {
        let text = UILabel()
        text.text = "Saved Movies"
        text.font = UIFont(font: FontFamily.PTSans.regular, size: 18)
        text.textColor = .black
        return text
    }()
    private lazy var tableForLiked:UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(CustomHomeVCTableViewCell.self, forCellReuseIdentifier: "cell")
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
        view.backgroundColor = .white
        //getDataFromDB()
        setup()
       // AppLoader.instance.showLoaderView()
    }
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataForSaved = []
        getDataFromDB()
        //setup()
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
        self.view.addSubview(profileImage)
        self.view.addSubview(savedMovie)
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
        settingBtn.snp.makeConstraints { make in
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-12)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.height.width.equalTo(20)
        }
        editProfile.snp.makeConstraints { make in
            make.left.equalTo(self.username.safeAreaLayoutGuide.snp.left)
            make.top.equalTo(self.username.safeAreaLayoutGuide.snp.bottom).offset(3)
        }
        savedMovie.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.safeAreaLayoutGuide.snp.centerX)
            make.top.equalTo(self.editProfile.safeAreaLayoutGuide.snp.bottom).offset(6)
        }
        tableForLiked.snp.makeConstraints { make in
            make.top.equalTo(self.savedMovie.safeAreaLayoutGuide.snp.bottom).offset(6)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(12)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-12)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
extension ProfileVC:UITableViewDelegate,UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataForSaved.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        as! CustomHomeVCTableViewCell
        let tapComment = UITapGestureRecognizer(target: self, action: #selector(onClickComment(_:)))
        let tapLike = UITapGestureRecognizer(target: self, action: #selector(onClickLike(_ :)))
         lazy var commentIcon:UIImageView = {
                let image = UIImageView()
                image.image = Asset.icComment.image
                image.addGestureRecognizer(tapComment)
                image.isUserInteractionEnabled = true
                tapComment.numberOfTapsRequired = 1
                return image
            }()
         lazy var saveIcon:UIImageView = {
                let image = UIImageView()
                image.addGestureRecognizer(tapLike)
                image.isUserInteractionEnabled = true
                tapComment.numberOfTapsRequired = 1
                image.image = Asset.icSaved.image
                return image
            }()
        cell.backgroundColor = .systemBackground
                let url = "\(self.baseImageUrl)\((self.dataForSaved[indexPath.row].backdropPath) ?? "/kXfqcdQKsToO0OUXHcrrNCHDBzO.jpg")"
                cell.backdropPath.imageFromServerURL(url, placeHolder:nil)
                cell.title.text = self.dataForSaved[indexPath.row].title
        cell.addSubview(saveIcon)
        cell.addSubview(commentIcon)
        
        saveIcon.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(25)
            make.width.equalTo(30)
    }
        commentIcon.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-10)
            make.height.width.equalTo(25)
    }
        return cell
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        AppLoader.instance.showLoaderView()
        let vc = self.router.detailsVC(allData: dataForSaved[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
        AppLoader.instance.hideLoaderView()
        
    }
    @objc func onClickComment(_ sender:UITapGestureRecognizer){
        print("clicked to comment")
}
    @objc func onClickLike(_ sender:UITapGestureRecognizer){
        var db = Firestore.firestore()
        var auth = Auth.auth().currentUser
        print("collectionID = \(db.collection("save_\(auth?.uid ?? "")").collectionID)")
//        self.db.collection("SaleOrders").whereField("orderid", isEqualTo: "ji20190205091948").getDocuments
        
//        db.collection("save_\(auth?.uid ?? "")").document("").delete() { err in
//            if let err = err {
//              self.makeAlert(title: "Error", message: err.localizedDescription)
//            } else {
//                let db = Firestore.firestore()
//                auth = Auth.auth().currentUser
//                self.getDataFromDB()
//                self.showToast(message: "Document successfully removed!", seconds: 1.2)
//
//            }
//        }
    }

    }
