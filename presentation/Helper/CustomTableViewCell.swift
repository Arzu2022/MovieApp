//
//  CustomTableViewCell.swift
//  presentation
//
//  Created by AziK's  MAC on 09.09.22.
//

import Foundation
import UIKit

class CustomTableViewCell:UITableViewCell {
    lazy var title: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return text
    }()
    lazy var voteCount: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return text
    }()
    lazy var voteAverage: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return text
    }()
    lazy var releaseDate: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return text
    }()
    lazy var popularity: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return text
    }()
    
    lazy var originalTitle: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return text
    }()
    lazy var overview: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return text
    }()
    lazy var originalLanguage: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return text
    }()
    lazy var backdropPath: UIImageView = {
        let icon = UIImageView()
        //icon.clipsToBounds = true
        icon.layer.cornerRadius = 64
        return icon
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }

    func setupUI() {
        contentView.addSubview(title)
        contentView.addSubview(voteCount)
        contentView.addSubview(voteAverage)
        contentView.addSubview(releaseDate)
        contentView.addSubview(popularity)
        contentView.addSubview(originalTitle)
        contentView.addSubview(overview)
        contentView.addSubview(originalLanguage)
        contentView.addSubview(backdropPath)
        backdropPath.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40)
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-40)
//            make.height.equalTo(100)
//            make.width.equalTo(50)
        }
        title.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40)
            make.top.equalTo(backdropPath.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-40)
            make.bottom.equalToSuperview().offset(-20)
        }
//        articleDescription.snp.makeConstraints { make in
//            make.left.equalToSuperview().offset(20)
//            make.top.equalTo(urlToImage.snp.bottom).offset(10)
//            make.right.equalToSuperview().offset(-20)
//        }
//        author.snp.makeConstraints { make in
//            make.left.equalToSuperview().offset(20)
//            make.top.equalTo(articleDescription.snp.bottom).offset(10)
//            make.right.equalToSuperview().offset(-20)
//        }
//        publishedAt.snp.makeConstraints { make in
//            make.left.equalToSuperview().offset(20)
//            make.top.equalTo(author.snp.bottom).offset(10)
//            make.right.equalToSuperview().offset(-20)
//        }
    }
    
}
