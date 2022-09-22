//
//  CustomTableViewCell.swift
//  presentation
//
//  Created by AziK's  MAC on 09.09.22.
//

import Foundation
import UIKit

class CustomHomeVCTableViewCell:UITableViewCell {
    lazy var title: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.numberOfLines = 0
        text.font = UIFont(font: FontFamily.PTSans.regular, size: 20)
        return text
    }()
    lazy var backdropPath: UIImageView = {
        let icon = UIImageView()
        icon.clipsToBounds = true
        icon.layer.masksToBounds = true
        icon.layer.cornerRadius = 18
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
        contentView.addSubview(backdropPath)
        title.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-12)
        }
        backdropPath.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.top.equalTo(title.snp.bottom).offset(10)
            make.height.width.equalTo(250)
            make.bottom.equalToSuperview().offset(-50)
        }
    }
    
}
