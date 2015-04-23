//
//  IRHorizontalScrollView.m
//  IRCustomUserInterfaceDemo
//
//  Created by Hijazi on 24/4/15.
//  Copyright (c) 2015 iReka Soft. All rights reserved.
//

#import "IRHorizontalPickerView.h"

#define HEX_COLOR(hexValue, alphaValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue]

@interface IRHorizontalPickerView () <UIScrollViewDelegate> {
    
    CGFloat scrollViewWidth;
    CGFloat scrollViewHeight;
    CGFloat square_side;
    CGFloat xOffset;
    
    NSInteger numberOfSelection;
    
}

@end

@implementation IRHorizontalPickerView

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
    
    [self reloadData];
    
}

#pragma mark - reload data

- (void)reloadData{
    
    scrollViewWidth  = self.frame.size.width;
    scrollViewHeight = self.frame.size.height;
    
    square_side = scrollViewHeight*SQUARE_SIZE_RATIO;
    xOffset = (scrollViewWidth-square_side)/2;
    
    numberOfSelection = [self.pickerViewDataSource numberOfItemsInPicker:self];
    
    for (int i = 0; i < numberOfSelection; i++) {
        UIButton *view = [[UIButton alloc] initWithFrame:CGRectMake(xOffset + i*square_side, (scrollViewHeight - square_side)/2, square_side, square_side)];
        
        // when the controller apply this data source
        // we use the supplied view
        if ([self.pickerViewDataSource respondsToSelector:@selector(picker:contentView:viewForItem:)]) {
            
            UIView *addOnView = [self.pickerViewDataSource picker:self contentView:view viewForItem:i];
            
            [view addSubview:addOnView];
            
            
        }else{
            view.backgroundColor = [UIColor lightGrayColor];
            UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
            label.textAlignment = NSTextAlignmentCenter;
            
            NSString *string = [self.pickerViewDataSource picker:self stringForItem:i];
            
            label.text = string;
            label.backgroundColor = [UIColor clearColor];
            [view addSubview:label];
            
            
            
            
        }
        
        [view addTarget:self action:@selector(selecting:) forControlEvents:UIControlEventTouchUpInside];
        
        
        view.tag = i;
        [self addSubview:view];
        
    }
    
    self.contentSize = CGSizeMake(xOffset*2 + square_side * numberOfSelection , scrollViewHeight);
}

// called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    CGFloat x = targetContentOffset->x;
    x = roundf( x / square_side) * square_side;
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
 
    for (UIView *view in self.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            
            view.transform = CGAffineTransformIdentity;
            
            CGFloat viewX = view.frame.origin.x-xOffset;
            CGFloat different = fabs(offsetX - viewX);
            
            [view.layer setShadowOffset:CGSizeZero];
            [view.layer setShadowColor:nil];
            [view.layer setShadowOpacity:0];
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
    
    centerView.clipsToBounds = NO;
    [self sendCallback];
  
    
    [centerView.layer setShadowOffset:CGSizeMake(0, 1)];
    [centerView.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [centerView.layer setShadowRadius:2.0];
    [centerView.layer setShadowOpacity:0.4];
    
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
    if (idx < 0) {
        idx = 0;
    }else if (idx >= numberOfSelection -1){
        idx = (int)numberOfSelection-1;
    }
    
    if ([self.pickerViewDelegate respondsToSelector:@selector(horizontalPicker:forIndex:)]) {
        
        [self.pickerViewDelegate horizontalPicker:self forIndex:idx];
        
    }
}

- (NSInteger)currentSelectedIndex{
    return (self.contentOffset.x)/(square_side - 1);
}

- (void)setCurrentSelectedIndex:(NSInteger)currentSelectedIndex{
    [self setContentOffset:CGPointMake(currentSelectedIndex*square_side, 0) animated:NO];
}



@end
