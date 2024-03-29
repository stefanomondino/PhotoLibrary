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

class PhotoListViewModel: SceneViewModelType, ListViewModelType, InteractionViewModelType {
    var sceneIdentifier: SceneIdentifier = Identifiers.Scene.photoList
    
    var dataHolder: DataHolder = DataHolder()
    var selection: Selection = .empty
    var sceneTitle: String = ""
    static func albums() -> PhotoListViewModel {
        let dataHolder = DataHolder(data: DataSources
            .photoLibrary
            .albums(query: .all)
            .map {DataGroup($0)})
        return PhotoListViewModel(dataHolder: dataHolder, title: "Albums")
    }
    
    static func photos(from album: Album) -> PhotoListViewModel {
        
        let dataHolder = DataHolder(data:
            DataSources.photoLibrary.photos(query: .fromAlbum(album))
            .map {DataGroup($0)})
        return PhotoListViewModel(dataHolder: dataHolder, title: album.title)
    }
    
    private init(dataHolder: DataHolder, title: String) {
        self.dataHolder = dataHolder
        self.sceneTitle = title
        self.selection = defaultSelection()
    }
    
    func convert(model: ModelType, at indexPath: IndexPath, for type: String?) -> IdentifiableViewModelType? {
        switch model {
        case let photo as Photo: return PhotoItemViewModel(photo: photo)
        case let album as Album: return PhotoItemViewModel(album: album)
        default: return nil
        }
    }
    
    func handleSelectItem(_ indexPath: IndexPath) -> Observable<Interaction> {
        guard let model = self.dataHolder[indexPath] else { return .empty ()}
        switch model {
        case let album as Album: return .just(.route(NavigationRoute(viewModel: PhotoListViewModel.photos(from: album))))
        default: return .empty()
        }
    }
    
    func aspectRatio(atIndex indexPath: IndexPath) -> CGFloat {
         guard let model = self.dataHolder[indexPath] as? Photo else { return 1 }
        return model.size.width / model.size.height
    }
}
