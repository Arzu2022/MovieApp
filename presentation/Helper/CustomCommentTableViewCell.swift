//
//  CustomCommentTableViewCell.swift
//  presentation
//
//  Created by AziK's  MAC on 23.09.22.
//

import Foundation
import UIKit
class CustomCommentTableViewCell:UITableViewCell {
    lazy var name: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return text
    }()
    lazy var comment: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.numberOfLines = 0
        text.font = UIFont(font: FontFamily.PTSans.regular, size: 16)
        return text
    }()
    lazy var image: UIImageView = {
        let icon = UIImageView()
        icon.layer.masksToBounds = true
        icon.layer.cornerRadius = 10
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
        contentView.addSubview(name)
        contentView.addSubview(comment)
        contentView.addSubview(image)
        image.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(5)
            make.width.height.equalTo(20)
            make.bottom.equalToSuperview().offset(-5)
        }
        name.snp.makeConstraints { make in
            make.left.equalTo(image.snp.right).offset(2)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
        comment.snp.makeConstraints { make in
            make.left.equalTo(name.snp.right).offset(5)
            make.top.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
    
}
