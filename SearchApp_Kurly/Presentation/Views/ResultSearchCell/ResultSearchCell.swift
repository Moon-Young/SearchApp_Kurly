//
//  ResultCell.swift
//  SearchApp_Kurly
//
//  Created by Moonyoung Kim on 4/7/24.
//

import UIKit
import RxSwift

class ResultSearchCell: UITableViewCell {

    static let identifier = "ResultSearchCell"
    static let cellHeight: CGFloat = 70
    var disposeBag = DisposeBag()
    
    let containverView: UIView = {
        let view = UIView()
        return view
    }()
    let labelView: UIView = {
        let view = UIView()
        return view
    }()
    let thumbnailImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 22.5
        iv.clipsToBounds = true
        return iv
    }()
    let resultTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Swift"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    let resultDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "main_gray_6")
        label.text = "apple"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }

    private func setupViews() {
        let clearView = UIView()
        clearView.backgroundColor = UIColor.clear
        UITableViewCell.appearance().selectedBackgroundView = clearView
        
        self.contentView.addSubview(self.containverView)
        
        self.containverView.addSubview(self.thumbnailImageView)
        self.containverView.addSubview(self.labelView)
        
        self.labelView.addSubview(self.resultTitleLabel)
        self.labelView.addSubview(self.resultDescriptionLabel)
         
    }
    private func setupLayout() {
        
        containverView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview()
        }
        thumbnailImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalTo(45)
            $0.height.equalTo(45)
           }
        labelView.snp.makeConstraints {
            $0.centerY.equalTo(self.thumbnailImageView.snp.centerY)
            $0.leading.equalTo(self.thumbnailImageView.snp.trailing).offset(20)
            $0.height.equalTo(self.thumbnailImageView.snp.height)
            $0.trailing.equalToSuperview()
           }
        resultTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        resultDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(self.resultTitleLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
           }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.thumbnailImageView.image = nil
        self.resultTitleLabel.text = nil
        self.resultDescriptionLabel.text = nil
        self.disposeBag = DisposeBag()
    }
}
