//
//  HeaderTableView.swift
//  CarCatalogueApp
//
//  Created by Abigail Mariano on 7/13/23.
//


import UIKit

protocol HeaderTableViewProtocol {
    func didSearchFor(make: String, model: String)
}

// MARK: - Props, IBOutlets, IBActions
class HeaderTableView: UITableViewHeaderFooterView {
    static let identifier = "HeaderTableView"
    static let nib = "HeaderTableView"
    var delegate: HeaderTableViewProtocol?
    
    @IBOutlet weak var featuredTitle: UILabel!
    @IBOutlet weak var featuredMessage: UILabel!
    
    
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var makeTextField: UITextField!
    @IBOutlet weak var modelTextfield: UITextField!
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
    private func setupViews() {
        featuredTitle.text = Constants.featuredTitle
        featuredMessage.text = Constants.featuredMessage
        
        makeTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        modelTextfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        [filterView, makeTextField, modelTextfield].forEach({ $0?.layer.cornerRadius = 5; $0?.layer.masksToBounds = true })
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        let makeTx = makeTextField.text ?? ""
        let modelTx = modelTextfield.text ?? ""
        self.delegate?.didSearchFor(make: makeTx, model: modelTx)
    }
}
