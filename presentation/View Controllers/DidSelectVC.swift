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
    private let allData: MovieEntity.ResultEntity
    let base = "https://image.tmdb.org/t/p/w500"
    var urlTrailer = URL(string: "https://www.youtube.com/watch?v=W9JHZwtObqs")
    var keyForYoutube :String?
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let scrollStackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 13
        view.translatesAutoresizingMaskIntoConstraints = false
    return view
    }()
    init(allData: MovieEntity.ResultEntity,
         vm: TrailerViewModel,
         router: RouterProtocol
    ){
        self.allData = allData
        super.init(vm: vm, router: router)
    }
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = allData.title
        self.vm.getTrailer(id: allData.id)
            .then({ tr in
                if let key = tr.results.first?.key {
                    self.urlTrailer = URL(string: "https://www.youtube.com/watch?v=\(key)")!
                    self.keyForYoutube = key
                }
                self.setup()
            })
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
    @objc func onClick(){
        if let url = URL(string: "https://www.themoviedb.org/movie/\(allData.id )-\((allData.title ?? "luck").exchangeWrapToDash(name: allData.title ?? "luck") )") {
            UIApplication.shared.open(url)
        }
    }
    private func setup(){
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(scrollStackViewContainer)
        let url = "\(self.base)\((self.allData.backdropPath) ?? "/kXfqcdQKsToO0OUXHcrrNCHDBzO.jpg")"
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.onClickMoreInfo(_:)))
        tap2.numberOfTapsRequired = 2
        
        let image = UIImageView()
        self.view.addSubview(image)
        image.addGestureRecognizer(tap2)
        image.isUserInteractionEnabled = true
        image.layer.cornerRadius = 24
        image.layer.masksToBounds = true
        image.imageFromServerURL(url, placeHolder: nil)
        image.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
        scrollStackViewContainer.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
            make.centerX.equalTo(self.scrollView.snp.centerX)
        }
        let overview = getLabel(name: "overview",main: false)
        overview.text = allData.overview
        overview.numberOfLines = 0
        overview.snp.makeConstraints { make in
            make.top.equalTo(self.scrollStackViewContainer.snp.top).offset(5)
            make.left.equalTo(self.scrollStackViewContainer.snp.left).offset(12)
            make.right.equalTo(self.scrollStackViewContainer.snp.right).offset(-12)
        }
        let viewForVoteAvarage = setupAvarage(voteAvarage: allData.voteAverage ?? 0.0)
        self.scrollStackViewContainer.addArrangedSubview(viewForVoteAvarage)
        viewForVoteAvarage.snp.makeConstraints { make in
            make.top.equalTo(overview.snp.bottom).offset(20)
            make.left.equalTo(self.scrollStackViewContainer.snp.left).offset(12)
            make.right.equalTo(self.scrollStackViewContainer.snp.right).offset(-12)
            make.height.equalTo(30)
        }
        let popularity = getLabel(name: "popularity",main: false)
        popularity.text = "Popularity: \(allData.popularity ?? 156.765)"
        popularity.snp.makeConstraints { make in
            make.top.equalTo(viewForVoteAvarage.snp.bottom).offset(20)
            make.left.equalTo(self.scrollStackViewContainer.snp.left).offset(12)
            make.right.equalTo(self.scrollStackViewContainer.snp.right).offset(-12)
        }
        let voteCount = getLabel(name: "voteCount",main: false)
        voteCount.text = "Vote Count: \(allData.voteCount ?? 21)"
        voteCount.snp.makeConstraints { make in
            make.top.equalTo(popularity.snp.bottom).offset(20)
            make.left.equalTo(self.scrollStackViewContainer.snp.left).offset(12)
            make.right.equalTo(self.scrollStackViewContainer.snp.right).offset(-12)
        }
        let originalLan = getLabel(name: "originalLan",main: false)
        originalLan.text = "Language: \(allData.originalLanguage ?? "en")"
        originalLan.snp.makeConstraints { make in
            make.top.equalTo(voteCount.snp.bottom).offset(20)
            make.left.equalTo(self.scrollStackViewContainer.snp.left).offset(12)
            make.right.equalTo(self.scrollStackViewContainer.snp.right).offset(-12)
        }
        let releaseDate = getLabel(name: "releaseDate",main: false)
        releaseDate.text = "Release Date: \(allData.releaseDate ?? "2022 05 07")"
        releaseDate.snp.makeConstraints { make in
            make.top.equalTo(originalLan.snp.bottom).offset(20)
            make.left.equalTo(self.scrollStackViewContainer.snp.left).offset(12)
            make.right.equalTo(self.scrollStackViewContainer.snp.right).offset(-12)
        }
        let getTrailerText = getLabel(name: "Trailer:", main: false)
        getTrailerText.text = "Trailer:"
        getTrailerText.snp.makeConstraints { make in
            make.top.equalTo(releaseDate.snp.bottom).offset(10)
            make.left.equalTo(self.scrollStackViewContainer.snp.left).offset(12)
            make.right.equalTo(self.scrollStackViewContainer.snp.right).offset(-12)
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.onClickTrailer(_:)))
        let imagePathToYoutube = UIImageView()
        self.scrollStackViewContainer.addArrangedSubview(imagePathToYoutube)
        imagePathToYoutube.layer.cornerRadius = 18
        imagePathToYoutube.layer.masksToBounds = true
        imagePathToYoutube.isUserInteractionEnabled = true
        imagePathToYoutube.addGestureRecognizer(tap)
        print("keyForYoutube \(keyForYoutube ?? "key in setup")")
        imagePathToYoutube.imageFromServerURL("https://img.youtube.com/vi/\(keyForYoutube ?? "")/0.jpg", placeHolder: nil)
        imagePathToYoutube.snp.makeConstraints { make in
            make.top.equalTo(getTrailerText.snp.bottom).offset(100)
            make.left.equalTo(self.scrollStackViewContainer.snp.left).offset(12)
            make.right.equalTo(self.scrollStackViewContainer.snp.right).offset(-12)
            make.height.equalTo(220)
        }
        
        let imagePathToYoutubet = UIImageView()
        self.view.addSubview(imagePathToYoutubet)
        imagePathToYoutubet.image = Asset.icYoutube.image
        imagePathToYoutubet.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(60)
            make.center.equalTo(imagePathToYoutube.snp.center)
        }
        
    }
    @objc func onClickTrailer(_ sender: UITapGestureRecognizer){
        UIApplication.shared.open(urlTrailer!)
    }
    @objc func onClickMoreInfo(_ sender: UITapGestureRecognizer){
        if let url = URL(string: "https://www.themoviedb.org/movie/\(allData.id )-\((allData.title ?? "luck").exchangeWrapToDash(name: allData.title ?? "luck") )") {
                    UIApplication.shared.open(url)
                }
    }
    private func setupAvarage(voteAvarage:Double) ->UIStackView {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 0
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        print(voteAvarage)
        func getStar(yellow:Bool)-> UIImageView {
            let image = UIImageView()
            if yellow == true {
                image.image = Asset.icStarYellow.image
            } else {
                image.image = Asset.icStar.image
            }
            return image
        }
        let t: Double = voteAvarage/2
        if t<2 {
            // a star
            let v1 = getStar(yellow: true)
            view.addArrangedSubview(v1)
            v1.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalToSuperview()
                make.width.height.equalTo(15)
            }
            let v2 = getStar(yellow: false)
            view.addArrangedSubview(v2)
            v2.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(v1.snp.right).offset(5)
                make.width.height.equalTo(16)
            }
            let v3 = getStar(yellow: false)
            view.addArrangedSubview(v3)
            v3.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(v2.snp.right).offset(5)
                make.width.height.equalTo(16)
            }
            let v4 = getStar(yellow: false)
            view.addArrangedSubview(v4)
            v4.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(v3.snp.right).offset(5)
                make.width.height.equalTo(16)
            }
            let v5 = getStar(yellow: false)
            view.addArrangedSubview(v5)
            v5.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(v4.snp.right).offset(5)
                make.width.height.equalTo(16)
            }
            let v6 = UIImageView()
            v6.image = UIImage()
            view.addArrangedSubview(v6)
            v6.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(v5.snp.right).offset(5)
                make.width.height.equalTo(17)
            }
        }
        else if t<3 {
            // 2 stars
            let v1 = getStar(yellow: true)
            view.addArrangedSubview(v1)
            v1.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalToSuperview()
                make.width.height.equalTo(15)
            }
            let v2 = getStar(yellow: true)
            view.addArrangedSubview(v2)
            v2.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(v1.snp.right).offset(5)
                make.width.height.equalTo(15)
            }
            let v3 = getStar(yellow: false)
            view.addArrangedSubview(v3)
            v3.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(v2.snp.right).offset(5)
                make.width.height.equalTo(17)
            }
            let v4 = getStar(yellow: false)
            view.addArrangedSubview(v4)
            v4.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(v3.snp.right).offset(5)
                make.width.height.equalTo(17)
            }
            let v5 = getStar(yellow: false)
            view.addArrangedSubview(v5)
            v5.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(v4.snp.right).offset(5)
                make.width.height.equalTo(17)
            }
            let v6 = UIImageView()
            v6.image = UIImage()
            view.addArrangedSubview(v6)
            v6.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(v5.snp.right).offset(5)
                make.width.height.equalTo(17)
            }
        }
        else if t<4 {
           // 3 stars
            let v1 = getStar(yellow: true)
            view.addArrangedSubview(v1)
            v1.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalToSuperview()
                make.width.height.equalTo(15)
            }
            let v2 = getStar(yellow: true)
            view.addArrangedSubview(v2)
            v2.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(v1.snp.right).offset(5)
                make.width.height.equalTo(15)
            }
            let v3 = getStar(yellow: true)
            view.addArrangedSubview(v3)
            v3.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(v2.snp.right).offset(5)
                make.width.height.equalTo(15)
            }
            let v4 = getStar(yellow: false)
            view.addArrangedSubview(v4)
            v4.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(v3.snp.right).offset(5)
                make.width.height.equalTo(17)
            }
            let v5 = getStar(yellow: false)
            view.addArrangedSubview(v5)
            v5.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(v4.snp.right).offset(5)
                make.width.height.equalTo(17)
            }
            let v6 = UIImageView()
            v6.image = UIImage()
            view.addArrangedSubview(v6)
            v6.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(v5.snp.right).offset(5)
                make.width.height.equalTo(17)
            }
        }
        else if t<5 {
            // 4 stars
            let v1 = getStar(yellow: true)
            view.addArrangedSubview(v1)
            v1.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalToSuperview()
                make.width.height.equalTo(15)
            }
            let v2 = getStar(yellow: true)
            view.addArrangedSubview(v2)
            v2.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(v1.snp.right).offset(5)
                make.width.height.equalTo(15)
            }
            let v3 = getStar(yellow: true)
            view.addArrangedSubview(v3)
            v3.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(v2.snp.right).offset(5)
                make.width.height.equalTo(15)
            }
            let v4 = getStar(yellow: true)
            view.addArrangedSubview(v4)
            v4.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(v3.snp.right).offset(5)
                make.width.height.equalTo(15)
            }
            let v5 = getStar(yellow: false)
            view.addArrangedSubview(v5)
            v5.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(v4.snp.right).offset(5)
                make.width.height.equalTo(16)
            }
            let v6 = UIImageView()
            v6.image = UIImage()
            view.addArrangedSubview(v6)
            v6.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(v5.snp.right).offset(5)
                make.width.height.equalTo(17)
            }
        }
        else {
            let v1 = getStar(yellow: true)
            view.addArrangedSubview(v1)
            v1.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalToSuperview()
                make.width.height.equalTo(15)
            }
            let v2 = getStar(yellow: true)
            view.addArrangedSubview(v2)
            v2.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(v1.snp.right).offset(5)
                make.width.height.equalTo(15)
            }
            let v3 = getStar(yellow: true)
            view.addArrangedSubview(v3)
            v3.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(v2.snp.right).offset(5)
                make.width.height.equalTo(15)
            }
            let v4 = getStar(yellow: true)
            view.addArrangedSubview(v4)
            v4.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(v3.snp.right).offset(5)
                make.width.height.equalTo(15)
            }
            let v5 = getStar(yellow: true)
            view.addArrangedSubview(v5)
            v5.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(v4.snp.right).offset(5)
                make.width.height.equalTo(15)
            }
            let v6 = UIImageView()
            v6.image = UIImage()
            view.addArrangedSubview(v6)
            v6.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(v5.snp.right).offset(5)
                make.width.height.equalTo(17)
            }
        }
        return view
    }
}
extension DidSelectVC : UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomDidSelectTableViewCell
        let label = UILabel()
        cell.addSubview(label)
        let name = ["azik","yunka"]
        let surname = ["Heydarov","Azizli"]
        let comment = ["That is so good","perfect!"]
        let time = ["00:17 AM","03:13 AM"]
        cell.backgroundColor = .systemBackground
        label.text = name[indexPath.row]
        cell.name = label
        label.text = surname[indexPath.row]
        cell.surname = label
        label.text = comment[indexPath.row]
        cell.comment = label
        label.text = time[indexPath.row]
        cell.time = label
        return cell
    }
}
