//
//  CommentVC.swift
//  presentation
//
//  Created by AziK's  MAC on 23.09.22.
//
import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
public struct CommentStruct{
    var name:String
    var comment:String
    var imageURL:String
    public init(name:String,comment:String,imageURL:String) {
        self.name = name
        self.comment = comment
        self.imageURL = imageURL
    }
}
public func getImageFromFB(completion:@escaping (UIImage)->()) {
    let db = Firestore.firestore()
    let auth = Auth.auth().currentUser
    let imageV = UIImageView()
    db.collection("UserProfileImages").document("\((auth?.email) ?? "empty")").getDocument { (query, error) in
        if let error = error {
            print("error: \(error)")
        } else {
            let data = query?.data()
            if let t = data?["imageUrl"] as? String {
                do {
                    let d = try Data(contentsOf: URL(string:t)!)
                        imageV.image = UIImage(data: d)
                        print(imageV.image)
                } catch {
                    print(error)
                }
            }
            completion(imageV.image ?? Asset.icEmpty.image)
        }
    }
}
public var dataForComment: [CommentStruct] = []
public class CommentVC: UIViewController {
    var db = Firestore.firestore()
    var auth = Auth.auth().currentUser
    private lazy var tableView:UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(CustomCommentTableViewCell.self, forCellReuseIdentifier: "cell")
        return view
    }()
    private lazy var textFiel:UITextField = {
        let text = UITextField()
        text.placeholder = "Add comment"
        text.layer.borderWidth = 1
        text.layer.masksToBounds = true
        text.layer.cornerRadius = 10
        text.textColor = .black
        text.autocapitalizationType = .none
        text.autocorrectionType = .no
        text.layer.borderColor = UIColor.gray.cgColor
        text.textAlignment = .left
        text.addPaddingToTextField()
        text.font = UIFont(font: FontFamily.PTSans.regular, size: 17)
        return text
    }()
    private lazy var btnPost:UIButton = {
        let text = UIButton()
        text.backgroundColor = .blue
        text.setTitle("Post", for: .normal)
        text.layer.masksToBounds = true
        text.layer.cornerRadius = 10
        text.setTitleColor(UIColor.white, for: .normal)
        text.addTarget(self, action: #selector(onClickSignup), for: .touchUpInside)
        return text
    }()
    func getURLofImage(completion:@escaping (String)->()){
        self.auth = Auth.auth().currentUser
        var imageUrl = ""
        let storage = Storage.storage()
        let refStorage = storage.reference()
        let fileRef = refStorage.child("images/\(auth?.email ?? "empty").jpg") ?? refStorage.child("images/empty.jpg")
           fileRef.downloadURL { url, error in
                   if error == nil {
                       imageUrl = url!.absoluteString
                       completion(imageUrl)
                   }
           }
    }
    @objc func onClickSignup() {
        if textFiel.text?.isEmpty == true{
            self.showToast(message: "Please, add comment before post", seconds: 2.0)
        }
        else {
         db = Firestore.firestore()
         auth = Auth.auth().currentUser
         var ref: DocumentReference? = nil
            getURLofImage { url in
                ref = self.db.collection("comment").addDocument(data: [
                     "id" : checkID,
                     "name": self.auth?.displayName ?? "auth is not exist",
                     "comment": self.textFiel.text!,
                     "imageurl": url,
                     "time": Date.now
                 ]) { [weak self] err in
                     guard let self = self else { return }
                     if let err = err {
                         self.makeAlert(title: "Error", message: err.localizedDescription)
                     }
                     else {
                         self.showToast(message: "Posted succesfully", seconds: 1.8)
                             let t = CommentStruct(name: (self.auth?.displayName!)!, comment: self.textFiel.text!, imageURL: url)
                             dataForComment.append(t)
                             self.textFiel.text = ""
                             self.dismiss(animated: true)
                     }
                 }
            }
        }
    }
    
    public init(data:[CommentStruct]) {
        dataForComment = data
        super.init(nibName: nil, bundle: nil)
    }
    public init(){
        super.init(nibName: nil, bundle: nil)
    }
    required init(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        dataForComment = []
        checkRow = 0
        setup()
    }
    private func setup(){
        self.view.addSubview(textFiel)
        self.view.addSubview(btnPost)
        self.view.addSubview(tableView)
        btnPost.snp.makeConstraints { make in
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(40)
            make.width.equalTo(60)
        }
        textFiel.snp.makeConstraints { make in
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.right.equalTo(btnPost.snp.left).offset(15)
            make.height.equalTo(40)
        }
        tableView.snp.makeConstraints { make in
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(6)
            make.bottom.equalTo(btnPost.snp.top)
        }
        
    }
}
extension CommentVC:UITableViewDelegate,UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataForComment.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCommentTableViewCell
        
        do {
            let data = try Data(contentsOf: URL(string: dataForComment[indexPath.row].imageURL)!)
            cell.imageP.image = UIImage(data: data)
            cell.name.text = dataForComment[indexPath.row].name
            cell.comment.text = dataForComment[indexPath.row].comment
        } catch {
            self.makeAlert(title: "Error", message: error.localizedDescription)
        }
        return cell
        }
    func makeAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let btn = UIAlertAction(title: "OK", style: .default)
        alert.addAction(btn)
        self.present(alert, animated: true)
    }
}

