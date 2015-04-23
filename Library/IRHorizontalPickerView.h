//
//  IRHorizontalScrollView.h
//  IRCustomUserInterfaceDemo
//
//  Created by Hijazi on 24/4/15.
//  Copyright (c) 2015 iReka Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

#define EXTRA_SCALE 0.2
#define SQUARE_SIZE_RATIO 0.6

@protocol IRHorizontalPickerViewDelegate;
@protocol IRHorizontalPickerViewDataSource;

@interface IRHorizontalPickerView : UIScrollView <UIScrollViewDelegate>

@property (assign, nonatomic) id <IRHorizontalPickerViewDelegate> pickerViewDelegate;
@property (assign, nonatomic) id <IRHorizontalPickerViewDataSource> pickerViewDataSource;

@property (assign, nonatomic) NSInteger currentSelectedIndex;

- (void)reloadData;

@end


@protocol IRHorizontalPickerViewDelegate <NSObject>
@optional

- (void)horizontalPicker:(IRHorizontalPickerView *)pickerView forIndex:(int)index;

@end

@protocol IRHorizontalPickerViewDataSource <NSObject>

- (NSInteger)numberOfItemsInPicker:(IRHorizontalPickerView *)pickerView;
- (NSString *)picker:(IRHorizontalPickerView *)pickerView stringForItem:(NSInteger)item;


@optional

- (UIView *)picker:(IRHorizontalPickerView *)pickerView contentView:(UIView *)contentView viewForItem:(NSInteger)item;

@end