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
    fileprivate static let scheduler = SerialDispatchQueueScheduler.init(qos: .userInteractive)
    private let asset: PHAsset
    let size: CGSize
    var identifier: String
    init? (asset: PHAsset?) {
        guard let asset = asset else { return nil }
        self.asset = asset
        self.identifier = asset.localIdentifier
        self.size = CGSize(width: asset.pixelWidth, height: asset.pixelHeight)
    }
}

extension Photo: WithImage {
    func image(targetSize: CGSize) -> Observable<UIImage?> {
        return Observable.create { observer in
            
            let handle = Photo.imageManager.requestImage(for: self.asset, targetSize: targetSize, contentMode: .aspectFill, options: nil) { (image, info) in
                observer.onNext(image)
                if info?[PHImageResultIsDegradedKey] as? Bool == false {
                    observer.onCompleted()
                }
            }
            
            return Disposables.create {
                Photo.imageManager.cancelImageRequest(handle)
            }
        }.subscribeOn(Photo.scheduler)
    }
}
