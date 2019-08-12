//
//  Photo.swift
//  BoomerangSkeleton
//
//  Created by Stefano Mondino on 11/08/2019.
//  Copyright © 2019 Stefano Mondino. All rights reserved.
//

import Foundation
import Photos
import RxSwift

struct Album: EntityType {
    fileprivate static let imageManager: PHCachingImageManager = PHCachingImageManager()
    let collection: PHAssetCollection?
    var identifier: String
    var cover: Photo?
    let title: String
    init (collection: PHAssetCollection, cover: Photo?) {
        self.collection = collection
        self.cover = cover
        self.identifier = collection.localIdentifier
        self.title = collection.localizedTitle ?? ""
    }
    init (cameraRoll: [Photo]) {
        self.collection = nil
        self.identifier = ""
        self.title = "CameraRoll"
        self.cover = cameraRoll.first
    }
}

extension Album: WithImage {
    func image(targetSize: CGSize) -> Observable<UIImage?> {
        return cover?.image(targetSize: targetSize) ?? .just(nil)
    }
}
