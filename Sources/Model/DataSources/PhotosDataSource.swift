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
    func albums(query: PhotosDataSourceParameters) -> Observable<[Album]>
}

enum PhotosDataSourceParameters {
    case all
    case albums
}
class PhotosDataSource: PhotosDataSourceType {
    func photos(query: PhotosDataSourceParameters) -> Observable<[Photo]> {
        return self.authorized(assets()).photos()
    }
    
    func albums(query: PhotosDataSourceParameters) -> Observable<[Album]> {
        return self.authorized(albums())
            .flatMapLatest { albums in
                Observable.concat(albums
                    .map { album in self
                        .assets(from: album)
                        .map { Album(collection: album, cover: Photo(asset: $0.first)) }
                })
                    .toArray()
            }.flatMapLatest { albums in
                return self.photos(query: .all)
                    .map { [Album(cameraRoll: $0)] + albums }
        }
        
    }
}

extension PhotosDataSource {
    
    fileprivate func authorized<T>(_ observable: Observable<T>) -> Observable<T> {
        return authorization()
            .filter { $0 }
            .flatMapLatest { _ in observable }
    }
    
    fileprivate func assets(from collection: PHAssetCollection? = nil) -> Observable<[PHAsset]> {
        return Observable.create { observer in
            let options = PHFetchOptions()
            
            //            let fetch = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil)
            let fetch: PHFetchResult<PHAsset>
            if let collection = collection {
                fetch = PHAsset.fetchAssets(in: collection, options: options)
            } else {
                fetch = PHAsset.fetchAssets(with: options)
            }
            var assets: [PHAsset] = []
            fetch.enumerateObjects({ (object, count, stop) in
                assets += [object]
            })
            observer.onNext(assets)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    fileprivate func albums() -> Observable<[PHAssetCollection]> {
        return Observable.create { observer in
            let options = PHFetchOptions()
            
            let fetch = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: options)
            var assets: [PHAssetCollection] = []
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
        return self.map { $0.compactMap { Photo(asset: $0) }}
    }
}
//extension Observable where Element == [PHAssetCollection] {
//    func albums() -> Observable<[Album]> {
//        return self.map { $0.map { Album(collection: $0) }}
//    }
//}

