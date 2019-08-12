//
//  Rx+Utilities.swift
//  PhotoLibrary
//
//  Created by Stefano Mondino on 12/08/2019.
//  Copyright © 2019 Stefano Mondino. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

extension Reactive where Base: NSObject {
    func observeWeakly<T>(_ keyPath: KeyPath<Base, T>) -> Observable<T?> {
        return observe(type(of: base[keyPath: keyPath]), NSExpression(forKeyPath: keyPath).keyPath)
    }
}
extension Reactive where Base: UIView {
    
    func frame() -> Observable<CGRect> {
        return observeWeakly(\.frame).map { $0 ?? .zero }
    }
    func bounds() -> Observable<CGRect> {
        return observeWeakly(\.bounds).map { $0 ?? .zero }
    }
}
