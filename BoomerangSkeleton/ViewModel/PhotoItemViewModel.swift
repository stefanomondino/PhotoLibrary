//
//  PhotoItemViewModel.swift
//  BoomerangSkeleton
//
//  Created by Stefano Mondino on 11/08/2019.
//  Copyright © 2019 Stefano Mondino. All rights reserved.
//

import Foundation
import Boomerang
import RxSwift

class PhotoItemViewModel: ItemViewModelType {
    
    var identifier: Identifier = Identifiers.View.photo
    let title: String
    let image: Observable<UIImage?>
    init(photo: Photo) {
        title = photo.identifier
        image = photo.image(targetSize: CGSize(width: 300, height: 300))
    }
}
