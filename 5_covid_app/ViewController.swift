//
//  ViewController.swift
//  5_covid_app
//
//  Created by David Granado Jordan on 6/7/22.
//

import UIKit
import SVProgressHUD

struct Country {
    var name: String
    var date: String
    var deaths: Int
    var recovered: Int
    var active: Int
    var flag: String
}

class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var countries: [CountryD] = []
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        
        // threadFunction()
        
        // asyncFunction()
        
        // asyncAndSyncFunctionTwo()
    }
    
    func threadFunction() {

        
        DispatchQueue.global(qos: .background).sync {
            print("Background Thread")
        }
        
        DispatchQueue.global(qos: .default).sync {
            print("Default Thread")
        }
        
    }

    
    func asyncFunction() {
        print("Init")
        
        DispatchQueue.global(qos: .background).async {
            print("Background Thread")
        }
        
        print("End")
    }
    
    func asyncAndSyncFunctionTwo() {
        print("Init")
        
        DispatchQueue.global(qos: .background).async {
            print("Background Thread")
        }
        
        DispatchQueue.global(qos: .background).sync {
            print("End")
        }
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell", for: indexPath) as? CountryTableViewCell ?? CountryTableViewCell(style: .subtitle, reuseIdentifier: "CountryTableViewCell")
        
        let country = countries[indexPath.row]
        
        cell.countryNameLabel.text = country.country
        cell.countryDateLabel.text = country.date
    
        
        /*if let url = URL(string: "https://countryflagsapi.com/png/\(searchBar.text ?? "bolivia")") {
            cell.countryImageView.load(url: url)
        }*/
        
        cell.countryImageView.image = image
        
        
        
        return cell
    }
    
}


extension ViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    
    /*func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text, !text.isEmpty else { return }

        if let url = URL(string: "https://countryflagsapi.com/png/\(searchBar.text ?? "bolivia")") {
            loadImage(url: url)
        }
        
        
        let urlStr = "https://api33.covid19api.com/live/country/\(text)/status/confirmed?from=2022-04-01T00:00:00Z&to=2022-04-18T00:00:00Z"
        guard let url = URL(string: urlStr) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        SVProgressHUD.show()
        
        let task  = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            SVProgressHUD.dismiss()
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                    print("OK")
                    
                }))
                DispatchQueue.main.sync {
                self.present(alert, animated: true, completion: nil)
                }
                return
            }
            
            //guard error == nil, let data = data else { return }

            do {
                if let countryJson = try JSONSerialization.jsonObject(with: data!, options: []) as? [  [String: Any] ] {
                    
                    self.countries.removeAll()
                    
                    for countryDic in countryJson {
                        
                        guard let name = countryDic["Country"] as? String,
                              let date = countryDic["Date"] as? String,
                              let deaths = countryDic["Deaths"] as? Int,
                              let active = countryDic["Active"] as? Int,
                              let recovered = countryDic["Recovered"] as? Int else { continue }
                        
                        
                        let country = Country(name: name, date: date, deaths: deaths, recovered: recovered, active: active, flag: "")
                        
                        self.countries.append(country)
                        
                        
                    }
                    
                    
                }
                DispatchQueue.main.sync {
                    self.tableView.reloadData()
                }
                
            } catch {
                print("Error:", error.localizedDescription)
            }
            
        }
        
        
        task.resume()
        
        
    }*/
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text, !text.isEmpty else { return }
        if let url = URL(string: "https://countryflagsapi.com/png/\(searchBar.text ?? "bolivia")") {
            loadImage(url: url)
        }
        
        
        let urlStr = "https://api.covid19api.com/live/country/\(text)/status/confirmed?from=2022-04-01T00:00:00Z&to=2022-04-18T00:00:00Z"
        guard let url = URL(string: urlStr) else { return }
        SVProgressHUD.show()
        
        NetworkManager.shared.get( [CountryD].self, from: url ) { result in
            
            SVProgressHUD.dismiss()
            switch result {
                
            case .success(let countries):
                self.countries = countries
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
                
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                    print("OK")
                    
                }))
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        
        
    }
    
    
    
    
    func loadImage(url: URL) {
        DispatchQueue.global().async {
            
            if let data = try? Data(contentsOf: url) {
                
                if let image = UIImage(data: data) {
                    
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
    }
    
}



extension UIImageView {
    
    func load(url: URL) {
        DispatchQueue.global().async {
            
            if let data = try? Data(contentsOf: url) {
                
                if let image = UIImage(data: data) {
                    
                    DispatchQueue.main.async {
                        self.image = image
                    }
                    
                }
            }
        }
    }
}
