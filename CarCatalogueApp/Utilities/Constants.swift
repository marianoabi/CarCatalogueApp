//
//  Constants.swift
//  CarCatalogueApp
//
//  Created by Abigail Mariano on 7/14/23.
//

import Foundation
import UIKit

struct Constants {
    static let navBarTitle = "GUIDOMIA"
    static let jsonFileName = "car_list"
    static let testJson = "car_list2"
    static let fileType = "json"
    static let featuredTitle = "Tacoma 2021"
    static let featuredMessage = "Get yours now"
}

enum CarMake: String {
    case bmw = "BMW"
    case mercedes = "Mercedes Benz"
    case landRover = "Land Rover"
    case alpine = "Alpine"
    
    var model: String {
        switch self {
            
        case .bmw:
            return "330i"
        case .mercedes:
            return "GLE coupe"
        case .landRover:
            return "Range Rover"
        case .alpine:
            return "Roadster"
        }
    }
    
    var thumbNail: UIImage {
        switch self {
            
        case .bmw:
            return UIImage(named: "BMW_330i.jpg") ?? UIImage()
        case .mercedes:
            return UIImage(named: "Mercedez_benz_GLC.jpg") ?? UIImage()
        case .landRover:
            return UIImage(named: "Range_Rover.jpg") ?? UIImage()
        case .alpine:
            return UIImage(named: "Alpine_roadster.jpg") ?? UIImage()
        }
    }
}
