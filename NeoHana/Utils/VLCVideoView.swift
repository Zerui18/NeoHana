//
//  VLCVideoView.swift
//  NeoHana
//
//  Created by Zerui Chen on 29/6/21.
//

import SwiftUI
import MobileVLCKit

struct VLCVideoView: UIViewRepresentable {
    
    @Binding var media: VLCMedia?
    @State private var player = VLCMediaPlayer(options: ["-vvvv"])!
        
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        player.drawable = view
        view.backgroundColor = .blue
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        player.media = media
        if media != nil {
            player.play()
        }
    }
    
    func cleanup() {
        player.stop()
    }
}
