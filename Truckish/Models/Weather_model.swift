//
//  Weather_model.swift
//  Truckish
//
//  Created by SUBRAT on 6/1/18.
//  Copyright © 2018 subratpadhi007. All rights reserved.
//

import Foundation
import ObjectMapper

class Weather_model: Mappable {
    var coord : GeoCode?
    var weather : Array<Weather>?
    var base = ""
    var main : Main?
    var visibility = ""
    var wind : Wind?
    var clouds = ""
    var dt = ""
    var sys : Sys?
    var id = ""
    var name = ""
    var cod = ""
    
    required init?(map: Map) {}
    init() {}
    
    func mapping(map: Map) {
        coord <- map["coord"]
        base <- map["base"]
        weather <- map["weather"]
        main <- map["main"]
        visibility <- map["visibility"]
        wind <- map["wind"]
        clouds <- map["clouds"]
        dt <- map["dt"]
        sys <- map["sys"]
        name <- map["name"]
        id <- map["id"]
        cod <- map["cod"]
    }
}

class Wind: Mappable {
    var speed = 0.00
    
    required init?(map: Map) {}
    init() {}
    
    func mapping(map: Map) {
        speed <- map["speed"]
    }
}

class Sys: Mappable {
    var country = "IN"
    var sunrise = 0
    var sunset = 0

    required init?(map: Map) {}
    init() {}

    func mapping(map: Map) {
        country <- map["country"]
        sunrise <- map["sunrise"]
        sunset <- map["sunset"]
    }
}

class Main: Mappable {
    var temp = 0.00
    var pressure = 0
    var humidity = 0
    var temp_min = 0.00
    var temp_max = 0.00
    
    required init?(map: Map) {}
    init() {}
    
    func mapping(map: Map) {
        temp <- map["temp"]
        pressure <- map["pressure"]
        humidity <- map["humidity"]
        temp_min <- map["temp_min"]
        temp_max <- map["temp_max"]
    }
}

class GeoCode: Mappable {
    var lat = 0.00
    var lon = 0.00
    
    required init?(map: Map) {}
    init() {}
    
    func mapping(map: Map) {
        lat <- map["lat"]
        lon <- map["lon"]
    }
}

class Weather: Mappable {
    var main = ""
    var desc = ""
    
    required init?(map: Map) {}
    init() {}
    
    func mapping(map: Map) {
        main <- map["main"]
        desc <- map["description"]
    }
}
