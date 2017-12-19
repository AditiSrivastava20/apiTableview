//
//  HeroStats.swift
//  apiTblView
//
//  Created by anil kumar srivastava on 12/19/17.
//  Copyright © 2017 AditiSrivastava. All rights reserved.
//

import Foundation
struct HeroStats: Decodable {
    let localized_name: String
    let attack_type: String
    let legs:Int
    let primary_attr: String
    let img: String
    
}

