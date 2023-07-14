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
    
    private let vm = CarListVM()
    private var selectedIndexPath: IndexPath?
    private var isFiltering = false
    private var filteredCars: [Car] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        return rc
    }()
}

// MARK: - Lifecycle
extension CarListVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupBinders()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    private func getCarList() {
        refreshControl.beginRefreshing()
        self.vm.getCarList()
    }
    
    private func setupBinders() {
        vm.error.bind { error in
            if let error = error {
                print(error)
            } else {
                
            }
        }
        
        vm.carList.bind { [weak self] cars in
            self?.refreshControl.endRefreshing()
            if let _ = cars {
                self?.tableView.reloadData()
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
        if !isFiltering, let cars = vm.carList.value, cars.count > 0 {
            selectedIndexPath = IndexPath.init(row: 0, section: 0)
            tableView.selectRow(at: selectedIndexPath, animated: true, scrollPosition: .bottom)
        } else {
            print("No data.")
        }
    }
    
    @objc func refreshData() {
        getCarList()
    }
}

// MARK: - TableView Delegate & DataSource
extension CarListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredCars.count : vm.carList.value?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cars = isFiltering ? filteredCars : vm.carList.value, cars.count > 0 else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CarTableViewCell.identifier, for: indexPath) as! CarTableViewCell
        cell.presentData(cars[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderTableView.identifier) as! HeaderTableView
        header.delegate = self
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 270
        return 450
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if let cell = tableView.cellForRow(at: indexPath) as? CarTableViewCell, inde {
//            return UITableView.automaticDimension
//        } else {
//            return 155
//        }
        
        if selectedIndexPath == indexPath {
            return UITableView.automaticDimension
        }
        return 155
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndexPath != nil, selectedIndexPath == indexPath {
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
        }
        
        UIView.animate(withDuration: 0.3) {
            self.tableView.performBatchUpdates(nil)
        }
    }
}

// MARK: - HeaderTableViewDelegate
extension CarListVC: HeaderTableViewProtocol {
    func didSearchFor(make: String) {
        print("Make filter did change")
        
        if make.count > 0, let cars = vm.carList.value {
            isFiltering = true
            filteredCars = cars.filter({(dataString: Car) -> Bool in
                return (dataString.make?.range(of: make, options: .caseInsensitive) != nil)
            })
            
        } else {
            isFiltering = false
            filteredCars = []
        }
    }
    
    func didSearchFor(model: String) {
        print("Model filter did change")
        
        if model.count > 0, let cars = vm.carList.value {
            isFiltering = true
            filteredCars = cars.filter({(dataString: Car) -> Bool in
                return (dataString.model?.range(of: model, options: .caseInsensitive) != nil)
            })
            
        } else {
            isFiltering = false
            filteredCars = []
        }
    }
    
    func didSearchFor(make: String, model: String) {
        print("Did change filter")
        
        guard let cars = vm.carList.value else { return }
        
        if make.count == 0, model.count == 0 {
            isFiltering = false
            filteredCars = []
            
        } else {
            isFiltering = true
            
            if make.count > 0 && model.count > 0 {
                filteredCars = cars.filter { car in
                    return car.make?.range(of: make, options: .caseInsensitive) != nil && car.model?.range(of: model, options: .caseInsensitive) != nil
                }
            } else {
                if make.count > 0 {
                    filteredCars = cars.filter { car in
                        return car.make?.range(of: make, options: .caseInsensitive) != nil
                    }
                    
                } else if model.count > 0 {
                    filteredCars = cars.filter { car in
                        return car.model?.range(of: model, options: .caseInsensitive) != nil
                    }
                }
            }
        }
    }
}
