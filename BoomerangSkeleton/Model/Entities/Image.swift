//
//  Imaeg.swift
//  BoomerangSkeleton
//
//  Created by Stefano Mondino on 11/08/2019.
//  Copyright © 2019 Stefano Mondino. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

protocol WithImage {
    func image(targetSize: CGSize) -> Observable<UIImage?>
}

extension UIImage: WithImage {
    func image(targetSize: CGSize) -> Observable<UIImage?> {
        return .just(self)
    }
}

extension String: WithImage {
    func image(targetSize: CGSize) -> Observable<UIImage?> {
        return .just(UIImage(named: self))
    }
}
