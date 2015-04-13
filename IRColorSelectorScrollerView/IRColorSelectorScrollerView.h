//
//  IRColorSelectorScrollerView.h
//  IRScrollerDemo
//
//  Created by Muhammad Hijazi  on 13/4/15.
//  Copyright (c) 2015 iReka Soft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IRColorButton.h"

@protocol IRColorSelectorScrollerViewDelegate;

@interface IRColorSelectorScrollerView : UIScrollView <UIScrollViewDelegate> {
    
    CGFloat scrollViewWidth;
    CGFloat scrollViewHeight;
    CGFloat cube_side;
    CGFloat xOffset;
    
    int numberOfSelection;
}

@property (assign, nonatomic) id <IRColorSelectorScrollerViewDelegate> pickerDelegate;

+ (NSArray *)colorArray;

@end

@protocol IRColorSelectorScrollerViewDelegate <NSObject>
@optional

- (void)picker:(IRColorSelectorScrollerView *)picker color:(UIColor*)color forIndex:(int)index;

@end