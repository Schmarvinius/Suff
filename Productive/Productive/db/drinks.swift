//
//  drinks.swift
//  Productive
//
//  Created by Lindner, Marvin on 26.04.23.
//

import Foundation

struct Drinks : Identifiable {
    var alldrinks : [Int]
    var id : Int
    var timestamp : String
}

struct Drink : Identifiable {
    var id: String
    var name: String
    var pic: String
    var volume: Int
    //var image: UIImage?
}

struct Sessions : Identifiable {
    var id: String
}
