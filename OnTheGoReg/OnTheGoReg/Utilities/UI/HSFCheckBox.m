//
//  HSFCheckBox.m
//  OnTheGoReg
//
//  Created by James T Romo on 7/19/13.
//  Copyright (c) 2013 Hispanic Scholarship Fund. All rights reserved.
//

#import "HSFCheckBox.h"

@implementation HSFCheckBox

- (void)commonInit
{
    _isChecked = NO;
    [self updateButtonView];
    
    [self addTarget:self
                 action:@selector(toggle)
       forControlEvents:UIControlEventTouchUpInside];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)toggle
{
    _isChecked = !_isChecked;
    [self updateButtonView];
}

- (void)updateButtonView
{
    if (_isChecked) {
        [self setBackgroundImage: [UIImage imageNamed:kCheckedState_Image]
                        forState: UIControlStateNormal];
    } else {
        [self setBackgroundImage:[UIImage imageNamed:kUncheckedState_Image]
                        forState: UIControlStateNormal];
    }
}


@end
