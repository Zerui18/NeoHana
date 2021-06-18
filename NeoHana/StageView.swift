//
//  StageView.swift
//  NeoHana
//
//  Created by Zerui Chen on 16/6/21.
//

import SwiftUI
import Script

struct StageView: View {
    
    @ObservedObject var model: StageModel
    
    init(withScript script: IGScript) {
        model = .init(withScript: script)
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct StageView_Previews: PreviewProvider {
    static var previews: some View {
        StageView(withScript: )
    }
}
