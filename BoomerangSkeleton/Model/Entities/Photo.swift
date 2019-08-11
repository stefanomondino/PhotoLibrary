//
//  Photo.swift
//  BoomerangSkeleton
//
//  Created by Stefano Mondino on 11/08/2019.
//  Copyright © 2019 Stefano Mondino. All rights reserved.
//

import Foundation
import Photos

struct Photo: EntityType {
    private let asset: PHAsset?
    var identifier: String
    init (asset: PHAsset) {
        self.asset = asset
        self.identifier = asset.localIdentifier
    }
}
