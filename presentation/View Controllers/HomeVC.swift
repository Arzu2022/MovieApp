
import UIKit
import RxSwift
import SnapKit
import domain
import FirebaseAuth
import FirebaseFirestore
    public var checkRow: Int = 0
    public var checkID: Int = 0
    public class HomeVC: BaseViewController<MovieViewModel> {
        var db = Firestore.firestore()
        var auth = Auth.auth().currentUser
    private var segmentedControl:UISegmentedControl = {
        let view = UISegmentedControl(items: ["General","Top Rated","Kids"])
        view.backgroundColor = .black
        view.selectedSegmentTintColor = .systemRed
        view.setTitleColor(UIColor.white)
        view.selectedSegmentIndex = 0
        view.addTarget(self, action: #selector(handleChanged), for: .valueChanged)
        return view
    }()
    let baseImageUrl = "https://image.tmdb.org/t/p/w500"
    var dataForTableView: [MovieEntity.ResultEntity] = []
    
    private lazy var tableViewTopMovie: UITableView = {
        let tbView = UITableView()
        tbView.delegate = self
        tbView.dataSource = self
        tbView.register(CustomHomeVCTableViewCell.self, forCellReuseIdentifier: "cell")
        return tbView
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
        self.view.addSubview(tableViewTopMovie)
        setup()
        getData(typeOf: "general")
    }
    private func setup() {
        self.title = "Home Page"
        self.view.backgroundColor = .black
        self.view.addSubview(segmentedControl)
        view.backgroundColor = .white
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(12)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-12)
            make.height.equalTo(30)
        }
            self.tableViewTopMovie.snp.makeConstraints { make in
                make.top.equalTo(self.segmentedControl.safeAreaLayoutGuide.snp.bottom)
                make.left.right.bottom.equalToSuperview()
        }
    }
        private func getData(typeOf:String) {
            AppLoader.instance.showLoaderView()
        self.vm.getMovie(typeOfMovie: typeOf).then({ m in
            AppLoader.instance.hideLoaderView()
            self.dataForTableView = m.results ?? []
                self.tableViewTopMovie.reloadData()
        }).catch({ err in
            print(err)
        })
        
    }
    @objc func handleChanged(){
        if segmentedControl.selectedSegmentIndex == 0 {
            getData(typeOf: "general")
            checkRow = 0
            dataForComment = []
            tableViewTopMovie.scrollToRow(at: NSIndexPath(row: 0, section: 0) as IndexPath, at: .top, animated: true)
        }
        else if segmentedControl.selectedSegmentIndex == 1 {
            getData(typeOf: "top_rated")
            checkRow = 0
            dataForComment = []
            tableViewTopMovie.scrollToRow(at: NSIndexPath(row: 0, section: 0) as IndexPath, at: .top, animated: true)
        }
        else if segmentedControl.selectedSegmentIndex == 2 {
            getData(typeOf: "kids")
            checkRow = 0
            dataForComment = []
            tableViewTopMovie.scrollToRow(at: NSIndexPath(row: 0, section: 0) as IndexPath, at: .top, animated: true)
        }
    }
}
extension HomeVC:UITableViewDelegate,UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataForTableView.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomHomeVCTableViewCell
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
                let url = "\(self.baseImageUrl)\((self.dataForTableView[indexPath.row].backdropPath) ?? "/kXfqcdQKsToO0OUXHcrrNCHDBzO.jpg")"
                cell.backdropPath.imageFromServerURL(url, placeHolder:nil)
                cell.title.text = self.dataForTableView[indexPath.row].title
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
    func makeAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let btn = UIAlertAction(title: "OK", style: .default)
        alert.addAction(btn)
        self.present(alert, animated: true)
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        checkID = dataForTableView[indexPath.row].id
        checkRow = indexPath.row
        let vc = self.router.detailsVC(allData: dataForTableView[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
        @objc func onClickComment(_ sender:UITapGestureRecognizer){
            db = Firestore.firestore()
            auth = Auth.auth().currentUser
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
        db = Firestore.firestore()
        auth = Auth.auth().currentUser
        db.collection("save_\(auth!.uid)").document("\(dataForTableView[checkRow].id )").setData([
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
}
