//
//  HexMadnessTests.swift
//  HexMadnessTests
//
//  Created by Darrell Root on 4/27/20.
//  Copyright © 2020 Darrell Root. All rights reserved.
//

import XCTest

class HexMadnessTests: XCTestCase {
    var gameModel = GameModel()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAdjacent() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssert(GameModel.adjacent(lrow: 0, lcolumn: 0, rrow: 1, rcolumn: 0) == true)
        XCTAssert(GameModel.adjacent(lrow: 0, lcolumn: 0, rrow: 2, rcolumn: 0) == false)

        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 3, rrow: 2, rcolumn: 2) == false)
        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 3, rrow: 3, rcolumn: 2) == true)
        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 3, rrow: 4, rcolumn: 2) == true)
        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 3, rrow: 5, rcolumn: 2) == false)

        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 3, rrow: 1, rcolumn: 3) == false)
        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 3, rrow: 2, rcolumn: 3) == true)
        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 3, rrow: 3, rcolumn: 3) == false)
        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 3, rrow: 4, rcolumn: 3) == true)
        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 3, rrow: 5, rcolumn: 3) == false)

        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 3, rrow: 2, rcolumn: 4) == false)
        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 3, rrow: 3, rcolumn: 4) == true)
        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 3, rrow: 4, rcolumn: 4) == true)
        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 3, rrow: 5, rcolumn: 4) == false)

        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 3, rrow: 2, rcolumn: 5) == false)
        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 3, rrow: 3, rcolumn: 5) == false)
        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 3, rrow: 4, rcolumn: 5) == false)
        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 3, rrow: 5, rcolumn: 5) == false)

    }
    
    func testAllAdjacent() throws {
        let adjacentHexes = GameModel.allAdjacent(row: 2, column: 2)
        XCTAssert(adjacentHexes.count == 6)
    }
    
    func testAdjacent2() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 4, rrow: 2, rcolumn: 2) == false)
        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 4, rrow: 3, rcolumn: 2) == false)
        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 4, rrow: 4, rcolumn: 2) == false)
        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 4, rrow: 5, rcolumn: 2) == false)

        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 4, rrow: 1, rcolumn: 3) == false)
        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 4, rrow: 2, rcolumn: 3) == true)
        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 4, rrow: 3, rcolumn: 3) == true)
        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 4, rrow: 4, rcolumn: 3) == false)
        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 4, rrow: 5, rcolumn: 3) == false)

        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 4, rrow: 1, rcolumn: 4) == false)
        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 4, rrow: 2, rcolumn: 4) == true)
        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 4, rrow: 3, rcolumn: 4) == false)
        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 4, rrow: 4, rcolumn: 4) == true)
        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 4, rrow: 5, rcolumn: 4) == false)

        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 4, rrow: 1, rcolumn: 5) == false)
        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 4, rrow: 2, rcolumn: 5) == true)
        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 4, rrow: 3, rcolumn: 5) == true)
        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 4, rrow: 4, rcolumn: 5) == false)
        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 4, rrow: 5, rcolumn: 5) == false)

        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 4, rrow: 1, rcolumn: 6) == false)
        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 4, rrow: 2, rcolumn: 6) == false)
        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 4, rrow: 3, rcolumn: 6) == false)
        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 4, rrow: 4, rcolumn: 6) == false)
        XCTAssert(GameModel.adjacent(lrow: 3, lcolumn: 4, rrow: 5, rcolumn: 6) == false)

    }
    
    func testPath1() {
        let gameModel = GameModel()
        let hex1 = Hex(row: 0, column: 0)
        let hex2 = Hex(row: 1, column: 0)
        let path = gameModel.getPath(startHex: hex1, endHex: hex2)
        XCTAssert(path?.count == 2)
    }
    func testPath2() {
        let gameModel = GameModel()
        let hex1 = Hex(row: 0, column: 0)
        let hex2 = Hex(row: 1, column: 1)
        let path = gameModel.getPath(startHex: hex1, endHex: hex2)
        XCTAssert(path?.count == 3)
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
