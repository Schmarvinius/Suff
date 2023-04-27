//
//  Groups.swift
//  Productive
//
//  Created by Moser, Yannis on 23.04.23.
//

import SwiftUI

struct Group: Identifiable {
    var id: String
    var name: String
    var userIDs: [String]
}

struct User: Identifiable {
    var id: String // id = Email
    var firstname: String
    var lastname: String
    var groupIDs: [String]
    var height: String
    var weight: String
    var pic: String
}
