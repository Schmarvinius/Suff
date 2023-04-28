//
//  LocalStorage.swift
//  Productive
//
//  Created by Lindner, Marvin on 27.04.23.
//

import Foundation

class MyLocalStorage {
    
    init() {
        
    }
    
    public func setValue (key: String, value: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    public func getValue (key: String) -> String {
        return UserDefaults.standard.string(forKey: key) ?? ""
    }
    
    public func deleteValue (key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
