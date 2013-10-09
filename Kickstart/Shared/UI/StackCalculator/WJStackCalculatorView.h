//
//  WJStackCalculatorView.h
//  Kickstart
//
//  Created by Antoni Kedracki on 9/17/13.
//  Copyright (c) 2013 Warsjava. All rights reserved.
//


#import <Foundation/Foundation.h>

typedef enum {
    WJStackCalculatorViewButtonIdNumber0 = 0,
    WJStackCalculatorViewButtonIdNumber1 = 1,
    WJStackCalculatorViewButtonIdNumber2 = 2,
    WJStackCalculatorViewButtonIdNumber3 = 3,
    WJStackCalculatorViewButtonIdNumber4 = 4,
    WJStackCalculatorViewButtonIdNumber5 = 5,
    WJStackCalculatorViewButtonIdNumber6 = 6,
    WJStackCalculatorViewButtonIdNumber7 = 7,
    WJStackCalculatorViewButtonIdNumber8 = 8,
    WJStackCalculatorViewButtonIdNumber9 = 9,
    WJStackCalculatorViewButtonIdNumberDot = 10,
    WJStackCalculatorViewButtonIdClear = 20,
    WJStackCalculatorViewButtonIdPush = 21,
    WJStackCalculatorViewButtonIdPop = 22,
    WJStackCalculatorViewButtonIdSwap = 23,
    WJStackCalculatorViewButtonIdDup = 24,
    WJStackCalculatorViewButtonIdAdd = 30,
    WJStackCalculatorViewButtonIdSubstract = 31,
    WJStackCalculatorViewButtonIdMultiply = 32,
    WJStackCalculatorViewButtonIdDivide = 33,

} WJStackCalculatorViewButtonId;

@class WJStackCalculatorView;

@protocol WJStackCalculatorViewDelegate <NSObject>

- (void)calculatorView:(WJStackCalculatorView*)calculatorView buttonWasPressed:(WJStackCalculatorViewButtonId)buttonId;

@end

@interface WJStackCalculatorView : UIView

@property (nonatomic, strong, readonly) UILabel * inputLabel;
@property (nonatomic, strong, readonly) UILabel * stackLabel;

@property (nonatomic, strong, readonly) UIView * panel;

@property (nonatomic, weak, readwrite) id<WJStackCalculatorViewDelegate> delegate;

@property (nonatomic, assign, readwrite) BOOL panelVisible;
-(void)setPanelVisible:(BOOL)visible aniamted:(BOOL)aniamted;

@end