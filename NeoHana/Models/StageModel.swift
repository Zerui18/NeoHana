//
//  StageModel.swift
//  NeoHana
//
//  Created by Zerui Chen on 16/6/21.
//

import UIKit
import Script
import Archive

class StageModel: ObservableObject, IGOperatable {
    
    // MARK: Published
    @Published var convboxShown = true
    
    // MARK: Privates
    private var currentScript: IGScript
    private var isSkipping = false
    private var isWaiting: Bool {
        waitTimer == nil
    }
    private var waitTimer: Timer?
    private var variables = [UInt16:UInt16]()
    
    // MARK: Submodels
    private let submodels: [IGOperatable] = [ConvboxModel(), PortraitsModel(), BackgroundModel()]
    
    init(withScript script: IGScript) {
        currentScript = script
        setupRunLoop()
    }
    
    func pressed() {
        if isWaiting {
            waitTimer?.invalidate()
            waitTimer = nil
        }
    }
    
    var ready: Bool {
         submodels.reduce(!isWaiting) { $0 && $1.ready }
    }
    
    func execute(operation: IGOperation) {
        switch operation.type {
        case .wait:
            waitTimer = .scheduledTimer(withTimeInterval: Double(operation.num) / 1000, repeats: false) { _ in
                self.waitTimer = nil
            }
        case .toggleSub:
            convboxShown = operation.num == 1
        case .setVariable:
            variables[operation.num] = operation.params[0]
        case .incVariable:
            variables[operation.num, default: 0] += operation.params[0]
        case .jmp:
            currentScript.jump(toOffset: Int(operation.params[0]))
        case .jmpEqual:
            if variables[operation.params[0], default: 0] == operation.params[2] {
                currentScript.jump(toOffset: Int(operation.params[4]))
            }
        case .jmpNEqual:
            if variables[operation.params[0], default: 0] != operation.params[2] {
                currentScript.jump(toOffset: Int(operation.params[4]))
            }
        case .jmpGThan:
            if variables[operation.params[0], default: 0] > operation.params[2] {
                currentScript.jump(toOffset: Int(operation.params[4]))
            }
        case .jmpGEqual:
            if variables[operation.params[0], default: 0] >= operation.params[2] {
                currentScript.jump(toOffset: Int(operation.params[4]))
            }
        case .jmpSThan:
            if variables[operation.params[0], default: 0] < operation.params[2] {
                currentScript.jump(toOffset: Int(operation.params[4]))
            }
        case .jmpSEqual:
            if variables[operation.params[0], default: 0] <= operation.params[2] {
                currentScript.jump(toOffset: Int(operation.params[4]))
            }
        default:
            submodels.forEach { $0.execute(operation: operation) }
        }
    }
    
    // MARK: Privates
    private func setupRunLoop() {
        let link = CADisplayLink(target: self, selector: #selector(tick))
        link.add(to: .current, forMode: .default)
    }
    
    @objc private func tick(displayLink: CADisplayLink) {
        if ready, let operation = currentScript.nextOperation() {
            execute(operation: operation)
        }
    }
    
}
