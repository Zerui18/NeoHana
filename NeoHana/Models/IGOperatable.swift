//
//  IGOperatable.swift
//  NeoHana
//
//  Created by Zerui Chen on 17/6/21.
//

import Script

protocol IGOperatable {
    var ready: Bool { get }
    func execute(operation: IGOperation)
}
