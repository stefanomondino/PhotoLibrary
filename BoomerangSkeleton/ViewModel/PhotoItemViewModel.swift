//
//  PhotoItemViewModel.swift
//  BoomerangSkeleton
//
//  Created by Stefano Mondino on 11/08/2019.
//  Copyright © 2019 Stefano Mondino. All rights reserved.
//

import Foundation
import Boomerang

class PhotoItemViewModel: ItemViewModelType {
    
    var identifier: Identifier = Identifiers.View.photo
    let title: String
    
    init(photo: Photo) {
        title = photo.identifier
    }
}
