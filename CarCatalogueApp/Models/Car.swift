//
//  Car.swift
//  CarCatalogueApp
//
//  Created by Abigail Mariano on 7/13/23.
//

import Foundation
import UIKit

struct Car: Codable {
    
    var consList      : [String]? = []
    var customerPrice : Int?      = nil
    var make          : String?   = nil
    var marketPrice   : Int?      = nil
    var model         : String?   = nil
    var prosList      : [String]? = []
    var rating        : Int?      = nil
    
    enum CodingKeys: String, CodingKey {
        
        case consList      = "consList"
        case customerPrice = "customerPrice"
        case make          = "make"
        case marketPrice   = "marketPrice"
        case model         = "model"
        case prosList      = "prosList"
        case rating        = "rating"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        consList      = try values.decodeIfPresent([String].self , forKey: .consList      )
        customerPrice = try values.decodeIfPresent(Int.self      , forKey: .customerPrice )
        make          = try values.decodeIfPresent(String.self   , forKey: .make          )
        marketPrice   = try values.decodeIfPresent(Int.self      , forKey: .marketPrice   )
        model         = try values.decodeIfPresent(String.self   , forKey: .model         )
        prosList      = try values.decodeIfPresent([String].self , forKey: .prosList      )
        rating        = try values.decodeIfPresent(Int.self      , forKey: .rating        )
        
    }
    
    init() {
        
    }
}


extension Car {

    func getThumbnail()  -> UIImage {
        switch CarMake(rawValue: make ?? "") {
        case .bmw :
            return CarMake.bmw.thumbNail
        case .mercedes:
            return CarMake.mercedes.thumbNail
        case .landRover:
            return CarMake.landRover.thumbNail
        case .alpine:
            return CarMake.alpine.thumbNail
 
        default:
            return UIImage()
        }
    }
    
    func getMakeAndModel() -> String {
        return "\(make ?? "") \(model ?? "")"
    }
    
    func getPrice() -> String {
        let intPrice = Int((customerPrice ?? 0)/1000)
        return "Price: \(String(intPrice))k"
    }
    
    func getRating() -> String {
        
        guard let rating = self.rating else { return "" }
        var ratingToStar = ""
        let star = "★ "
        
        for _ in 1...rating {
            ratingToStar.append(star)
        }
        
        return ratingToStar
    }
    
    func getProList() -> String {
        guard let stringList = prosList else { return "" }
        let listName = "Pros :"
        let bulletPoints = stringList.map { "• \($0)" }.joined(separator: "\n")
        return "\(listName)\n\(bulletPoints)"
    }
    
    func getConList() -> String {
        guard let stringList = consList else { return "" }
        let listName = "Cons :"
        let bulletPoints = stringList.map { "• \($0)" }.joined(separator: "\n")
        return "\(listName)\n\(bulletPoints)"
    }
}
