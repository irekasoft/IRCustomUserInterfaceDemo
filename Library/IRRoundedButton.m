//
//  IRRoundedButton.m
//  CalcDrill
//
//  Created by Hijazi on 8/4/15.
//  Copyright (c) 2015 iReka Soft. All rights reserved.
//

#import "IRRoundedButton.h"

@interface IRRoundedButton ()
@property (nonatomic) CGGradientRef gradient;
@end

@implementation IRRoundedButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    if (self.isGradient){
        
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGGradientRef gradient = [self gradient];
        CGPoint startPoint = CGPointMake(self.bounds.size.width/2, 0.0);
        CGPoint endPoint = CGPointMake(self.bounds.size.width/2, self.bounds.size.height);
        CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, 0);
        
    }
    
}

- (CGGradientRef)gradient{
    
    if (nil == _gradient) {
        
        
        
        const CGFloat *components = CGColorGetComponents(self.topColor.CGColor);
        CGFloat red = components[0];
        CGFloat green = components[1];
        CGFloat blue = components[2];
        CGFloat alpha = components[3];
        
        components = CGColorGetComponents(self.bottomColor.CGColor);
        CGFloat red2 = components[0];
        CGFloat green2 = components[1];
        CGFloat blue2 = components[2];
        CGFloat alpha2 = components[3];
        
        CGFloat colors[8] = {red,green,blue, 1.0f,
                             red2,green2,blue2, 1.0f};
        CGFloat locations[2] = {0.00f, 1.0f};
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        
        _gradient = CGGradientCreateWithColorComponents(colorSpace, colors, locations, 2);
        
        CGColorSpaceRelease(colorSpace);
        
    }
    return _gradient;
}



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
