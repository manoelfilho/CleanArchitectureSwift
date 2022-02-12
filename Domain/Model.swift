//
//  Model.swift
//  Domain
//
//  Created by Manoel Filho on 11/02/22.
//

import Foundation

public protocol Model: Encodable {}

public extension Model {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
