//
//  KickstartTests.m
//  KickstartTests
//
//  Created by Antoni Kedracki on 9/17/13.
//  Copyright (c) 2013 Warsjava. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WJCalculator.h"

@interface WJCalculatorTests : XCTestCase

@end

@implementation WJCalculatorTests {
    WJCalculator *calculator;
    NSUInteger notificationsCount;
}

const CGFloat kCalculatorTestsSufficient = 0.0001f;

- (void)setUp {
    [super setUp];
    calculator = [WJCalculator new];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testAccumulatorAccess {
    XCTAssertEqualWithAccuracy(calculator.accumulator, 0, kCalculatorTestsSufficient);
    calculator.accumulator = 14;
    XCTAssertEqualWithAccuracy(calculator.accumulator, 14, kCalculatorTestsSufficient);
}

- (void)testBasicOps {
    calculator.accumulator = 5;
    
    //add
    [calculator add:87];
    XCTAssertEqualWithAccuracy(calculator.accumulator, 92, kCalculatorTestsSufficient);
    [calculator add:-11.5];
    XCTAssertEqualWithAccuracy(calculator.accumulator, 80.5f, kCalculatorTestsSufficient);
    
    //sub
    [calculator substract:13];
    XCTAssertEqualWithAccuracy(calculator.accumulator, 67.5, kCalculatorTestsSufficient);
    [calculator substract:-11.5];
    XCTAssertEqualWithAccuracy(calculator.accumulator, 79, kCalculatorTestsSufficient);
    
    //mul
    [calculator multiply:2];
    XCTAssertEqualWithAccuracy(calculator.accumulator, 158, kCalculatorTestsSufficient);
    [calculator multiply:-0.5f];
    XCTAssertEqualWithAccuracy(calculator.accumulator, -79, kCalculatorTestsSufficient);
    
    //div
    [calculator divide:2];
    XCTAssertEqualWithAccuracy(calculator.accumulator, -39.5, kCalculatorTestsSufficient);
    [calculator divide:-0.5f];
    XCTAssertEqualWithAccuracy(calculator.accumulator, 79, kCalculatorTestsSufficient);
    
    calculator.accumulator = 5;
    
    //sqr
    [calculator sqr];
    XCTAssertEqualWithAccuracy(calculator.accumulator, 25, kCalculatorTestsSufficient);
    
    //sqrt
    [calculator sqrt];
    XCTAssertEqualWithAccuracy(calculator.accumulator, 5, kCalculatorTestsSufficient);
}

- (void)testNotifications{
    notificationsCount = 0;

    [calculator addObserver:self
                 forKeyPath:@"accumulator"
                    options:NSKeyValueObservingOptionNew
                    context:nil];

    calculator.accumulator = 82;
    [calculator add:6];
    [calculator removeObserver:self
                    forKeyPath:@"accumulator"];

    XCTAssertEqual(notificationsCount, (NSUInteger)2);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"accumulator"]){
        if(notificationsCount == 0){
            XCTAssertEqualWithAccuracy(calculator.accumulator, 82, kCalculatorTestsSufficient);
        } else if(notificationsCount == 1){
            XCTAssertEqualWithAccuracy(calculator.accumulator, 88, kCalculatorTestsSufficient);
        }
        ++notificationsCount;
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


@end
