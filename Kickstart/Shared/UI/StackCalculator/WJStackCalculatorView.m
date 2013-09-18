//
//  WJStackCalculatorView.m
//  Kickstart
//
//  Created by Antoni Kedracki on 9/17/13.
//  Copyright (c) 2013 Warsjava. All rights reserved.
//


#import "WJStackCalculatorView.h"


@implementation WJStackCalculatorView {

}

@synthesize stackLabel = _stackLabel;
@synthesize inputLabel = _inputLabel;

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
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    const CGFloat padding = 10;

    CGFloat elementWidth = self.bounds.size.width - 2*padding;
    CGFloat top = padding;

    _inputLabel.frame = CGRectMake(padding, top, elementWidth, _inputLabel.font.lineHeight);
    top = CGRectGetMaxY(_inputLabel.frame) + padding;

    _stackLabel.frame = CGRectMake(padding, top, elementWidth, _stackLabel.font.lineHeight * _stackLabel.numberOfLines);
}


@end