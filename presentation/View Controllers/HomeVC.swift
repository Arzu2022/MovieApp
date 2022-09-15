
import UIKit
import RxSwift
import SnapKit
import domain
// vote avarage, voutecount, popularity,language,realese_date
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
    //let typeOfForApi = "general"
    var dataForTableView: [MovieEntity.ResultEntity] = []
    
    private lazy var tableViewTopMovie: UITableView = {
        let tbView = UITableView()
        tbView.delegate = self
        tbView.dataSource = self
        tbView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
      //tbView.separatorStyle = .none
        return tbView
    }()
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableViewTopMovie)
        setup()
        getData(typeOf: "general")
    }
    
    private func setup() {
        self.view.backgroundColor = .black
        self.view.addSubview(segmentedControl)
        view.backgroundColor = .white
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(20)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-20)
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
        }
        else if segmentedControl.selectedSegmentIndex == 1 {
            getData(typeOf: "top_rated")
        }
        else if segmentedControl.selectedSegmentIndex == 2 {
            getData(typeOf: "kids")
        }
    }
}
extension HomeVC:UITableViewDelegate,UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataForTableView.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.backgroundColor = .systemBackground
                let url = "\(self.baseImageUrl)\((self.dataForTableView[indexPath.row].backdropPath) ?? "/kXfqcdQKsToO0OUXHcrrNCHDBzO.jpg")"
                cell.backdropPath.imageFromServerURL(url, placeHolder:nil)
                cell.title.text = self.dataForTableView[indexPath.row].title
        
        return cell
    
       }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.router.detailsVC(allData: dataForTableView[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}
