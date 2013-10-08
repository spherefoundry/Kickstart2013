//
//  WJStackCalculatorButtonSequenceTranslator.h
//  Kickstart
//
//  Created by Antoni Kedracki on 10/8/13.
//  Copyright (c) 2013 Warsjava. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface WJStackCalculatorButtonSequenceTranslator : NSObject

- (void)inputDigit:(NSUInteger)digit;
- (void)inputDot;
- (void)clear;

@property (nonatomic, assign, readonly) CGFloat value;

@end