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

@class IRColorSelectorScrollerView;
@interface ViewController : UIViewController <IRPopoverViewDelegate, IRPickerViewDelegate, IRColorSelectorScrollerViewDelegate> {
    
    CGPoint point;
    
    // for picker
    int pickerIdx;
    
}

@property (weak, nonatomic) IBOutlet UIView *selectedColor;
@property (strong) IRPickerView *picker;

@property (weak, nonatomic) IBOutlet IRColorSelectorScrollerView *colorPicker;


@end

