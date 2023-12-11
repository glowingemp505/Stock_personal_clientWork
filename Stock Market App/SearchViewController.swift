//
//  SearchViewController.swift
//  Stock Market App
//
//  Created by Truepicks on 12/10/23.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Stocks", for: indexPath) as! StockTableViewCell
        
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        
        textFieldInsideSearchBar?.textColor = .white
        
        // Do any additional setup after loading the view.
    }
    
    
}
