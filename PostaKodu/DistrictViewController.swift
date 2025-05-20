//
//  DistrictViewController.swift
//  PostaKodu
//
//  Created by Mehmet Kahraman on 14.05.2025.
//

import UIKit

class DistrictViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var distrcitTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    var districts: [District] = []
    var provinceName: String?
    var selectedDistrict: District?

    var filteredDistricts: [District] = []
    var isSearching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "İlçeler"
        distrcitTableView.dataSource = self
        distrcitTableView.delegate = self
        searchBar.delegate = self

        print(districts)
        print(provinceName ?? "tanımsız")
    }

    // MARK: - TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredDistricts.count : districts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let district = isSearching ? filteredDistricts[indexPath.row] : districts[indexPath.row]
        cell.textLabel?.text = district.name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDistrict = isSearching ? filteredDistricts[indexPath.row] : districts[indexPath.row]
        performSegue(withIdentifier: "toDetailsPage", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsPage",
           let destinationVC = segue.destination as? DetailsViewController,
           let selectedDistrict = selectedDistrict {
            destinationVC.district = selectedDistrict
        }
    }

    // MARK: - SearchBar Methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
        } else {
            isSearching = true
            filteredDistricts = districts.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
        }
        distrcitTableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        distrcitTableView.reloadData()
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        distrcitTableView.reloadData()
    }
}

