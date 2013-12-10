//
//  SWUtilityButtonView.m
//  SWTableViewCell
//
//  Created by Matt Bowman on 11/27/13.
//  Copyright (c) 2013 Chris Wendel. All rights reserved.
//

#import "SWUtilityButtonView.h"
#import "SWUtilityButtonTapGestureRecognizer.h"
#import "Constants.h"

@implementation SWUtilityButtonView

#pragma mark - SWUtilityButonView initializers

- (id)initWithUtilityButtons:(NSArray *)utilityButtons parentCell:(SWTableViewCell *)parentCell utilityButtonSelector:(SEL)utilityButtonSelector
{
    self = [super init];
    
    if (self) {
        self.utilityButtons = utilityButtons;
        self.parentCell = parentCell;
        self.utilityButtonSelector = utilityButtonSelector;
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame utilityButtons:(NSArray *)utilityButtons parentCell:(SWTableViewCell *)parentCell utilityButtonSelector:(SEL)utilityButtonSelector
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.utilityButtons = utilityButtons;
        self.parentCell = parentCell;
        self.utilityButtonSelector = utilityButtonSelector;
    }
    
    return self;
}

#pragma mark -

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (NSUInteger utilityButtonsCounter = 0; utilityButtonsCounter < _utilityButtons.count; utilityButtonsCounter++)
    {
        UIButton *utilityButton = (UIButton *)_utilityButtons[utilityButtonsCounter];
        CGFloat utilityButtonXCord = 0;
        
        if (self.utilityButtonStyle == SWUtilityButtonStyleVertical) {
            CGFloat height = (CGRectGetHeight(self.bounds)/_utilityButtons.count);
            NSLog(@"height: %f",height);
            [utilityButton setFrame:CGRectMake(utilityButtonXCord, height * utilityButtonsCounter, [self utilityButtonsWidth], height)];
        } else {
            if (utilityButtonsCounter >= 1) utilityButtonXCord = self.utilityButtonWidth * utilityButtonsCounter;
            [utilityButton setFrame:CGRectMake(utilityButtonXCord, 0, self.utilityButtonWidth, CGRectGetHeight(self.bounds))];
        }
    }
}

#pragma mark Populating utility buttons

- (CGFloat)utilityButtonWidth
{
    CGFloat buttonWidth = kUtilityButtonWidthDefault;
    if (self.utilityButtonStyle == SWUtilityButtonStyleHorizontal) {
        if (buttonWidth * _utilityButtons.count > kUtilityButtonsWidthMax)
        {
            CGFloat buffer = (buttonWidth * _utilityButtons.count) - kUtilityButtonsWidthMax;
            buttonWidth -= (buffer / _utilityButtons.count);
        }
    }
    return buttonWidth;
}

- (CGFloat)utilityButtonsWidth
{
    if (self.utilityButtonStyle == SWUtilityButtonStyleVertical) {
        return kUtilityButtonWidthDefault;
    } else {
        return (_utilityButtons.count * self.utilityButtonWidth);
    }
}

- (void)populateUtilityButtons
{
    NSUInteger utilityButtonsCounter = 0;
    for (UIButton *utilityButton in _utilityButtons)
    {
        [utilityButton setTag:utilityButtonsCounter];
        SWUtilityButtonTapGestureRecognizer *utilityButtonTapGestureRecognizer = [[SWUtilityButtonTapGestureRecognizer alloc] initWithTarget:_parentCell
                                                                                                                                      action:_utilityButtonSelector];
        utilityButtonTapGestureRecognizer.buttonIndex = utilityButtonsCounter;
        [utilityButton addGestureRecognizer:utilityButtonTapGestureRecognizer];
        [self addSubview: utilityButton];
        utilityButtonsCounter++;
    }
}

@end

