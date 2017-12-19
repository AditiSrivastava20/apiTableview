//
//  SecondViewController.swift
//  apiTblView
//
//  Created by anil kumar srivastava on 12/19/17.
//  Copyright © 2017 AditiSrivastava. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var lblLegs: UILabel!
    @IBOutlet weak var lblAttack: UILabel!
    @IBOutlet weak var lblAttribute: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    var hero: HeroStats?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblName.text = hero?.localized_name
        lblAttribute.text = hero?.primary_attr
        lblAttack.text = hero?.attack_type
        lblLegs.text = "\((hero?.legs)!)"
        let urlString = "https://api.opendota.com" + (hero?.img)!
        let url = URL(string: urlString)
        img.downloadedFrom(url: url!)
    }
    
    
}
extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
