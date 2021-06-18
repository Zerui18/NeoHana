//
//  PortraitsModel.swift
//  NeoHana
//
//  Created by Zerui Chen on 17/6/21.
//

import SwiftUI
import Script

class PortraitsModel: ObservableObject, IGOperatable {
    
    @Published var portraits = []
    
    var ready = false
    
    func execute(operation: IGOperation) {
        
    }
    
}
