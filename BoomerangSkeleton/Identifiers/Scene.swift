//
//  Scene.swift
//  BoomerangSkeleton
//
//  Created by Stefano Mondino on 11/08/2019.
//  Copyright © 2019 Stefano Mondino. All rights reserved.
//

import Foundation
import Boomerang

extension Identifiers {
    
    enum Scene: String, CaseIterable {
        
        case splash
        case photoList
        
    }
}

extension Identifiers.Scene: SceneIdentifier {
    func scene<T>() -> T? where T : Scene {
         return xibClass?.init(nibName: self.name, bundle: nil) as? T
    }
    
    private var xibClass: UIViewController.Type? {
        switch self {
        default :
            let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? ""
            return NSClassFromString(bundleName + "." + name) as? UIViewController.Type
        }
    }
    
    var name: String {
        return rawValue.firstUppercased() + "ViewController"
    }
    
}
