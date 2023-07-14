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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
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
}
