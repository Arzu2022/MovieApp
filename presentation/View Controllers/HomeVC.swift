
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
        self.vm?.getMovie(typeOfMovie: "kids").then({ m in
            self.dataForTableView = m.results ?? []
                self.tableViewTopMovie.reloadData()
        }).catch({ err in
            print(err)
        })
        
    }
}
