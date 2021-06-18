//
//  Assets.swift
//  Hana
//
//  Created by Zerui Chen on 9/11/18.
//  Copyright © 2018 Zerui Chen. All rights reserved.
//

import SwiftUI

struct Assets {
    fileprivate static let baseURL = Bundle.main.bundleURL.appendingPathComponent("Assets")
    
    static func pathForResource(withName filename: String, inFolder folder: String)-> String {
        return baseURL.appendingPathComponent("\(folder)/\(filename)").path
    }
    
    static func loadImage(for instruction: Instruction)-> UIImage? {
        guard let fileName = instruction.string,
            let folderName = instruction.resourceFoldeNamer else {
                return nil
        }
        
        let filePath = Assets.pathForResource(withName: fileName, inFolder: folderName)
        if FileManager.default.fileExists(atPath: filePath) {
            return UIImage(contentsOfFile: filePath)
        }
        
        return nil
    }

}
