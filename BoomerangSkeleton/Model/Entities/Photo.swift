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

struct Photo: EntityType {
    fileprivate static let imageManager: PHCachingImageManager = PHCachingImageManager()
    private let asset: PHAsset
    var identifier: String
    init (asset: PHAsset) {
        self.asset = asset
        self.identifier = asset.localIdentifier
    }
}

extension Photo: WithImage {
    func image(targetSize: CGSize) -> Observable<UIImage?> {
        return Observable.create { observer in
            
            let handle = Photo.imageManager.requestImage(for: self.asset, targetSize: targetSize, contentMode: .aspectFill, options: nil) { (image, info) in
                observer.onNext(image)
                if info?[PHImageResultIsDegradedKey] == nil {
                    observer.onCompleted()
                }
            }
            
            return Disposables.create {
                Photo.imageManager.cancelImageRequest(handle)
            }
        }
    }
}
