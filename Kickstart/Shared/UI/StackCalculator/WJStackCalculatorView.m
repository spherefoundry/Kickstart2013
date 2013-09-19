//
//  WJStackCalculatorView.m
//  Kickstart
//
//  Created by Antoni Kedracki on 9/17/13.
//  Copyright (c) 2013 Warsjava. All rights reserved.
//


#import "WJStackCalculatorView.h"


@implementation WJStackCalculatorView {
    NSArray *_buttonPresets;
    NSMutableArray *_buttons;
    NSUInteger _buttonsCountX;
    NSUInteger _buttonsCountY;
}

@synthesize stackLabel = _stackLabel;
@synthesize inputLabel = _inputLabel;

NSString *const kStackCalculatorButtonCaptionKey = @"caption";
NSString *const kStackCalculatorButtonPosXKey = @"posX";
NSString *const kStackCalculatorButtonPosYKey = @"posY";

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _inputLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _inputLabel.backgroundColor = [UIColor greenColor];
        _inputLabel.font = [UIFont boldSystemFontOfSize:30];
        _inputLabel.textColor = [UIColor whiteColor];
        _inputLabel.textAlignment = NSTextAlignmentRight;
        _inputLabel.text = @"inputLabel";
        [self addSubview:_inputLabel];

        _stackLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _stackLabel.backgroundColor = [UIColor redColor];
        _stackLabel.font = [UIFont boldSystemFontOfSize:24];
        _stackLabel.textColor = [UIColor whiteColor];
        _stackLabel.textAlignment = NSTextAlignmentRight;
        _stackLabel.numberOfLines = 2;
        _stackLabel.text = @"stackX\nstackY";
        [self addSubview:_stackLabel];

        NSDictionary *(^buttonPreset)(NSString *, NSUInteger, NSUInteger) = ^NSDictionary *(NSString *caption, NSUInteger posX, NSUInteger posY) {
            return @{
                    kStackCalculatorButtonCaptionKey : caption,
                    kStackCalculatorButtonPosXKey : @(posX),
                    kStackCalculatorButtonPosYKey : @(posY)
            };
        };

        _buttonPresets = @[
                buttonPreset(@"7", 0, 0),
                buttonPreset(@"8", 1, 0),
                buttonPreset(@"9", 2, 0),
                buttonPreset(@"4", 0, 1),
                buttonPreset(@"5", 1, 1),
                buttonPreset(@"6", 2, 1),
                buttonPreset(@"1", 0, 2),
                buttonPreset(@"2", 1, 2),
                buttonPreset(@"3", 2, 2),
                buttonPreset(@"0", 0, 3),
                buttonPreset(@".", 1, 3),
                buttonPreset(@"C", 2, 3),
                buttonPreset(@"PUSH", 0, 4),
                buttonPreset(@"POP", 1, 4),
                buttonPreset(@"SWAP", 2, 4),
                buttonPreset(@"DUP", 3, 4),
                buttonPreset(@"+", 3, 0),
                buttonPreset(@"-", 3, 1),
                buttonPreset(@"*", 3, 2),
                buttonPreset(@"/", 3, 3)
        ];

        _buttons = [NSMutableArray array];
        for (NSDictionary *dictionary in _buttonPresets) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:dictionary[kStackCalculatorButtonCaptionKey] forState:UIControlStateNormal];
            button.showsTouchWhenHighlighted = YES;
            button.backgroundColor = [UIColor blueColor];

            if([dictionary[kStackCalculatorButtonPosXKey] unsignedIntegerValue] + 1 > _buttonsCountX){
                _buttonsCountX = [dictionary[kStackCalculatorButtonPosXKey] unsignedIntegerValue] + 1;
            }

            if([dictionary[kStackCalculatorButtonPosYKey] unsignedIntegerValue] + 1 > _buttonsCountY){
                _buttonsCountY = [dictionary[kStackCalculatorButtonPosYKey] unsignedIntegerValue] + 1;
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
    CGFloat top = padding;

    _inputLabel.frame = CGRectMake(padding, top, elementWidth, _inputLabel.font.lineHeight);
    top = CGRectGetMaxY(_inputLabel.frame) + padding;

    _stackLabel.frame = CGRectMake(padding, top, elementWidth, _stackLabel.font.lineHeight * _stackLabel.numberOfLines);
    top = CGRectGetMaxY(_stackLabel.frame);

    CGSize buttonSize = CGSizeMake((self.bounds.size.width - (_buttonsCountX+1)*padding) / _buttonsCountX,
            (self.bounds.size.height - top - (_buttonsCountY+1)*padding) / _buttonsCountY);

    for(NSUInteger i = 0; i < _buttons.count; ++i){
        UIButton * button = _buttons[i];
        NSDictionary * buttonPreset = _buttonPresets[i];

        button.frame = CGRectMake(padding + (buttonSize.width + padding) * [buttonPreset[kStackCalculatorButtonPosXKey] unsignedIntegerValue],
                top + padding + (buttonSize.height + padding) * [buttonPreset[kStackCalculatorButtonPosYKey] unsignedIntegerValue],
                buttonSize.width,
                buttonSize.height);
    }
}

@end