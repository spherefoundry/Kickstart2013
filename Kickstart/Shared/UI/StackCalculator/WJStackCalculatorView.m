//
//  WJStackCalculatorView.m
//  Kickstart
//
//  Created by Antoni Kedracki on 9/17/13.
//  Copyright (c) 2013 Warsjava. All rights reserved.
//


#import "WJStackCalculatorView.h"


@implementation WJStackCalculatorView {
    UIImageView *_labelFrame;

    NSArray *_buttonPresets;
    NSMutableArray *_buttons;
    NSUInteger _buttonsCountX;
    NSUInteger _buttonsCountY;
}

@synthesize stackLabel = _stackLabel;
@synthesize inputLabel = _inputLabel;
@synthesize delegate = _delegate;

NSString *const kStackCalculatorButtonIdKey = @"buttonId";
NSString *const kStackCalculatorButtonCaptionKey = @"caption";
NSString *const kStackCalculatorButtonPosXKey = @"posX";
NSString *const kStackCalculatorButtonPosYKey = @"posY";

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];

        UIImage *buttonImage = [[[UIImage imageNamed:@"calculator_button"] resizableImageWithCapInsets:UIEdgeInsetsMake(14, 14, 14, 14) resizingMode:UIImageResizingModeStretch] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImage *buttonImageFlip = [[[UIImage imageNamed:@"calculator_button_flip"] resizableImageWithCapInsets:UIEdgeInsetsMake(14, 14, 14, 14) resizingMode:UIImageResizingModeStretch] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

        _labelFrame = [[UIImageView alloc] initWithImage:buttonImage];
        _labelFrame.tintColor = [UIColor redColor];
        [self addSubview:_labelFrame];

        _inputLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _inputLabel.backgroundColor = [UIColor clearColor];
        _inputLabel.font = [UIFont boldSystemFontOfSize:30];
        _inputLabel.textColor = [UIColor whiteColor];
        _inputLabel.textAlignment = NSTextAlignmentRight;
        _inputLabel.text = @"inputLabel";
        [self addSubview:_inputLabel];

        _stackLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _stackLabel.backgroundColor = [UIColor clearColor];
        _stackLabel.font = [UIFont boldSystemFontOfSize:24];
        _stackLabel.textColor = [UIColor grayColor];
        _stackLabel.textAlignment = NSTextAlignmentRight;
        _stackLabel.numberOfLines = 2;
        _stackLabel.text = @"stackX\nstackY";
        [self addSubview:_stackLabel];

        NSDictionary *(^buttonPreset)(WJStackCalculatorViewButtonId, NSString *, NSUInteger, NSUInteger) = ^NSDictionary *(WJStackCalculatorViewButtonId buttonId, NSString *caption, NSUInteger posX, NSUInteger posY) {
            return @{
                    kStackCalculatorButtonIdKey : @(buttonId),
                    kStackCalculatorButtonCaptionKey : caption,
                    kStackCalculatorButtonPosXKey : @(posX),
                    kStackCalculatorButtonPosYKey : @(posY)
            };
        };

        _buttonPresets = @[
                buttonPreset(WJStackCalculatorViewButtonIdNumber7, @"7", 0, 0),
                buttonPreset(WJStackCalculatorViewButtonIdNumber8, @"8", 1, 0),
                buttonPreset(WJStackCalculatorViewButtonIdNumber9, @"9", 2, 0),
                buttonPreset(WJStackCalculatorViewButtonIdNumber4, @"4", 0, 1),
                buttonPreset(WJStackCalculatorViewButtonIdNumber5, @"5", 1, 1),
                buttonPreset(WJStackCalculatorViewButtonIdNumber6, @"6", 2, 1),
                buttonPreset(WJStackCalculatorViewButtonIdNumber1, @"1", 0, 2),
                buttonPreset(WJStackCalculatorViewButtonIdNumber2, @"2", 1, 2),
                buttonPreset(WJStackCalculatorViewButtonIdNumber3, @"3", 2, 2),
                buttonPreset(WJStackCalculatorViewButtonIdNumber0, @"0", 0, 3),
                buttonPreset(WJStackCalculatorViewButtonIdNumberDot, @".", 1, 3),
                buttonPreset(WJStackCalculatorViewButtonIdClear, @"C", 2, 3),
                buttonPreset(WJStackCalculatorViewButtonIdPush, @"PUSH", 0, 4),
                buttonPreset(WJStackCalculatorViewButtonIdPop, @"POP", 1, 4),
                buttonPreset(WJStackCalculatorViewButtonIdSwap, @"SWAP", 2, 4),
                buttonPreset(WJStackCalculatorViewButtonIdDup, @"DUP", 3, 4),
                buttonPreset(WJStackCalculatorViewButtonIdAdd, @"+", 3, 0),
                buttonPreset(WJStackCalculatorViewButtonIdSubstract, @"-", 3, 1),
                buttonPreset(WJStackCalculatorViewButtonIdMultiply, @"*", 3, 2),
                buttonPreset(WJStackCalculatorViewButtonIdDivide, @"/", 3, 3)
        ];

        _buttons = [NSMutableArray array];
        for (NSDictionary *dictionary in _buttonPresets) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];

            NSUInteger posX = [dictionary[kStackCalculatorButtonPosXKey] unsignedIntegerValue];
            NSUInteger posY = [dictionary[kStackCalculatorButtonPosYKey] unsignedIntegerValue];

            button.titleLabel.font = [UIFont boldSystemFontOfSize:24];
            button.titleLabel.adjustsFontSizeToFitWidth = YES;
            button.tintColor = [UIColor redColor];
            button.titleEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);

            [button setTitle:dictionary[kStackCalculatorButtonCaptionKey] forState:UIControlStateNormal];
            [button setBackgroundImage:(posX+posY)%2 == 1 ? buttonImage : buttonImageFlip forState:UIControlStateNormal];

            [button addTarget:self action:@selector(buttonWasPressed:) forControlEvents:UIControlEventTouchUpInside];

            if (posX + 1 > _buttonsCountX) {
                _buttonsCountX = posX + 1;
            }


            if (posY + 1 > _buttonsCountY) {
                _buttonsCountY = posY + 1;
            }

            [_buttons addObject:button];
            [self addSubview:button];
        }
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    const CGFloat padding = 10;

    CGFloat elementWidth = self.bounds.size.width - 2 * padding;

    _labelFrame.frame = CGRectMake(padding, padding, elementWidth, _inputLabel.font.lineHeight + _stackLabel.font.lineHeight * _stackLabel.numberOfLines + 2 * padding);

    CGFloat top = padding * 1.5f;

    _inputLabel.frame = CGRectMake(padding * 2, top, elementWidth - padding * 2, _inputLabel.font.lineHeight);
    top = CGRectGetMaxY(_inputLabel.frame) + padding;

    _stackLabel.frame = CGRectMake(padding * 2, top, elementWidth - padding * 2, _stackLabel.font.lineHeight * _stackLabel.numberOfLines);
    top = CGRectGetMaxY(_stackLabel.frame) + padding * 0.5f;

    CGSize buttonSize = CGSizeMake((self.bounds.size.width - (_buttonsCountX + 1) * padding) / _buttonsCountX,
            (self.bounds.size.height - top - (_buttonsCountY + 1) * padding) / _buttonsCountY);

    for (NSUInteger i = 0; i < _buttons.count; ++i) {
        UIButton *button = _buttons[i];
        NSDictionary *buttonPreset = _buttonPresets[i];

        button.frame = CGRectMake(padding + (buttonSize.width + padding) * [buttonPreset[kStackCalculatorButtonPosXKey] unsignedIntegerValue],
                top + padding + (buttonSize.height + padding) * [buttonPreset[kStackCalculatorButtonPosYKey] unsignedIntegerValue],
                buttonSize.width,
                buttonSize.height);
    }
}

- (void)buttonWasPressed:(UIButton *)button {
    NSUInteger i = [_buttons indexOfObject:button];
    WJStackCalculatorViewButtonId buttonId = (WJStackCalculatorViewButtonId)[_buttonPresets[i][kStackCalculatorButtonIdKey] unsignedIntegerValue];
    [_delegate calculatorView:self buttonWasPressed:buttonId];
}

@end