
import UIKit
import RxSwift
import SnapKit
import domain

public class HomeVC: BaseViewController<MovieViewModel> {
    
   public let baseImageUrl = "https://image.tmdb.org/t/p/w500"
    var dataForTableView: [MovieEntity.ResultEntity] = []
    
    private lazy var tableViewTopMovie: UITableView = {
        let tbView = UITableView()
        tbView.delegate = self
        tbView.dataSource = self
        tbView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
      //  tbView.separatorStyle = .none
        return tbView
    }()
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableViewTopMovie)
        setup()
        getData()
    }
    
    private func setup() {
            self.tableViewTopMovie.snp.makeConstraints { make in
                make.left.right.top.bottom.equalToSuperview()
        }
    }
    private func getData() {
        self.vm.getMovie(typeOfMovie: "kids").then({ m in
            self.dataForTableView = m.results ?? []
                self.tableViewTopMovie.reloadData()
        }).catch({ err in
            print(err)
        })
        
    }
}

extension HomeVC:UITableViewDelegate,UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataForTableView.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
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
