//
//  DidSelectVC.swift
//  presentation
//
//  Created by AziK's  MAC on 13.09.22.
//

import UIKit
import domain
import SnapKit

class DidSelectVC: UIViewController {
    
    private let allData: MovieEntity.ResultEntity
    let base = "https://image.tmdb.org/t/p/w500"
    init(allData: MovieEntity.ResultEntity){
        self.allData = allData
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func onClick(){
        if let url = URL(string: "https://www.themoviedb.org/movie/\(allData.id ?? 45673)-\(allData.title?.exchangeWrapToDash(name: allData.title ?? "luck"))") {
            UIApplication.shared.open(url)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setup()
    }
    private func getLabel(name:String) -> UILabel{
        let name = UILabel()
        self.view.addSubview(name)
        name.numberOfLines = 0
        name.font = UIFont(font: FontFamily.PTSans.regular, size: 20)
        name.textColor = .black
        return name
    }
    private func setup(){
        let url = "\(self.base)\((self.allData.backdropPath) ?? "/kXfqcdQKsToO0OUXHcrrNCHDBzO.jpg")"
        let image = UIImageView()
        self.view.addSubview(image)
        image.layer.cornerRadius = 24
        image.layer.masksToBounds = true
        image.imageFromServerURL(url, placeHolder: nil)
        image.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        let overview = getLabel(name: "overview")
        overview.text = allData.overview
        overview.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        let originalLan = getLabel(name: "originalLan")
        originalLan.text = "Original language: \(allData.originalLanguage ?? "en")"
        originalLan.snp.makeConstraints { make in
            make.top.equalTo(overview.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        let popularity = getLabel(name: "popularity")
        popularity.text = "Popularity: \(allData.popularity ?? 156.765)"
        popularity.snp.makeConstraints { make in
            make.top.equalTo(originalLan.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        let releaseDate = getLabel(name: "releaseDate")
        releaseDate.text = "Release Date: \(allData.releaseDate ?? "2022 05 07")"
        releaseDate.snp.makeConstraints { make in
            make.top.equalTo(popularity.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        let voteAverage = getLabel(name: "voteAverage")
        voteAverage.text = "Vote Average: \(allData.voteAverage ?? 5.5)"
        voteAverage.snp.makeConstraints { make in
            make.top.equalTo(releaseDate.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        let voteCount = getLabel(name: "voteCount")
        voteCount.text = "Vote Count: \(allData.voteCount ?? 21)"
        voteCount.snp.makeConstraints { make in
            make.top.equalTo(voteAverage.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        let moreInfo = UIButton()
        self.view.addSubview(moreInfo)
        moreInfo.setTitle("More information...", for: .normal)
        moreInfo.setTitleColor(.black, for: .normal)
        moreInfo.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        moreInfo.snp.makeConstraints { make in
            make.top.equalTo(voteCount.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
    }
}
