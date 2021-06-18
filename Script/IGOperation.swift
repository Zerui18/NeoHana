//
//  IGOperation.swift
//  Script
//
//  Created by Zerui Chen on 12/6/21.
//

import Foundation

/// A basic unit of operation in a `IGScript`.
public struct IGOperation {
    // MARK: Header
    /// The type of the operation.
    public let type: OperationType
    /// An additional number for extra info.
    public let num: UInt16
    
    // MARK: Body
    /// Parameters of this operation.
    public let params: [UInt16]
    
    public let string: String?
    
    // MARK: Methods
    ///Initialise an `IGOperation` from a raw pointer.
    static func from(bytes: inout UnsafeRawPointer) -> IGOperation {
        // Read operation type and nubmer.
        let opTypeRaw = loadUInt16(bytes: bytes)
        let opType    = OperationType(rawValue: opTypeRaw) ?? .unknown
        let opNum     = loadUInt16(bytes: bytes.advanced(by: 2))
        // Read additional params.
        let nParams   = Int(opTypeRaw >> 8 - 4) / 2
        let paramsStart = UnsafeBufferPointer(start: bytes.advanced(by: 4).assumingMemoryBound(to: UInt16.self), count: nParams)
        let params    = [UInt16](paramsStart)
        // Advance buffer.
        bytes = bytes.advanced(by: Int(opTypeRaw >> 8))
        // Read string, if present.
        let string: String?
        switch opType {
        case .portrait, .bgImage, .title, .dynamicBg, .character, .goScript, .subtitle, .updateSave:
            string = readConstrainedString(&bytes, opNum)
        case .voice, .bgMusic, .soundEff:
            string = readConstrainedString(&bytes, params[1])
        case .soundEffAlt:
            string = readConstrainedString(&bytes, params[2])
        default:
            string = nil
        }
        return .init(type: opType, num: opNum, params: params, string: string)
    }
}

fileprivate func loadUInt16(bytes: UnsafeRawPointer) -> UInt16 {
    var int: UInt16 = 0
    memcpy(&int, bytes, 2)
    return int
}
