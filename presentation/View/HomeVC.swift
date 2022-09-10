
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
    }
    
//    public override func viewWillAppear(_ animated: Bool) {
//        print("view will appear")
//        self.vm?.getMovie().then({ m in
//            print(m.results?[3].originalLanguage ?? "tt")
//        })
//    }
    private func setup() {
        tableViewTopMovie.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        
    }
    private func getData() {

        self.vm?.getMovie().then({ m in
                if m.results != nil {
                    print("results is not nil")
                }
            self.dataForTableView = m.results ?? []
            self.tableViewTopMovie.reloadData()
            print(m.results?.count)
        }).catch({ err in
            print(err)
        })
        
    }
}
