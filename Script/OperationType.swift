//
//  OperationType.swift
//  Script
//
//  Created by Zerui Chen on 12/6/21.
//

import Foundation

extension IGOperation {
    
    /// Enum representing the type of an operation.
    public enum OperationType: UInt16 {
        case subtitle       = 0x0400
        case endParse       = 0x0401
        case goScript       = 0x0402
        case setVariable    = 0x0804
        case incVariable    = 0x0805
        case jmpEqual       = 0x1006
        case jmpNEqual      = 0x1007
        case jmpGThan       = 0x1008
        case jmpSThan       = 0x1009
        case jmpGEqual      = 0x100A
        case jmpSEqual      = 0x100B
        case _blanck1       = 0x080C
        case jmp            = 0x080D
        case wait           = 0x080E
        case updateSave     = 0x040F
        case bgImage        = 0x0410
        case clearPrts      = 0x0810
        case portrait       = 0x0412
        case showPrt        = 0x0813
        case crsDissolve    = 0x0814
        case toBlack        = 0x0816
        case endOption      = 0x041B
        case optMaster      = 0x041C
        case option         = 0x081D
        case bgMusic        = 0x0822
        case bgMusicStop    = 0x0423
        case bgMusicStopAlt = 0x0824
        case voice          = 0x0827
        case soundEff        = 0x0828
        case soundEffEnd    = 0x0429
        case soundEffFade   = 0x082C
        case soundEffAlt    = 0x0C2D
        case title          = 0x043F
        case toggleSub      = 0x0440
        case click          = 0x0454
        case dyAnimStart    = 0x1472
        case dyAnimEnd      = 0x1473
        case dyAnimGrpEnd   = 0x0474
        case dyAnimFlush    = 0x0475
        case dynamicBg      = 0x049C
        case character      = 0x04B4
        case unknown        = 0xFFFF
        
        public var name: String {
            switch self {
            case .subtitle:
                return "subtitle"
            case .endParse:
                return "endParse"
            case .goScript:
                return "goScript"
            case .setVariable:
                return "setVariable"
            case .incVariable:
                return "incVariable"
            case .jmpEqual:
                return "jmpEqual"
            case .jmpNEqual:
                return "jmpNEqual"
            case .jmpGThan:
                return "jmpGThan"
            case .jmpSThan:
                return "jmpSThan"
            case .jmpGEqual:
                return "jmpGEqual"
            case .jmpSEqual:
                return "jmpSEqual"
            case ._blanck1:
                return "_blanck1"
            case .jmp:
                return "jmp"
            case .wait:
                return "wait"
            case .updateSave:
                return "updateSave"
            case .bgImage:
                return "bgImage"
            case .clearPrts:
                return "clearPrts"
            case .portrait:
                return "portrait"
            case .showPrt:
                return "showPrt"
            case .crsDissolve:
                return "crsDissolve"
            case .toBlack:
                return "toBlack"
            case .endOption:
                return "endOption"
            case .optMaster:
                return "optMaster"
            case .option:
                return "option"
            case .bgMusic:
                return "bgMusic"
            case .bgMusicStop:
                return "bgMusicStop"
            case .bgMusicStopAlt:
                return "bgMusicStopAlt"
            case .voice:
                return "voice"
            case .soundEff:
                return "soundEff"
            case .soundEffEnd:
                return "soundEffEnd"
            case .soundEffFade:
                return "soundEffFade"
            case .soundEffAlt:
                return "soundEffAlt"
            case .title:
                return "title"
            case .toggleSub:
                return "toggleSub"
            case .click:
                return "click"
            case .dyAnimStart:
                return "dyAnimStart"
            case .dyAnimEnd:
                return "dyAnimEnd"
            case .dyAnimGrpEnd:
                return "dyAnimGrpEnd"
            case .dyAnimFlush:
                return "dyAnimFlush"
            case .dynamicBg:
                return "dynamicBg"
            case .character:
                return "character"
            case .unknown:
                return "unknown"
            }
        }
        
    }

    
}
