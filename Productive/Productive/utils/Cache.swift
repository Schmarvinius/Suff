//
//  Cache.swift
//  Productive
//
//  Created by Lindner, Marvin on 26.04.23.
//

import Foundation

class CacheManager {
    
    static let instance = CacheManager()
    private init() {}
    
    var StringCache: NSCache<NSString, NSString> =  {
        let cache = NSCache<NSString, NSString>()
        cache.countLimit = 1
        cache.totalCostLimit = 1024 * 1024 * 1 // 1MB
        return cache
    }()
    
    func remove(key: String) {
        StringCache.removeObject(forKey: key as NSString)
    }
    
    func addString(value: String, key: String) {
        StringCache.setObject(value as NSString, forKey: key as NSString)
    }
    
    func getString(key: String) -> String {
        return String(StringCache.object(forKey: key as NSString) ?? "")
    }
}
