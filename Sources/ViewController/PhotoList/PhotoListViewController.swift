//
//  PhotoListViewController.swift
//  BoomerangSkeleton
//
//  Created by Stefano Mondino on 11/08/2019.
//  Copyright © 2019 Stefano Mondino. All rights reserved.
//

import UIKit
import Boomerang
import PluginLayout

private class PhotosDelegate: CollectionViewDelegate, PluginLayoutDelegate, MosaicLayoutDelegate {
    weak var viewModel: PhotoListViewModel?
    init(viewModel: PhotoListViewModel) {
        self.viewModel = viewModel
    }
    func collectionView(_ collectionView: UICollectionView, layout: PluginLayout, aspectRatioAt indexPath: IndexPath) -> CGFloat {
        return viewModel?.aspectRatio(atIndex: indexPath) ?? 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: PluginLayout, columnsForSectionAt section: Int) -> Int {
        return 3
    }
    
    
}

class PhotoListViewController: UIViewController, ViewModelCompatible, InteractionCompatible {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func configure(with viewModel: PhotoListViewModel) {
        
        let delegate = PhotosDelegate(viewModel: viewModel)
            .with(size: { cv, indexPath, type in
                if type != nil { return .zero }
                let width = cv.boomerang.calculateFixedDimension(for: .vertical, at: indexPath, itemsPerLine: 3)
                let ratio = viewModel.aspectRatio(atIndex: indexPath)
                return CGSize(width: width, height: width / ratio)
            })
            .with(insets: { _, _ in return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)})
            .with(itemSpacing: {_, _ in return 2})
            .with(lineSpacing: {_, _ in return 2})
            .with (select:{ viewModel.selection.execute(.selectItem($0)) })
        
        collectionView.boomerang.configure(with: viewModel, delegate: delegate)
        let layout = MosaicLayout()
        self.collectionView.setCollectionViewLayout(layout, animated: false)
        
        viewModel.load()
    }
}
