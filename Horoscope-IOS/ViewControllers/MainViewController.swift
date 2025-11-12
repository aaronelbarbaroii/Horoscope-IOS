//
//  ViewController.swift
//  Horoscope-IOS
//
//  Created by Mananas on 6/11/25.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var horoscopeList: [Horoscope] = Horoscope.getAll()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            
        tableView.reloadData()
    }
    
    /*override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
        }*/
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.isEmpty {
                horoscopeList = Horoscope.getAll()
            }
            else {
                horoscopeList = Horoscope.getAll().filter {
                    $0.name.range(of: searchText, options: .caseInsensitive) != nil }
            }
            tableView.reloadData()
        }
    
    
    // Esto sería el adapter de android
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return horoscopeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HoroscopeCell", for: indexPath) as! HoroscopeViewCell
        let horoscope = horoscopeList[indexPath.row]
        cell.render(horoscope)
        return cell
    }
    
    // La navegación entre pantallas
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NavigationDetailController" {
            let detailVC = segue.destination as! DetailViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let horoscope = horoscopeList[indexPath.row]
            detailVC.horoscope = horoscope
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    

}

