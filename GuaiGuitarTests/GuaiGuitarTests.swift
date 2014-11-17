//
//  GuaiGuitarTests.swift
//  GuaiGuitarTests
//
//  Created by 葛羽航 on 14/11/13.
//  Copyright (c) 2014年 xiaoge. All rights reserved.
//

import UIKit
import XCTest

class GuaiGuitarTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
                let clrStr = ["#ff6", "#ff8790", "rgba(34 ,  56, 225, 0.56)", "  rgb ( 42, 64, 245) "];
                let rArr: [Double] = [255, 255, 34, 42];
                let gArr:[Double] = [255, 135, 144, 64];
                let bArr:[Double] = [102, 144, 225, 245];
                let aArr:[Double] = [1.0, 1.0, 0.56, 1.0];
        
        let clr = str2color(clrStr[3])
        println(clr);
        let clrRef = CGColorGetComponents(clr!.CGColor);
        println(NSString(format: "%.0f %.0f %.0f %.2f", Double(clrRef[0] * 255), Double(clrRef[1]*255), Double(clrRef[2] * 255),Double(CGColorGetAlpha(clr!.CGColor))));
//        for var i = 0; i<clrStr.count; i++ {
//            let clr = str2color(clrStr[i]);
//            println(clr);
//            XCTAssert(clr != nil, "nil color");
//            var r: CGFloat, g: CGFloat, b: CGFloat, a : CGFloat;
//            let r = Double(clrRef[0] * 255);
        
//
//            XCTAssert(clr!.getRed(red: &r, green: &g, blue: &b, alpha: &a)==true, "get color");
//            XCTAssert(Double(clrRef[0] * 255) == rArr[i], "red");
//            XCTAssert(Double(clrRef[1] * 255) == gArr[i], "green");
//            XCTAssert(Double(clrRef[2] * 255) == bArr[i], "blue");
//            XCTAssert(Double(CGColorGetAlpha(clr!.CGColor)) == aArr[i], "alpha");
            
//        }
        
    }
    
//    func testPerformanceExample() {
        // This is an example of a performance test case.
//        self.measureBlock() {
            // Put the code you want to measure the time of here.
//        }
//    }
    
}
