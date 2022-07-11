//
//  CountryD.swift
//  5_covid_app
//
//  Created by David Granado Jordan on 6/10/22.
//

import Foundation

struct CountryD: Decodable {
    let id: String
    let country: String
    let countryCode: String
    let date: String
    let deaths: Int
    
    enum CodingKeys: String, CodingKey {
        case id =  "ID"
        case country = "Country"
        case countryCode =  "CountryCode"
        case date = "Date"
        case deaths = "Deaths"
        
    }

}

