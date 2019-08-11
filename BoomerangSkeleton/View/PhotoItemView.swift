//
//  PhotoItemView.swift
//  BoomerangSkeleton
//
//  Created by Stefano Mondino on 11/08/2019.
//  Copyright © 2019 Stefano Mondino. All rights reserved.
//

import Foundation
import Boomerang
import UIKit

class PhotoItemView: UIView, ViewModelCompatible {
    
    @IBOutlet weak var titleLabel: UILabel?
    func configure(with viewModel: PhotoItemViewModel) {
        self.titleLabel?.text = viewModel.title
    }
}
