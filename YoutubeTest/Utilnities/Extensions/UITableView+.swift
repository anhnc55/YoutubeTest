//
//  UITableView+.swift
//  YoutubeTest
//
//  Created by Anh Nguyen on 05/06/2022.
//

import UIKit

protocol Reusable {
    static var reuseID: String {get}
}

extension Reusable {
    static var reuseID: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable {}

extension UIViewController: Reusable {}

extension UITableView {
    func dequeueReusableCell<T>(ofType cellType: T.Type = T.self, at indexPath: IndexPath) -> T where T: UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseID,
                                             for: indexPath) as? T else {
            fatalError()
        }
        return cell
    }
    
    func register<T: UITableViewCell>(ofType cellType: T.Type) {
        self.register(UINib(nibName: cellType.reuseID, bundle: nil), forCellReuseIdentifier: cellType.reuseID)
    }
}