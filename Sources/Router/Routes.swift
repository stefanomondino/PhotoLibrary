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
    let hasNavigation: Bool
    init(viewModel: SceneViewModelType = SplashViewModel()) {
        self.viewModel = viewModel
        hasNavigation = !(viewModel is SplashViewModel)
    }
}

struct NavigationRoute: ViewModelRoute {
    let viewModel: SceneViewModelType
}
