//
//  Groups.swift
//  Productive
//
//  Created by Moser, Yannis on 23.04.23.
//

import SwiftUI

struct Group: Identifiable {
    var id: String
    var groupname: String
    var userIDs: [String]
}

struct User: Identifiable {
    var id: String // id = Email
    var firstname: String
    var lastname: String
    var groupIDs: [String]
}
