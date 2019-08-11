//
//  Routes.swift
//  BoomerangSkeleton
//
//  Created by Stefano Mondino on 11/08/2019.
//  Copyright © 2019 Stefano Mondino. All rights reserved.
//

import Boomerang

struct RestartRoute: ViewModelRoute {
    let viewModel: SceneViewModelType
    
    init(viewModel: SceneViewModelType = SplashViewModel()) {
        self.viewModel = viewModel
    }
}
