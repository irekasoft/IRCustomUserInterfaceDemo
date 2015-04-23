//
//  ViewController.h
//  IRCustomUserInterfaceDemo
//
//  Created by Hijazi on 13/4/15.
//  Copyright (c) 2015 iReka Soft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IRPopoverView.h"
#import "IRPickerView.h"
#import "IRColorSelectorScrollerView.h"
#import "IRHorizontalPickerView.h"

@class IRColorSelectorScrollerView;
@interface ViewController : UIViewController <IRPopoverViewDelegate, IRPickerViewDelegate, IRColorSelectorScrollerViewDelegate, IRHorizontalPickerViewDataSource, IRHorizontalPickerViewDelegate> {
    
    CGPoint point;
    
    // for picker
    int pickerIdx;
    
}

// Example for IRHorizontalPickerView

@property (weak, nonatomic) IBOutlet IRHorizontalPickerView *horizontalPickerView;
@property (strong, nonatomic) NSArray *viewArray;

// Example for IRPickerView

@property (strong) IRPickerView *picker;

// Example for IRColorSelectorScrollerView

@property (weak, nonatomic) IBOutlet UIView *selectedColor;
@property (weak, nonatomic) IBOutlet IRColorSelectorScrollerView *colorPicker;


@end

