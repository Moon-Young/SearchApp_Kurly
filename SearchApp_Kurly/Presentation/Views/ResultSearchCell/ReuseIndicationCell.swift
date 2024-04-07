//
//  ReuseIndicationCell.swift
//  SearchApp_Kurly
//
//  Created by Moonyoung Kim on 4/7/24.
//

import UIKit

final class ReuseIndicationCell: UITableViewHeaderFooterView {
    
    static let identifier = "ReuseIndicationCell"
    static let cellHeight: CGFloat = 40
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        return indicator
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }
    private func setupViews() {
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(self.activityIndicator)
    }
    
    private func setupLayout() {
        activityIndicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
