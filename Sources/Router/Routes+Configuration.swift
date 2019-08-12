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
            guard let destination = UIViewController.scene(with: route.viewModel) else { return }
            if route.hasNavigation {
                let navigation = UINavigationController(rootViewController: destination)
                 UIApplication.shared.delegate?.window??.rootViewController = navigation
            } else {
                 UIApplication.shared.delegate?.window??.rootViewController = destination
            }
        }
        
        self.register(NavigationRoute.self) { route, scene in
            if let vc = UIViewController.scene(with: route.viewModel) {
                scene?.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        restart()
    }
    
    static func restart() {
        self.execute(RestartRoute(), from: nil)
    }
}
