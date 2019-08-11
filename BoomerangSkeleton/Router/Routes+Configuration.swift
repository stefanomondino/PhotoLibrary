//
//  Routes+Configuration.swift
//  BoomerangSkeleton
//
//  Created by Stefano Mondino on 11/08/2019.
//  Copyright © 2019 Stefano Mondino. All rights reserved.
//

import Boomerang

extension Router {
    static func bootstrap() {
        self.register(RestartRoute.self) { route, scene in
            UIApplication.shared.delegate?.window??.rootViewController = UIViewController.scene(with: route.viewModel)
        }
        
        restart()
    }
    
    static func restart() {
        self.execute(RestartRoute(), from: nil)
    }
}
