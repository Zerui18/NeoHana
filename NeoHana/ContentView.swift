//
//  ContentView.swift
//  NeoHana
//
//  Created by Zerui Chen on 12/6/21.
//

import SwiftUI

struct ContentView: View {
    @State var movie = ArchiveManager.shared.video(named: "op.mpg")
    var body: some View {
        VLCVideoView(media: $movie)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
