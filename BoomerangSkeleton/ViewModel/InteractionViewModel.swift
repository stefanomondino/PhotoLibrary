//
//  InteractionViewModel.swift
//  BoomerangSkeleton
//
//  Created by Stefano Mondino on 11/08/2019.
//  Copyright © 2019 Stefano Mondino. All rights reserved.
//

import Boomerang
import RxSwift

extension InteractionViewModelType {
    func handleCustom(_ interaction: CustomInteraction) -> Observable<Interaction> {
        return .empty()
    }
}
