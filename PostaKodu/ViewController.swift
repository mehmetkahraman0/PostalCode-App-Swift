//
//  ViewController.swift
//  PostaKodu
//
//  Created by Mehmet Kahraman on 14.05.2025.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var cityTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var allDistricts: [District] = []
    var groupedDistricts: [String: [District]] = [:]
    var provinceNames: [String] = []
    var selectedProvince: String?

    var filteredProvinceNames: [String] = []
    var isSearching = false


        override func viewDidLoad() {
            super.viewDidLoad()
            self.title = "İller"
            allDistricts = loadDistricts()
            groupedDistricts = groupDistrictsByProvince(allDistricts)
            provinceNames = Array(groupedDistricts.keys).sorted()

            cityTableView.delegate = self
            cityTableView.dataSource = self
            
            searchBar.delegate = self
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return isSearching ? filteredProvinceNames.count : provinceNames.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell()
            let name = isSearching ? filteredProvinceNames[indexPath.row] : provinceNames[indexPath.row]
            cell.textLabel?.text = name
            return cell
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            selectedProvince = isSearching ? filteredProvinceNames[indexPath.row] : provinceNames[indexPath.row]
            performSegue(withIdentifier: "toDistrictPage", sender: self)
        }

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toDistrictPage",
               let destinationVC = segue.destination as? DistrictViewController,
               let selectedProvince = selectedProvince {
                let districts = groupedDistricts[selectedProvince] ?? []
                destinationVC.districts = districts
                destinationVC.provinceName = selectedProvince
            }
        }

        // MARK: - SearchBar Delegates
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.isEmpty {
                isSearching = false
            } else {
                isSearching = true
                filteredProvinceNames = provinceNames.filter { $0.lowercased().contains(searchText.lowercased()) }
            }
            cityTableView.reloadData()
        }

        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            isSearching = false
            searchBar.text = ""
            cityTableView.reloadData()
        }

        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            isSearching = false
            searchBar.text = ""
            searchBar.resignFirstResponder()
            cityTableView.reloadData()
        }
}

