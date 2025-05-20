//
//  District.swift
//  PostaKodu
//
//  Created by Mehmet Kahraman on 14.05.2025.
//

import Foundation

struct District: Decodable {
    let provinceId : Int
    let id : Int
    let province: String
    let name: String
    let population : Int
    let area : Int
    let postalCode : String
}


