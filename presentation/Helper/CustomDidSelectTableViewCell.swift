//
//  CustomDidSelectTableViewCell.swift
//  presentation
//
//  Created by AziK's  MAC on 17.09.22.
//

import Foundation

import UIKit

class CustomDidSelectTableViewCell:UITableViewCell {
    lazy var name: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.numberOfLines = 0
        text.font = UIFont(font: FontFamily.PTSans.regular, size: 15)
        return text
    }()
    lazy var surname: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.numberOfLines = 0
        text.font = UIFont(font: FontFamily.PTSans.regular, size: 15)
        return text
    }()
    lazy var comment: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.numberOfLines = 0
        text.font = UIFont(font: FontFamily.PTSans.regular, size: 15)
        return text
    }()
    lazy var time: UILabel = {
        let text = UILabel()
        text.textColor = UIColor(white: 0.7, alpha: 1)
        text.numberOfLines = 0
        text.font = UIFont(font: FontFamily.PTSans.regular, size: 10)
        return text
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }

    func setupUI() {
        contentView.addSubview(name)
        contentView.addSubview(surname)
        contentView.addSubview(comment)
        contentView.addSubview(time)
        name.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40)
            make.top.equalToSuperview().offset(10)
        }
        surname.snp.makeConstraints { make in
            make.left.equalTo(name.snp.right).offset(5)
            make.top.equalTo(name.snp.top)
        }
        comment.snp.makeConstraints { make in
            make.left.equalTo(name.snp.left)
            make.top.equalTo(name.snp.bottom).offset(5)
            make.bottom.equalToSuperview().offset(-10)
        }
        time.snp.makeConstraints { make in
            make.left.equalTo(name.snp.left)
            make.top.equalTo(comment.snp.bottom).offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
    
}
