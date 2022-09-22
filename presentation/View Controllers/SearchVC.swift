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
        print("clicked to comment")
    }
    @objc func onClickLike(_ sender:UITapGestureRecognizer){
        // firebase...
        showToast(message: "Successfully, saved", seconds: 1.2)
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.router.detailsVC(allData: dataForTableView[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}
