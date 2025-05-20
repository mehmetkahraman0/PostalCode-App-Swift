//
//  GetData.swift
//  PostaKodu
//
//  Created by Mehmet Kahraman on 14.05.2025.
//

import Foundation

func loadDistricts() -> [District] {
    guard let url = Bundle.main.url(forResource: "districts", withExtension: "json") else { return [] }
    do {
        let data = try Data(contentsOf: url)
        let districts = try JSONDecoder().decode([District].self, from: data)
        return districts
    } catch {
        print("Hata: \(error)")
        return []
    }
}

func groupDistrictsByProvince(_ districts: [District]) -> [String: [District]] {
    var grouped: [String: [District]] = [:]
    for district in districts {
        grouped[district.province, default: []].append(district)
    }
    return grouped
}
