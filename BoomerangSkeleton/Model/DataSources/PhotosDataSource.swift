//
//  PhotosDataSource.swift
//  BoomerangSkeleton
//
//  Created by Stefano Mondino on 11/08/2019.
//  Copyright © 2019 Stefano Mondino. All rights reserved.
//

import Foundation
import RxSwift
import Photos


protocol PhotosDataSourceType {
    func photos(query: PhotosDataSourceParameters) -> Observable<[Photo]>
}

enum PhotosDataSourceParameters {
    case all
}
class PhotosDataSource: PhotosDataSourceType {
    func photos(query: PhotosDataSourceParameters) -> Observable<[Photo]> {
        return assets().photos()
    }
}

extension PhotosDataSource {
    
    fileprivate func authorizedAssets() -> Observable<[PHAsset]> {
        return authorization()
            .filter { $0 }
            .flatMapLatest { _ in self.assets() }
    }
    
    fileprivate func assets() -> Observable<[PHAsset]> {
        return Observable.create { observer in
            let options = PHFetchOptions()
            
            //            let fetch = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil)
            let fetch = PHAsset.fetchAssets(with: options)
            var assets: [PHAsset] = []
            fetch.enumerateObjects({ (object, count, stop) in
                assets += [object]
            })
            observer.onNext(assets)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    fileprivate func authorization() -> Observable<Bool> {
        return Observable.create { observer in
            PHPhotoLibrary.requestAuthorization({ (status) in
                switch status {
                case .authorized: observer.onNext(true)
                default: observer.onNext(false)
                }
                observer.onCompleted()
            })
            return Disposables.create()
        }
    }
}

extension Observable where Element == [PHAsset] {
    func photos() -> Observable<[Photo]> {
        return self.map { $0.map { Photo(asset: $0) }}
    }
}

