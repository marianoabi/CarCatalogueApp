//
//  CarListAPI.swift
//  CarCatalogueApp
//
//  Created by Abigail Mariano on 7/14/23.
//

import Foundation

final class CarListAPI {
    
    static let shared = CarListAPI()
    
    var carList: [Car]?
    
    private init() {}
    
    func fetchCarListInLocalJSON(completion: @escaping([Car]?) -> Void) {
                
        if let url = Bundle.main.url(forResource: Constants.testJson, withExtension: Constants.fileType) {
            do {
                let data = try Data(contentsOf: url)
                let jsonData = try JSONDecoder().decode([Car].self, from: data)
                completion(jsonData)
            } catch {
                print("Error:\(error)")
                completion(nil)
            }
        }
    }
}
