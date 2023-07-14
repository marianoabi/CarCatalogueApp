//
//  HeaderTableView.swift
//  CarCatalogueApp
//
//  Created by Abigail Mariano on 7/13/23.
//


import UIKit

// MARK: - Props, IBOutlets, IBActions
class HeaderTableView: UITableViewHeaderFooterView {
    static let identifier = "HeaderTableView"
    static let nib = "HeaderTableView"
    
    @IBOutlet weak var featuredTitle: UILabel!
    @IBOutlet weak var featuredMessage: UILabel!
}

// MARK: - Lifecycle
extension HeaderTableView {
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
}

// MARK: - Functionalities
extension HeaderTableView {
    func setupViews() {
        featuredTitle.text = Constants.featuredTitle
        featuredMessage.text = Constants.featuredMessage
    }
}
