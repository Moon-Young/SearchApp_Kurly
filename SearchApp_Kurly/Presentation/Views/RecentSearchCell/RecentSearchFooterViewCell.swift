//
//  RecentSearchFooterViewCell.swift
//  SearchApp_Kurly
//
//  Created by Moonyoung Kim on 4/7/24.
//

import UIKit

class RecentSearchFooterViewCell: UITableViewHeaderFooterView {
    
    static let identifier = "RecentSearchFooterViewCell"
    static let cellHeight: CGFloat = 50
    
    let containverView: UIView = {
        let view = UIView()
        return view
    }()
    let recentSearchTermAllDeleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("전체삭제", for: .normal)
        button.setTitleColor(UIColor.systemPink, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.tintColor = UIColor(named: "kurly_beige")
        return button
    }()
    let horizontalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "kurly_beige")
        return view
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupLayout()
 
    }
    
    private func setupViews() {
        
        self.contentView.addSubview(self.containverView)
        self.containverView.addSubview(self.recentSearchTermAllDeleteButton)
        self.containverView.addSubview(self.horizontalView)
    }
    private func setupLayout() {
        containverView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        recentSearchTermAllDeleteButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-10)
           }
        horizontalView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(1)
            $0.top.equalTo(recentSearchTermAllDeleteButton.snp.bottom).offset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        
//        self.disposeBag = DisposeBag()
    }
}
