//
//  PhotoListViewModel.swift
//  BoomerangSkeleton
//
//  Created by Stefano Mondino on 11/08/2019.
//  Copyright © 2019 Stefano Mondino. All rights reserved.
//

import Foundation
import Boomerang
import RxSwift

class PhotoListViewModel: SceneViewModelType, ListViewModel {
    var sceneIdentifier: SceneIdentifier = Identifiers.Scene.photoList
    
    typealias DataType = [Photo]
    
    var dataHolder: DataHolder = DataHolder()
    
    init() {
        self.dataHolder = DataHolder(data: group(DataSources.photoLibrary.photos(query: .all)))
    }
    
    func group(_ observable: Observable<[Photo]>) -> Observable<DataGroup> {
        return observable.map { DataGroup($0) }
    }
    
    func convert(model: ModelType, at indexPath: IndexPath, for type: String?) -> IdentifiableViewModelType? {
        switch model {
        case let photo as Photo: return PhotoItemViewModel(photo: photo)
        default: return nil
        }
    }
    
    
}
