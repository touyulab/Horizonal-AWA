//
//  UITableView+Extension.swift
//  Horizonal-AWA
//
//  Created by Yuto Akiba on 2017/09/11.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import UIKit

extension UITableView {
    func register(_ cellTypes: UITableViewCell.Type...) {
        cellTypes.forEach { cellType in
            let className = String(describing: cellType.self)
            let nib = UINib(nibName: className, bundle: nil)
            register(nib, forCellReuseIdentifier: className)
        }
    }
    
    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: String(describing: type.self), for: indexPath) as! T
    }
}
