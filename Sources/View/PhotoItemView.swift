//
//  PhotoItemView.swift
//  BoomerangSkeleton
//
//  Created by Stefano Mondino on 11/08/2019.
//  Copyright © 2019 Stefano Mondino. All rights reserved.
//

import Foundation
import Boomerang
import UIKit
import RxSwift
import RxCocoa

class PhotoItemView: UIView, ViewModelCompatible {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel?
    func configure(with viewModel: PhotoItemViewModel) {
        self.disposeBag = DisposeBag()
        self.titleLabel?.text = viewModel.title
        viewModel.image.asDriver(onErrorJustReturn: nil)
            .drive(image.rx.image).disposed(by: disposeBag)
        
    }
}
