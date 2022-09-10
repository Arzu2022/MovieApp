
import UIKit
import RxSwift
import SnapKit
import domain

public class HomeVC: BaseViewController<FirstViewModel> {
    
    let baseImageUrl = "https://image.tmdb.org/t/p/w500"
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
        tableViewTopMovie.reloadData()
    }
    private func setup() {
        tableViewTopMovie.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        
    }
    private func getData() {
        self.vm?.getMovie().then({ m in
                if  m.results != nil {
                    print("results is not nil")
                }
            self.dataForTableView = m.results ?? []
            print(m.results?.count)
        }).catch({ err in
            print(err)
        })
        
    }
}