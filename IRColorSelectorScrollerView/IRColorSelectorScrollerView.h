//
//  IRColorSelectorScrollerView.h
//  IRScrollerDemo
//
//  Created by Muhammad Hijazi  on 13/4/15.
//  Copyright (c) 2015 iReka Soft. All rights reserved.
//

#import <UIKit/UIKit.h>


#define EXTRA_SCALE 0.2
#define SQUARE_SIZE_RATIO 0.6

@protocol IRColorSelectorScrollerViewDelegate;

@interface IRColorSelectorScrollerView : UIScrollView <UIScrollViewDelegate>

@property (assign, nonatomic) id <IRColorSelectorScrollerViewDelegate> pickerDelegate;

@property (assign, nonatomic) NSInteger currentSelectedIndex;

@property (strong) NSArray *colorArray;

+ (NSArray *)colorArray;
+ (UIColor *)colorForIdx:(NSInteger)index;

@end

@protocol IRColorSelectorScrollerViewDelegate <NSObject>
@optional

- (void)picker:(IRColorSelectorScrollerView *)picker color:(UIColor*)color forIndex:(int)index;

@end

