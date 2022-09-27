//
//  SearchVC.swift
//  presentation
//
//  Created by AziK's  MAC on 07.09.22.
//

import UIKit
import domain
import FirebaseFirestore
import FirebaseAuth
public class SearchVC: BaseViewController<MovieViewModel> {
    var dataForTableView: [MovieEntity.ResultEntity] = []
    let baseImageUrl = "https://image.tmdb.org/t/p/w500"
    let db = Firestore.firestore()
    let auth = Auth.auth().currentUser
    private lazy var tableView:UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(CustomHomeVCTableViewCell.self, forCellReuseIdentifier: "cell")
        return view
    }()
    private var searchBar: UISearchController = {
           let sb = UISearchController()
           sb.searchBar.placeholder = "Enter the movie name"
           sb.searchBar.searchBarStyle = .minimal
           return sb
       }()
    override init(vm: MovieViewModel, router: RouterProtocol) {
        checkRow = 0
        dataForComment = []
        super.init(vm: vm, router: router)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        checkRow = 0
        dataForComment = []
        setup()
    }
    private func setup(){
        self.title = "Search Page"
        self.view.addSubview(tableView)
        searchBar.searchResultsUpdater = self
        navigationItem.searchController = searchBar
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.bottom.equalToSuperview()
        }
    }
    
}
extension SearchVC:UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource {
    func makeAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let btn = UIAlertAction(title: "OK", style: .default)
        alert.addAction(btn)
        self.present(alert, animated: true)
    }
    public func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text != "" {
            if searchController.searchBar.text != " " {
                let text = searchController.searchBar.text ?? "q"
                self.vm.getMovie(typeOfMovie: text).then { m in
                    self.dataForTableView = m.results!
                    self.tableView.reloadData()
                    }
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataForTableView.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomHomeVCTableViewCell
        let tapComment = UITapGestureRecognizer(target: self, action: #selector(onClickComment(_ :)))
                
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
        cell.addSubview(saveIcon)
        cell.addSubview(commentIcon)
                let url = "\(self.baseImageUrl)\((self.dataForTableView[indexPath.row].backdropPath) ?? "/kXfqcdQKsToO0OUXHcrrNCHDBzO.jpg")"
                cell.backdropPath.imageFromServerURL(url, placeHolder:nil)
                cell.title.text = self.dataForTableView[indexPath.row].title
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
    @objc func onClickComment(_ sender:UITapGestureRecognizer){
        dataForComment = []
        db.collection("comment").getDocuments() { (querySnapshot, err) in
            if let err = err {
                self.makeAlert(title: "Error", message: err.localizedDescription)
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    if data["id"] as! Int == checkID {
                        let q = CommentStruct(name: data["name"] as! String, comment: data["comment"] as! String, imageURL: data["imageurl"] as! String)
                        dataForComment.append(q)
                    }
                }
            }
        }
        let coment = CommentVC()
        self.present(coment, animated: true)
    }
    @objc func onClickLike(_ sender:UITapGestureRecognizer){
        let db = Firestore.firestore()
        let auth = Auth.auth().currentUser
        var ref: DocumentReference? = nil
        ref = db.collection("save_\(auth!.uid)").addDocument(data: [
                "adult": dataForTableView[checkRow].adult!,
                "backdropPath": dataForTableView[checkRow].backdropPath!,
                "genreIDS": dataForTableView[checkRow].genreIDS!,
                "id": dataForTableView[checkRow].id,
                "originalLanguage": dataForTableView[checkRow].originalLanguage!,
                "originalTitle": dataForTableView[checkRow].originalTitle!,
                "overview": dataForTableView[checkRow].overview!,
                "popularity": dataForTableView[checkRow].popularity!,
                "posterPath": dataForTableView[checkRow].posterPath!,
                "releaseDate": dataForTableView[checkRow].releaseDate!,
                "title": dataForTableView[checkRow].title!,
                "video": dataForTableView[checkRow].video!,
                "voteAverage": dataForTableView[checkRow].voteAverage!,
                "voteCount": dataForTableView[checkRow].voteCount!,
                "time": Date.now
            ]) { err in
                if let err = err {
                    self.makeAlert(title: "Error", message: err.localizedDescription)
                } else {
                    self.showToast(message: "Successfully, saved", seconds: 1.2)
                }
        }
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        checkRow = indexPath.row
        let vc = self.router.detailsVC(allData: dataForTableView[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}
