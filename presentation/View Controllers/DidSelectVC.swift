//
//  DidSelectVC.swift
//  presentation
//
//  Created by AziK's  MAC on 13.09.22.
//

import UIKit
import domain
import SnapKit
import CloudKit

public class DidSelectVC: BaseViewController<TrailerViewModel> {
    var trailerArr : [TrailerEntity.ResultTrailer] = []
    private let allData: MovieEntity.ResultEntity
    let base = "https://image.tmdb.org/t/p/w500"
    public init(allData: MovieEntity.ResultEntity){
        self.allData = allData
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let scrollStackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 15
        view.translatesAutoresizingMaskIntoConstraints = false
    return view
    }()
    @objc func onClick(){
        if let url = URL(string: "https://www.themoviedb.org/movie/\(allData.id ?? 45673)-\((allData.title ?? "luck").exchangeWrapToDash(name: allData.title ?? "luck") )") {
            UIApplication.shared.open(url)
        }
    }
    @objc func onClickTrailer(){
        print(trailerArr[0].key)
        if let url = URL(string: "https://www.youtube.com/watch?v=\(trailerArr[0].key)") {
            UIApplication.shared.open(url)
        }
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setup()
      //  getTrailerLink(id: allData.id ?? 324)
    }
    private func getLabel(name:String,main:Bool) -> UILabel{
        let name = UILabel()
        if main == true{
            self.view.addSubview(name)
        }
        else {
            self.scrollStackViewContainer.addArrangedSubview(name)
        }
        name.numberOfLines = 0
        name.font = UIFont(font: FontFamily.PTSans.regular, size: 20)
        name.textColor = .black
        return name
    }
//    private func getTrailerLink(id:Int) {
//        let didSlectRouter = router?.didSelectVC(allData: allData)
//        didSlectRouter?.vm?.getTrailer(id: id).then({ tr in
//            self.trailerArr = tr.results
//        })
//    }
    private func setup(){
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(scrollStackViewContainer)
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
        let overview = getLabel(name: "overview",main: true)
        overview.text = allData.overview
        overview.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(overview.snp.bottom).offset(5)
            make.left.right.bottom.equalToSuperview()
        }
        scrollStackViewContainer.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        let originalLan = getLabel(name: "originalLan",main: false)
        originalLan.text = "Language: \(allData.originalLanguage ?? "en")"
        originalLan.snp.makeConstraints { make in
            make.top.equalTo(self.scrollStackViewContainer.snp.top)
            make.left.equalTo(self.scrollStackViewContainer.snp.left).offset(20)
            make.right.equalTo(self.scrollStackViewContainer.snp.right).offset(-20)
        }
        let popularity = getLabel(name: "popularity",main: false)
        popularity.text = "Popularity: \(allData.popularity ?? 156.765)"
        popularity.snp.makeConstraints { make in
            make.top.equalTo(originalLan.snp.bottom).offset(20)
            make.left.equalTo(self.scrollStackViewContainer.snp.left).offset(20)
            make.right.equalTo(self.scrollStackViewContainer.snp.right).offset(-20)
        }
        let releaseDate = getLabel(name: "releaseDate",main: false)
        releaseDate.text = "Release Date: \(allData.releaseDate ?? "2022 05 07")"
        releaseDate.snp.makeConstraints { make in
            make.top.equalTo(popularity.snp.bottom).offset(20)
            make.left.equalTo(self.scrollStackViewContainer.snp.left).offset(20)
            make.right.equalTo(self.scrollStackViewContainer.snp.right).offset(-20)
        }
        let voteAverage = getLabel(name: "voteAverage",main: false)
        voteAverage.text = "Vote Average: \(allData.voteAverage ?? 5.5)"
        voteAverage.snp.makeConstraints { make in
            make.top.equalTo(releaseDate.snp.bottom).offset(20)
            make.left.equalTo(self.scrollStackViewContainer.snp.left).offset(20)
            make.right.equalTo(self.scrollStackViewContainer.snp.right).offset(-20)
        }
        let voteCount = getLabel(name: "voteCount",main: false)
        voteCount.text = "Vote Count: \(allData.voteCount ?? 21)"
        voteCount.snp.makeConstraints { make in
            make.top.equalTo(voteAverage.snp.bottom).offset(20)
            make.left.equalTo(self.scrollStackViewContainer.snp.left).offset(20)
            make.right.equalTo(self.scrollStackViewContainer.snp.right).offset(-20)
        }
        let getTrailerText = getLabel(name: "Trailer:", main: false)
        getTrailerText.text = "Trailer:"
        getTrailerText.snp.makeConstraints { make in
            make.top.equalTo(voteCount.snp.bottom).offset(20)
            make.left.equalTo(self.scrollStackViewContainer.snp.left).offset(20)
            make.right.equalTo(self.scrollStackViewContainer.snp.right).offset(-20)
        }
//        print("Trailer Key: -\(trailerArr[0].key)")
        
//        let getTrailerLink = UIButton()
//        self.scrollStackViewContainer.addArrangedSubview(getTrailerLink)
//        getTrailerLink.setTitle("https://www.youtube.com/watch?v=\(trailerArr[0].key)", for: .normal)
//        getTrailerLink.titleLabel?.numberOfLines = 0
//        getTrailerLink.setTitleColor(.blue, for: .normal)
//        getTrailerLink.addTarget(self, action: #selector(onClickTrailer), for: .touchUpInside)
//        getTrailerLink.snp.makeConstraints { make in
//            make.top.equalTo(getTrailerText.snp.bottom)
//            make.left.equalTo(self.scrollStackViewContainer.snp.left).offset(20)
//            make.right.equalTo(self.scrollStackViewContainer.snp.right).offset(-20)
//        }
//        let moreInfo = getLabel(name: "moreInfo",main: false)
//        moreInfo.text = "More information:"
//        moreInfo.snp.makeConstraints { make in
//            make.top.equalTo(getTrailerLink.snp.bottom).offset(20)
//            make.left.equalTo(self.scrollStackViewContainer.snp.left).offset(20)
//            make.right.equalTo(self.scrollStackViewContainer.snp.right).offset(-20)
//        }
//        let moreInfoLink = UIButton()
//        self.scrollStackViewContainer.addArrangedSubview(moreInfoLink)
//        moreInfoLink.setTitle("https://www.themoviedb.org/movie/\(allData.id ?? 45673)-\((allData.title ?? "luck").exchangeWrapToDash(name: allData.title ?? "luck"))", for: .normal)
//        moreInfoLink.titleLabel?.numberOfLines = 0
//        moreInfoLink.setTitleColor(.blue, for: .normal)
//        moreInfoLink.addTarget(self, action: #selector(onClick), for: .touchUpInside)
//        moreInfoLink.snp.makeConstraints { make in
//            make.top.equalTo(moreInfo.snp.bottom)
//            make.left.equalTo(self.scrollStackViewContainer.snp.left).offset(20)
//            make.right.equalTo(self.scrollStackViewContainer.snp.right).offset(-20)
//        }
    }
}
