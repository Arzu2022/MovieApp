//
//  SearchVC.swift
//  presentation
//
//  Created by AziK's  MAC on 07.09.22.
//

import UIKit
import domain

public class SearchVC: BaseViewController<MovieViewModel> {
    var dataForTableView: [MovieEntity.ResultEntity] = []
    let baseImageUrl = "https://image.tmdb.org/t/p/w500"
    private lazy var tableView:UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        //view.backgroundColor = .red
        view.register(CustomHomeVCTableViewCell.self, forCellReuseIdentifier: "cell")
      //tbView.separatorStyle = .none
        return view
    }()
    private var searchBar: UISearchController = {
           let sb = UISearchController()
           sb.searchBar.placeholder = "Enter the movie name"
           sb.searchBar.searchBarStyle = .minimal
           return sb
       }()
    override init(vm: MovieViewModel, router: RouterProtocol) {
        super.init(vm: vm, router: router)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .yellow
        setup()
    }
    private func setup(){
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
