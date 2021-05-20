//
//  UIKitExtensions.swift
//  SightCallAlpha
//
//  Created by Jason Jobe on 3/15/21.
//

import UIKit

// MARK: UIViewController Extenstion

public extension UIResponder {
    var sightCall: SightCallSDK? {
        var target: UIResponder? = self
        while target != nil {
//            print (#function, target?.className ?? "<Responder>")
            if let mgr = target as? SightCallProvider {
                return mgr.sightCallSDK
            }
            if let scene = target as? UIWindowScene,
               let mgr = scene.delegate as? SightCallProvider {
                return mgr.sightCallSDK
            }
            target = target?.next
        }
        return nil
    }
}

public extension UserDefaults {
    func register(settings: String = "Settings") {
        guard
            let path = Bundle.main.path(forResource: settings, ofType: "bundle"),
            let rpath = Bundle(path: path)?.path(forResource: "Root", ofType: "plist"),
            let plist = NSDictionary(contentsOfFile: rpath),
            let ps = plist.value(forKeyPath: "PreferenceSpecifiers") as? [[String:Any]]
        else { return }
        var items = [String: Any]()
        for item in ps {
            guard let key = item["Key"] as? String, let value = item["DefaultValue"]
            else { continue }
            items[key] = value
        }
        self.register(defaults: items)
    }
}

public extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
