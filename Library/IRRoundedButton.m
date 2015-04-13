//
//  IRRoundedButton.m
//  CalcDrill
//
//  Created by Hijazi on 8/4/15.
//  Copyright (c) 2015 iReka Soft. All rights reserved.
//

#import "IRRoundedButton.h"

@implementation IRRoundedButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame {
    if((self = [super initWithFrame:frame])) {
        
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void)setup{
 
    self.layer.cornerRadius = self.frame.size.height/8;
    self.clipsToBounds = YES;
}

@end
