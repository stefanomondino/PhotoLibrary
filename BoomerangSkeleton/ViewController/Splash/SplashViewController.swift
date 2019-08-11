//
//  SplashViewController.swift
//  BoomerangSkeleton
//
//  Created by Stefano Mondino on 11/08/2019.
//  Copyright © 2019 Stefano Mondino. All rights reserved.
//

import UIKit
import Boomerang
import SnapKit

class SplashViewController: UIViewController, ViewModelCompatible, InteractionCompatible {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let splash = UIStoryboard.init(name: "LaunchScreen", bundle: nil).instantiateInitialViewController() {
            self.addChild(splash)
            view.addSubview(splash.view)
            splash.view.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
        
    }
    func configure(with viewModel: SplashViewModel) {
        viewModel.start()
    }
}
