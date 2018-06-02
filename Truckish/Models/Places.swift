//
//  Places.swift
//  Truckish
//
//  Created by SUBRAT on 5/30/18.
//  Copyright © 2018 subratpadhi007. All rights reserved.
//

import UIKit
import ObjectMapper

class Places: Mappable {
    var name = ""
    var desc = ""
    var location = ""
    
    required init?(map: Map) {
        
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        desc <- map["description"]
        location <- map["location"]
    }
}
