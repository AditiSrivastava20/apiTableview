//
//  ViewController.swift
//  apiTblView
//
//  Created by anil kumar srivastava on 12/19/17.
//  Copyright © 2017 AditiSrivastava. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblView: UITableView!
    var heroes = [HeroStats]()
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadData {
            self.tblView.reloadData()
            print("SUCESSFUL")
        }
        tblView.delegate = self
        tblView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    func downloadData(completed: @escaping () -> ()){
        let url = URL(string: "https://api.opendota.com/api/heroStats")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
        if error == nil {
            do {
            self.heroes = try JSONDecoder().decode([HeroStats].self, from: data!)
        
            DispatchQueue.main.async {
                completed()
            }
            }
            catch {
                print("error")
            }
        }
    }.resume()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = heroes[indexPath.row].localized_name.capitalized
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "secondvc", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destionation = segue.destination as? SecondViewController{
            destionation.hero = heroes[(tblView.indexPathForSelectedRow?.row)!]
            
        }
    }

}


