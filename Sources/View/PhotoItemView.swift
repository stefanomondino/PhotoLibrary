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
        if let image = self.image {
            
            self.rx
                .observeWeakly(CGRect.self, "bounds")
                .map { $0?.size ?? .zero }
                .distinctUntilChanged()
                .bind(to: viewModel.sizeRelay)
                .disposed(by: disposeBag)
            
            viewModel
                .image
                .asDriver(onErrorJustReturn: nil)
                .drive(image.rx.image)
                .disposed(by: disposeBag)
        }
        
    }
}
