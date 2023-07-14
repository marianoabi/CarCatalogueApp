//
//  CarListVC.swift
//  CarCatalogueApp
//
//  Created by Abigail Mariano on 7/13/23.
//

import UIKit

// MARK: - Props, IBOutlets, IBActions
class CarListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var cars: [Car] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    private let vm = CarListVM()
}

// MARK: - Lifecycle
extension CarListVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupBinders()
        getCarList()
        expandFirstItemInList()
    }
}

// MARK: - Functionalities
extension CarListVC {
    private func setupViews() {
        setupNavigationTitle(Constants.navBarTitle)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: CarTableViewCell.nib, bundle: nil), forCellReuseIdentifier: CarTableViewCell.identifier)
        tableView.register(UINib(nibName: HeaderTableView.nib, bundle: nil), forHeaderFooterViewReuseIdentifier: HeaderTableView.identifier)
        
    }
    
    private func getCarList() {
        vm.getCarList()
    }
    
    private func setupBinders() {
        vm.error.bind { error in
            if let error = error {
                print(error)
            } else {
                
            }
        }
        
        vm.carList.bind { [weak self] cars in
            if let cars = cars {
                self?.cars = cars
            }
        }
    }
    
    private func setupNavigationTitle(_ title: String) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 360, height: 50))
        label.text = title
        label.textColor = .white
        label.font = UIFont(name: "Impact", size: 25)
        label.backgroundColor = UIColor.clear
        label.textAlignment = .left
        navigationItem.titleView = label
    }
    
    private func expandFirstItemInList() {
        let firstIndexPath = IndexPath(row: 0, section: 0)
        tableView.selectRow(at: firstIndexPath, animated: true, scrollPosition: .none)
    }
}

// MARK: - TableView Delegate & DataSource
extension CarListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CarTableViewCell.identifier, for: indexPath) as! CarTableViewCell
        cell.presentData(cars[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderTableView.identifier)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 270
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let cell = tableView.cellForRow(at: indexPath) as? CarTableViewCell, cell.isExpanded {
            return UITableView.automaticDimension
        } else {
            return 155
        }
    }
}
