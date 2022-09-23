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
        name.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(5)
            //make.right.equalToSuperview().offset(-12)
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
