//
//  IRRoundedButton.h
//  CalcDrill
//
//  Created by Hijazi on 8/4/15.
//  Copyright (c) 2015 iReka Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface IRRoundedButton : UIButton

@property (assign) IBInspectable BOOL isGradient;

@property (nonatomic) IBInspectable UIColor *topColor;
@property (nonatomic) IBInspectable UIColor *bottomColor;

@end
