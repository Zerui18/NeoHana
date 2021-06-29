//
//  AudioModel.swift
//  NeoHana
//
//  Created by Zerui Chen on 28/6/21.
//

import MobileVLCKit
import Script

class AudioModel: IGOperatable {
    
    private let voicePlayer = VLCMediaPlayer()
    private let bgmPlayer = VLCMediaPlayer()
    
    var ready: Bool { true }
    
    func execute(operation: IGOperation) {
        switch operation.type {
        case .voice:
            let media = ArchiveManager.shared.voice(named: operation.string!)
            voicePlayer.media = media
        case .bgMusic:
            let media = ArchiveManager.shared.bgm(named: operation.string!)
            bgmPlayer.media = media
        case .bgMusicStop:
            bgmPlayer.media = nil
        case .bgMusicStopAlt:
            bgmPlayer.media = nil
//        case .soundEff:
//        case .soundEffAlt:
//        case .soundEffFade:
//        case .soundEffEnd:
        default: break
        }
    }
    
    func playbgm(named name: String) {
        let media = ArchiveManager.shared.bgm(named: name)
        bgmPlayer.media = media
        bgmPlayer.play()
    }
}
