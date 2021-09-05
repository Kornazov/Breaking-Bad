//
//  UITableView+Cell.swift
//  BreakingBad
//
//  Created by Kristiyan Kornazov on 5.09.21.
//

import UIKit
extension UITableView {
  func register<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
      let className = cellType.className
      let nib = UINib(nibName: className, bundle: bundle)
      register(nib, forCellReuseIdentifier: className)
  }
    
  public func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T? {
      return self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as? T
  }
}

protocol ClassNameProtocol {
    static var className: String { get }
}

extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }
    
    var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}
