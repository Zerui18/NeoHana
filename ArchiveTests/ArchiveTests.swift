//
//  ArchiveTests.swift
//  ArchiveTests
//
//  Created by Zerui Chen on 28/6/21.
//

import XCTest
import Archive

class ArchiveTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testArchiveOpen() throws {
        let archive = IGArchive(path: "/Users/zeruichen/Documents/Personal/NeoHana/NeoHana/Spring/video.iga")
        XCTAssertNotNil(archive)
        print(archive!.entries)
        try! archive!.data(forFile: "op.mpg")!.write(to: URL(fileURLWithPath: "/Users/zeruichen/Documents/op.mpg"))
    }

}
