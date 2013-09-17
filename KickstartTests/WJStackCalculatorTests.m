//
//  WJStackCalculatorTests.m
//  KickstartTests
//
//  Created by Antoni Kedracki on 9/17/13.
//  Copyright (c) 2013 Warsjava. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WJStackCalculator.h"

@interface WJStackCalculatorTests : XCTestCase

@end

@implementation WJStackCalculatorTests{
    WJStackCalculator * calculator;
}

const CGFloat kStackCalculatorTestsSufficient = 0.0001f;

- (void)setUp {
    [super setUp];

    calculator = [WJStackCalculator new];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testStackOperations{
    XCTAssertEqualWithAccuracy(calculator.stackX, 0, kStackCalculatorTestsSufficient);
    XCTAssertEqualWithAccuracy(calculator.stackY, 0, kStackCalculatorTestsSufficient);
    XCTAssertEqual(calculator.stackDepth, (NSUInteger)0);

    [calculator push:15];
    XCTAssertEqualWithAccuracy(calculator.stackX, 15, kStackCalculatorTestsSufficient);
    XCTAssertEqualWithAccuracy(calculator.stackY, 0, kStackCalculatorTestsSufficient);
    XCTAssertEqual(calculator.stackDepth, (NSUInteger)1);

    [calculator push:-79];
    XCTAssertEqualWithAccuracy(calculator.stackX, -79, kStackCalculatorTestsSufficient);
    XCTAssertEqualWithAccuracy(calculator.stackY, 15, kStackCalculatorTestsSufficient);
    XCTAssertEqual(calculator.stackDepth, (NSUInteger)2);

    [calculator pop];
    [calculator pop];
    XCTAssertEqualWithAccuracy(calculator.stackX, 0, kStackCalculatorTestsSufficient);
    XCTAssertEqualWithAccuracy(calculator.stackY, 0, kStackCalculatorTestsSufficient);
    XCTAssertEqual(calculator.stackDepth, (NSUInteger)0);

    [calculator push:5];
    [calculator push:3];
    [calculator duplicate];
    XCTAssertEqualWithAccuracy(calculator.stackX, 3, kStackCalculatorTestsSufficient);
    XCTAssertEqualWithAccuracy(calculator.stackY, 3, kStackCalculatorTestsSufficient);
    XCTAssertEqual(calculator.stackDepth, (NSUInteger)3);

    [calculator pop];
    [calculator push:10];
    [calculator swap];
    XCTAssertEqualWithAccuracy(calculator.stackX, 3, kStackCalculatorTestsSufficient);
    XCTAssertEqualWithAccuracy(calculator.stackY, 10, kStackCalculatorTestsSufficient);
    XCTAssertEqual(calculator.stackDepth, (NSUInteger)3);
}

- (void)testMathOperations{
    XCTAssertEqualWithAccuracy(calculator.stackX, 0, kStackCalculatorTestsSufficient);
    XCTAssertEqualWithAccuracy(calculator.stackY, 0, kStackCalculatorTestsSufficient);
    XCTAssertEqual(calculator.stackDepth, (NSUInteger)0);
    
    [calculator push:2];
    [calculator push:15];
    [calculator push:3];
    [calculator add];
    XCTAssertEqualWithAccuracy(calculator.stackX, 18, kStackCalculatorTestsSufficient);
    XCTAssertEqualWithAccuracy(calculator.stackY, 2, kStackCalculatorTestsSufficient);
    XCTAssertEqual(calculator.stackDepth, (NSUInteger)2);
    
    [calculator push:14];
    [calculator substract];
    XCTAssertEqualWithAccuracy(calculator.stackX, 4, kStackCalculatorTestsSufficient);
    XCTAssertEqualWithAccuracy(calculator.stackY, 2, kStackCalculatorTestsSufficient);
    XCTAssertEqual(calculator.stackDepth, (NSUInteger)2);

    [calculator push:10];
    [calculator multiply];
    XCTAssertEqualWithAccuracy(calculator.stackX, 40, kStackCalculatorTestsSufficient);
    XCTAssertEqualWithAccuracy(calculator.stackY, 2, kStackCalculatorTestsSufficient);
    XCTAssertEqual(calculator.stackDepth, (NSUInteger)2);
    
    [calculator push:8];
    [calculator divide];
    XCTAssertEqualWithAccuracy(calculator.stackX, 5, kStackCalculatorTestsSufficient);
    XCTAssertEqualWithAccuracy(calculator.stackY, 2, kStackCalculatorTestsSufficient);
    XCTAssertEqual(calculator.stackDepth, (NSUInteger)2);
    
    [calculator sqr];
    XCTAssertEqualWithAccuracy(calculator.stackX, 25, kStackCalculatorTestsSufficient);
    XCTAssertEqualWithAccuracy(calculator.stackY, 2, kStackCalculatorTestsSufficient);
    XCTAssertEqual(calculator.stackDepth, (NSUInteger)2);
    
    [calculator push:9];
    [calculator sqrt];
    XCTAssertEqualWithAccuracy(calculator.stackX, 3, kStackCalculatorTestsSufficient);
    XCTAssertEqualWithAccuracy(calculator.stackY, 25, kStackCalculatorTestsSufficient);
    XCTAssertEqual(calculator.stackDepth, (NSUInteger)3);
    
    [calculator multiplyAdd];
    XCTAssertEqualWithAccuracy(calculator.stackX, 2*25+3, kStackCalculatorTestsSufficient);
    XCTAssertEqualWithAccuracy(calculator.stackY, 0, kStackCalculatorTestsSufficient);
    XCTAssertEqual(calculator.stackDepth, (NSUInteger)1);
}

@end
