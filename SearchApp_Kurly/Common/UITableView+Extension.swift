//
//  UITableView+Extension.swift
//  SearchApp_Kurly
//
//  Created by Moonyoung Kim on 4/7/24.
//

import Foundation
import UIKit

extension UITableView {
    func isNearToBottomEdge(contentOffset: CGPoint, distance: CGFloat) -> Bool {
        return contentOffset.y + self.frame.size.height > self.contentSize.height - distance
    }
}
