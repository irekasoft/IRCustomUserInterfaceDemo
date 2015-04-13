//
//  IRPickerView
//  Created by Muhammad Hijazi on 14/03/12.

#import <UIKit/UIKit.h>

@protocol IRPickerViewDelegate;

@interface IRPickerView : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>{

	UIButton *overlayButton;
    CGRect windowBounds;
}


- (void)show;

// init & show the picker with array of selection with preselected row
// for example using button title.
- (id)initWithOptions:(NSArray *)array withSelectedIndex:(int)index;

@property (assign, nonatomic) NSInteger tag;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) UIToolbar* toolBar;
@property (assign, nonatomic) id <IRPickerViewDelegate> delegate;
@property (strong, nonatomic) NSArray *optionsArray;

@property int selectedPicker;

@end


@protocol IRPickerViewDelegate <NSObject>

@optional

- (void)picker:(IRPickerView *)picker clicked:(NSString *)name forIndex:(int)index;

@end