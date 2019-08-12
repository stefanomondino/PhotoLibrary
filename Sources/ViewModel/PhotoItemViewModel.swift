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
    
    let identifier: Identifier
    let title: String
    let image: Observable<UIImage?>
    init(photo: Photo) {
        self.identifier = Identifiers.View.photo
        title = photo.identifier
        image = photo
            .image(targetSize: CGSize(width: 300, height: 300))
            .share(replay: 1, scope: .forever)
            .startWith(UIImage())
    }
    init (album: Album) {
        title = album.title
        self.identifier = Identifiers.View.album
        image = album.cover?.image(targetSize: CGSize(width: 300, height: 300)) ?? .just(nil)
    }
}
