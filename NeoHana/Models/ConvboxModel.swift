//
//  ConvboxModel.swift
//  NeoHana
//
//  Created by Zerui Chen on 17/6/21.
//

import SwiftUI
import Script

class ConvboxModel: ObservableObject, IGOperatable {
    
    @Published var subtitle = ""
    @Published var characterName: String?
    @Published var characterAvatar: Image?
    
    var ready = false
    
    func execute(operation: IGOperation) {
        switch operation.type {
        case .subtitle:
            let string = operation.string!
            if string.starts(with: "＃") {
                characterName = String(string[string.index(after: string.startIndex)])
            }
            else {
                subtitle = string
            }
        case .character:
            characterImage
        }
    }
    
}
