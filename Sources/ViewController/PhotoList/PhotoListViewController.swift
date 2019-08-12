//
//  PhotoListViewController.swift
//  BoomerangSkeleton
//
//  Created by Stefano Mondino on 11/08/2019.
//  Copyright © 2019 Stefano Mondino. All rights reserved.
//

import UIKit
import Boomerang

class PhotoListViewController: UIViewController, ViewModelCompatible, InteractionCompatible {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func configure(with viewModel: PhotoListViewModel) {
        
        let delegate = CollectionViewDelegate()
            .with(size: { cv, indexPath, type in
                if type != nil { return .zero }
                return CGSize(width: 100, height: 100)
            })
            .with (select:{ viewModel.selection.execute(.selectItem($0)) })
        
        collectionView.boomerang.configure(with: viewModel, delegate: delegate)
        
        viewModel.load()
    }
}
