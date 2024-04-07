//
//  RecentSearchCell.swift
//  SearchApp_Kurly
//
//  Created by Moonyoung Kim on 4/7/24.
//

import UIKit
import RxSwift


class RecentSearchCell: UITableViewCell {
    
    static let identifier = "RecentSearchCell"
    static let cellHeight: CGFloat = 50
    var disposeBag = DisposeBag()
    
    let containverView: UIView = {
        let view = UIView()
        return view
    }()
    let recentSearchTermLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "SwiftSwift"
        label.font = UIFont.systemFont(ofSize: 17)
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    let recentSearchTermDeleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = UIColor(named: "kurly_beige")
        button.addTarget(self, action: #selector(recentSearchTermDeleteButtonTapped(_:)), for: .touchUpInside)
        return button
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
        self.containverView.addSubview(self.recentSearchTermLabel)
        self.containverView.addSubview(self.recentSearchTermDeleteButton)
    }
    private func setupLayout() {
        
        containverView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview()
        }
        recentSearchTermLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
           }
        recentSearchTermDeleteButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.equalTo(50)
            $0.height.equalTo(50)
            $0.leading.equalTo(self.recentSearchTermLabel.snp.trailing)
        }
    }
    
    @objc func recentSearchTermDeleteButtonTapped(_ sender: UIButton) {
        print("Button tapped")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.recentSearchTermLabel.text = nil
        self.disposeBag = DisposeBag()
    }
    
}
