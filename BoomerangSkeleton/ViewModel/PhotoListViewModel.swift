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

class PhotoListViewModel: SceneViewModelType, ListViewModelType {
    var sceneIdentifier: SceneIdentifier = Identifiers.Scene.photoList
    
    var dataHolder: DataHolder = DataHolder()
    
    init() {
        self.dataHolder = DataHolder(data: DataSources
            .photoLibrary
            .albums(query: .all)
            .map {DataGroup($0)})
    }
    
    func convert(model: ModelType, at indexPath: IndexPath, for type: String?) -> IdentifiableViewModelType? {
        switch model {
        case let photo as Photo: return PhotoItemViewModel(photo: photo)
        case let album as Album: return PhotoItemViewModel(album: album)
        default: return nil
        }
    }
    
    
}
