//
//  ScriptTests.swift
//  ScriptTests
//
//  Created by Zerui Chen on 16/6/21.
//

import XCTest
import Script

class ScriptTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testSummerScript() throws {
        let script = try IGScript(fromPath: "/Users/zeruichen/Downloads/script/02a_00001.s")
        while let op = script.nextOperation() {
            print(op)
        }
    }

}
