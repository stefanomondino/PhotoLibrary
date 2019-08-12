//
//  SplashViewModel.swift
//  BoomerangSkeleton
//
//  Created by Stefano Mondino on 11/08/2019.
//  Copyright © 2019 Stefano Mondino. All rights reserved.
//

import Boomerang
import RxSwift

class SplashViewModel: SceneViewModelType, InteractionViewModelType {
    lazy var selection: Selection = defaultSelection()
    var sceneIdentifier: SceneIdentifier = Identifiers.Scene.splash
  
    func start() {
//        let observable = Observable<Interaction>.empty()
        let observable = Observable<Interaction>.just(.route(RestartRoute(viewModel: PhotoListViewModel())))
        self.interact(.observable(observable))
    }
}
