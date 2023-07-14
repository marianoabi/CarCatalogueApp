//
//  CarListVM.swift
//  CarCatalogueApp
//
//  Created by Abigail Mariano on 7/13/23.
//

import Foundation

final class CarListVM {
    
    var error: ObservableObject<String?> = ObservableObject("")
    var carList: ObservableObject<[Car]?> = ObservableObject(nil)
    
    func getCarList() {
        CarListAPI.shared.fetchCarListInLocalJSON { [weak self] carList in
            if let cars = carList {
                self?.carList.value = cars
            } else {
                self?.carList.value = nil
                self?.error.value = "Failed to get Car List data."
            }
        }
    }
}
