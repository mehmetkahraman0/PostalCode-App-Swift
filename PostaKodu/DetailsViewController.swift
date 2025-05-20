//
//  DetailsViewController.swift
//  PostaKodu
//
//  Created by Mehmet Kahraman on 14.05.2025.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var districtLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var postalcodeLabel: UILabel!
    
    var district: District?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(district?.name.uppercased() ?? "") İlçesi Detayları"
        guard let district = district else { return }

        nameLabel.text = "İl : \(district.province)"
        districtLabel.text = "İlçe : \(district.name)"
        populationLabel.text = "Nufus : \(district.population)"
        areaLabel.text = "Yüz Ölçümü : \(district.area) km²"
        postalcodeLabel.text = "Posta Kodu : \(district.postalCode)"
    }
}
