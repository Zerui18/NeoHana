//
//  ArchiveManager.swift
//  NeoHana
//
//  Created by Zerui Chen on 28/6/21.
//

import UIKit
import Script
import Archive
import MobileVLCKit

fileprivate let baseURL = URL(fileURLWithPath: "/Users/zeruichen/Documents/Personal/NeoHana/NeoHana/Spring")

class ArchiveManager {
    
    static let shared = ArchiveManager()
    
    fileprivate init() {}
    
    // MARK: Archives
    private let bgimageArchive = IGArchive(path: baseURL.appendingPathComponent("bgimage.iga").path)!
    private let bgmArchive = IGArchive(path: baseURL.appendingPathComponent("bgm.iga").path)!
    private let scriptArchive = IGArchive(path: baseURL.appendingPathComponent("script.iga").path)!
    private let seArchive = IGArchive(path: baseURL.appendingPathComponent("se.iga").path)!
    private let systemArchive = IGArchive(path: baseURL.appendingPathComponent("system.iga").path)!
    private let videoArchive = IGArchive(path: baseURL.appendingPathComponent("video.iga").path)!
    private let voiceArchive = IGArchive(path: baseURL.appendingPathComponent("voice.iga").path)!
    
    func bgimage(named fileName: String) -> UIImage? {
        bgimageArchive.data(forFile: fileName).flatMap(UIImage.init(data:))
    }
    
    func bgm(named fileName: String) -> VLCMedia? {
        bgmArchive.data(forFile: fileName).flatMap {
            VLCMedia(stream: InputStream(data: $0))
        }
    }
    
    func script(named fileName: String) -> IGScript? {
        scriptArchive.data(forFile: fileName).flatMap(IGScript.init)
    }
    
    func se(named fileName: String) -> VLCMedia? {
        seArchive.data(forFile: fileName).flatMap {
            VLCMedia(stream: InputStream(data: $0))
        }
    }
    
    func system(named fileName: String) -> UIImage? {
        systemArchive.data(forFile: fileName).flatMap(UIImage.init(data:))
    }
    
    func video(named fileName: String) -> VLCMedia? {
        videoArchive.data(forFile: fileName).flatMap {
            VLCMedia(stream: InputStream(data: $0))
        }
    }
    
    func voice(named fileName: String) -> VLCMedia? {
        voiceArchive.data(forFile: fileName).flatMap {
            VLCMedia(stream: InputStream(data: $0))
        }
    }
    
}
