//
//  CompareCell.swift
//  SearchApp_Kurly
//
//  Created by Moonyoung Kim on 4/7/24.
//

import UIKit
import RxSwift
class CompareCell: UITableViewCell {

    static let identifier = "CompareCell"
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
        return label
    }()
    let recentSearchInsertDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "main_gray_6")
        label.text = "03.07"
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
        self.containverView.addSubview(self.recentSearchTermLabel)
        self.containverView.addSubview(self.recentSearchInsertDateLabel)
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
        recentSearchInsertDateLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.recentSearchTermLabel.text = nil
        self.recentSearchInsertDateLabel.text = nil
        self.disposeBag = DisposeBag()
    }

}
