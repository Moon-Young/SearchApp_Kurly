//
//  RecentSearchHeaderViewCell.swift
//  SearchApp_Kurly
//
//  Created by Moonyoung Kim on 4/7/24.
//

import UIKit

class RecentSearchHeaderViewCell: UITableViewHeaderFooterView {
    
    static let identifier = "RecentSearchHeaderViewCell"
    static let cellHeight: CGFloat = 30
    
    let containverView: UIView = {
        let view = UIView()
        return view
    }()
    let headerTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "main_bk")
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupLayout()
        
    }
    
    private func setupViews() {
        let clearView = UIView()
        clearView.backgroundColor = UIColor.clear
        UITableViewCell.appearance().selectedBackgroundView = clearView
        
        self.contentView.addSubview(self.containverView)
        self.containverView.addSubview(self.headerTextLabel)
        
    }
    private func setupLayout() {
        containverView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        headerTextLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        
    }
}
