//
//  IRColorSelectorScrollerView.m
//  IRScrollerDemo
//
//  Created by Muhammad Hijazi  on 13/4/15.
//  Copyright (c) 2015 iReka Soft. All rights reserved.
//

#import "IRColorSelectorScrollerView.h"

#define HEX_COLOR(hexValue, alphaValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue]


@interface IRColorSelectorScrollerView () <UIScrollViewDelegate> {
    
    CGFloat scrollViewWidth;
    CGFloat scrollViewHeight;
    CGFloat square_side;
    CGFloat xOffset;
    
    int numberOfSelection;
    
}

@end

@implementation IRColorSelectorScrollerView

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

- (void)selecting:(UIButton *)sender{

    [self setContentOffset:CGPointMake((int)sender.tag*square_side, 0) animated:YES];
}

- (void)setup{
    self.backgroundColor = [UIColor clearColor];

    self.showsHorizontalScrollIndicator = NO;
    self.delegate = self;

    scrollViewWidth  = self.frame.size.width;
    scrollViewHeight = self.frame.size.height;

    square_side = scrollViewHeight*SQUARE_SIZE_RATIO;
    
    xOffset = (scrollViewWidth-square_side)/2;
    
    NSArray *colorArray;
    if (self.colorArray) {
        colorArray = self.colorArray;
    }else{
        colorArray = [IRColorSelectorScrollerView colorArray];
    }

    numberOfSelection = (int)[colorArray count];
    for (int i = 0; i < numberOfSelection; i++) {
        UIButton *view = [[UIButton alloc] initWithFrame:CGRectMake(xOffset + i*square_side, (scrollViewHeight - square_side)/2, square_side, square_side)];
        view.backgroundColor = HEX_COLOR([colorArray[i] integerValue], 1.0);
        [view addTarget:self action:@selector(selecting:) forControlEvents:UIControlEventTouchUpInside];
        view.tag = i;
        [self addSubview:view];
        
    }
    
    self.contentSize = CGSizeMake(xOffset*2 + square_side * numberOfSelection , scrollViewHeight);

}

// called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    

    CGFloat x = targetContentOffset->x;
    x = roundf(x / square_side) * square_side;
    targetContentOffset->x = x;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat closestX = 0;
    
    UIButton *centerView;
    CGFloat centerFloat = 0;

    // + 1 untuk trick pilih ke-dua
    CGFloat offsetX = self.contentOffset.x + 1 ;
    CGFloat original_offsetX = self.contentOffset.x;
    
    // issue bila tengah-tengah 2 different akan jadi sama, dan tak tahu
    // mana nak pilih.
    // perlu sikit offset.
    for (UIView *view in self.subviews) {

        if ([view isKindOfClass:[UIButton class]]) {
            
            view.transform = CGAffineTransformIdentity;
            
            CGFloat viewX = view.frame.origin.x-xOffset;
            CGFloat different = fabs(offsetX - viewX);

            
            if (closestX > different || closestX == 0) {
                closestX = different; // bookeeping
                
                centerFloat = fabs(original_offsetX - viewX);
                
                if (original_offsetX < -square_side/2 || original_offsetX > numberOfSelection*square_side-square_side/2) {
                    centerView = nil;
                }else{
                    centerView = (UIButton *)view;
                }

                
            }
        }
        
    }

    [self bringSubviewToFront:centerView];
    
    float normalize = 1 - centerFloat / (square_side/2);
    normalize = fabs(normalize);

    CGFloat extraScale = EXTRA_SCALE * normalize;
    centerView.transform = CGAffineTransformMakeScale(1.0+extraScale, 1.0+extraScale);

}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self sendCallback];
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self sendCallback];
}

- (void)sendCallback{
    
    int idx = (self.contentOffset.x)/(square_side - 1);

    if ([self.pickerDelegate respondsToSelector:@selector(picker:color:forIndex:)]) {
        
        NSInteger colorInteger = [[IRColorSelectorScrollerView colorArray][idx] integerValue];
        UIColor *color = HEX_COLOR(colorInteger, 1);
        [self.pickerDelegate picker:self color:color forIndex:idx];
        
    }
}

- (NSInteger)currentSelectedIndex{
    return (self.contentOffset.x)/(square_side - 1);
}

- (void)setCurrentSelectedIndex:(NSInteger)currentSelectedIndex{
    [self setContentOffset:CGPointMake(currentSelectedIndex*square_side, 0) animated:NO];
}

#pragma mark - Class Method

+ (NSArray *)colorArray{
    
    NSArray *array;
    
    array = @[@(0xD0041B),
              @(0xFF560E),
              @(0xFF8B28),
              @(0xFFAB32),
              @(0xFFBB33),
              
              @(0xFFD503),
              @(0xABD87D),
              @(0x91CA5B),
              @(0x60CEAB),
              @(0x6BD8C4),
              
              @(0x4AC9E8),
              @(0x41AEF1),
              @(0x3C95FD),
              @(0x7676F3),
              @(0x856CE8),
              
              @(0xAB64E2),
              @(0xDC62E1),
              @(0xE34EB8),
              @(0xD74081),
              @(0xF62453),
              
              
              ];
    
    
    return array;
}

+ (UIColor *)colorForIdx:(NSInteger)index{
    NSInteger colorNo = [[IRColorSelectorScrollerView colorArray][index] integerValue];
    return HEX_COLOR(colorNo, 1);
}

@end
