//
//  WJStackCalculatorView.h
//  Kickstart
//
//  Created by Antoni Kedracki on 9/17/13.
//  Copyright (c) 2013 Warsjava. All rights reserved.
//


#import <Foundation/Foundation.h>

@class WJStackCalculatorView;

@protocol WJStackCalculatorViewDelegate <NSObject>

- (void)calculatorView:(WJStackCalculatorView*)calculatorView buttonWasPressed:(UIButton *)button;

@end

@interface WJStackCalculatorView : UIView

@property (nonatomic, strong, readonly) UILabel * inputLabel;
@property (nonatomic, strong, readonly) UILabel * stackLabel;

@property (nonatomic, weak, readwrite) id<WJStackCalculatorViewDelegate> delegate;

@end