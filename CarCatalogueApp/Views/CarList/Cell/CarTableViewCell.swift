//
//  CarTableViewCell.swift
//  CarCatalogueApp
//
//  Created by Abigail Mariano on 7/13/23.
//

import UIKit

// MARK: - Props, IBOutlets, IBActions
class CarTableViewCell: UITableViewCell {
    
    static let identifier = "CarTableViewCell"
    static let nib = "CarTableViewCell"
    
    var isExpanded = false
    var bottomBorderHeight = 25
    
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var carPrice: UILabel!
    @IBOutlet weak var carRating: UILabel!
    @IBOutlet weak var bottomBorder: UIView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var prosLabel: UILabel!
    @IBOutlet weak var consLabel: UILabel!
}

// MARK: - Lifecycle, Overrides
extension CarTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func draw(_ rect: CGRect) {
        if isLastCell() {
            hideBottomBorder()
        } else {
            showBottomBorder()
        }
        
        if let tableView = superview as? UITableView {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        isExpanded = selected

        detailsView.isHidden = !isExpanded

        if let tableView = superview as? UITableView {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
}

// MARK: - Functionalities
extension CarTableViewCell {
    func presentData(_ car: Car) {
        carImage.image = car.getThumbnail()
        carName.text = car.getMakeAndModel()
        carPrice.text = car.getPrice()
        carRating.text = car.getRating()
        prosLabel.text = car.getProList()
        consLabel.text = car.getConList()
    }
    
    private func isLastCell() -> Bool {
        if let tableView = superview as? UITableView {
            let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
            let indexPath = tableView.indexPath(for: self)
            
            if let indexPath = indexPath, indexPath.row == lastRowIndex {
                return true
            }
        }
        
        return false
    }
    
    private func showBottomBorder() {
        bottomBorder.isHidden = false
    }
    
    private func hideBottomBorder() {
        bottomBorder.isHidden = true
    }
}
