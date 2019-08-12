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
    
    enum View: String, CaseIterable {
        
        case photo
        case album
    }
}

extension Identifiers.View: ViewIdentifier {
    func view<T>() -> T? where T : View {
        return Bundle.main.loadNibNamed(self.name, owner: nil, options: nil)?.first as? T
    }
    
    var shouldBeEmbedded: Bool {
        return true
    }
    
    var containerClass: AnyClass? {
        return nil
    }
    
    
    var name: String {
        return rawValue.firstUppercased() + "ItemView"
    }
    
}
