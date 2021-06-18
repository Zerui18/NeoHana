//
//  IGScript.swift
//  Script
//
//  Created by Zerui Chen on 13/6/21.
//

import Foundation

public class IGScript {
    
    private let scriptBufferStart: UnsafeRawPointer
    private let scriptBufferLength: Int
    private var scriptBuffer: UnsafeRawPointer
    
    public var currentOperation: IGOperation?
    
    public init(fromPath path: String) throws {
        // Read and decrypt.
        let scriptData = try Data(contentsOf: URL(fileURLWithPath: path)).map { $0 ^ 0xff }
        scriptBuffer = scriptData.withUnsafeBytes { UnsafeRawPointer($0.baseAddress!) }
        scriptBufferStart = scriptBuffer
        scriptBufferLength = scriptData.count
    }
    
    public func nextOperation() -> IGOperation? {
        if scriptBuffer - scriptBufferStart == scriptBufferLength {
            return nil
        }
        currentOperation = IGOperation.from(bytes: &scriptBuffer)
        return currentOperation
    }
    
    public func jump(toOffset offset: Int) {
        scriptBuffer = scriptBufferStart.advanced(by: offset)
    }
    
}
