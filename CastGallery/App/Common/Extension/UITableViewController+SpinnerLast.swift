//
//  UITableViewController+SpinnerLast.swift
//  CastGallery
//
//  Created by Irakli Nozadze on 11.02.24.
//

import UIKit

extension UITableViewController {
    func addSpinerLastCell() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: .zero, y: .zero, width: tableView.bounds.width, height: CGFloat(ViewValues.defaultHeightCell))
        tableView.tableFooterView = spinner
    }
}
