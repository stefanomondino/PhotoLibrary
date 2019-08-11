//
//  Identifiers.swift
//  BoomerangSkeleton
//
//  Created by Stefano Mondino on 11/08/2019.
//  Copyright © 2019 Stefano Mondino. All rights reserved.
//

import Foundation

struct Identifiers {}

extension String {
    func firstUppercased() -> String {
        return self.prefix(1).uppercased() + self.dropFirst()
    }
}
