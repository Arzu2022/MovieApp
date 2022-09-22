
import UIKit
import RxSwift
import SnapKit
import domain
    public class HomeVC: BaseViewController<MovieViewModel> {
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
    var checkLike = 0
    private lazy var tableViewTopMovie: UITableView = {
        let tbView = UITableView()
        tbView.delegate = self
        tbView.dataSource = self
        tbView.register(CustomHomeVCTableViewCell.self, forCellReuseIdentifier: "cell")
        return tbView
    }()
    
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
        self.vm.getMovie(typeOfMovie: typeOf).then({ m in
            self.dataForTableView = m.results ?? []
                self.tableViewTopMovie.reloadData()
        }).catch({ err in
            print(err)
        })
        
    }
    @objc func handleChanged(){
        if segmentedControl.selectedSegmentIndex == 0 {
            getData(typeOf: "general")
            tableViewTopMovie.scrollToRow(at: NSIndexPath(row: 0, section: 0) as IndexPath, at: .top, animated: true)
        }
        else if segmentedControl.selectedSegmentIndex == 1 {
            getData(typeOf: "top_rated")
            tableViewTopMovie.scrollToRow(at: NSIndexPath(row: 0, section: 0) as IndexPath, at: .top, animated: true)
        }
        else if segmentedControl.selectedSegmentIndex == 2 {
            getData(typeOf: "kids")
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
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.router.detailsVC(allData: dataForTableView[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func onClickComment(_ sender:UITapGestureRecognizer){
        print("clicked to comment")
    }
    @objc func onClickLike(_ sender:UITapGestureRecognizer){
        // firebase...
        showToast(message: "Successfully, saved", seconds: 1.2)
        
    }
}
