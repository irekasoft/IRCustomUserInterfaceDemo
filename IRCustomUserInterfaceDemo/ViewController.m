//
//  ViewController.m
//  IRCustomUserInterfaceDemo
//
//  Created by Hijazi on 13/4/15.
//  Copyright (c) 2015 iReka Soft. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.colorPicker.pickerDelegate = self;
    self.colorPicker.currentSelectedIndex = 3;
    

    self.selectedColor.backgroundColor = [IRColorSelectorScrollerView colorForIdx:self.colorPicker.currentSelectedIndex];
   
    //
    self.horizontalPickerView.pickerViewDataSource = self;
    self.horizontalPickerView.pickerViewDelegate = self;
    
    
    self.viewArray = @[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]],
                       [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2"]],
                       [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]],
                       [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2"]],
                       [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]],
                       [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2"]],
                       [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]],
                       [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2"]],
                       [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]],
                       [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2"]],
                       [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]],
                       [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2"]],
                       [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]],
                       [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2"]]
                       ];
    
    [self.horizontalPickerView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Actions

- (IBAction)openPickerView:(id)sender {
    
    NSArray *array = @[@"hello",@"hello2"];
    
    self.picker = [[IRPickerView alloc] initWithOptions:array
                                 withSelectedIndex:pickerIdx];
    self.picker.delegate = self;
    self.picker.tag = 1;
    [self.picker show];

}

- (IBAction)openPopup:(UIButton *)sender {
    
    point = sender.center;
    
    [IRPopoverView showPopoverAtPoint:point
                                                   inView:self.view
                                                withTitle:@"Was this helpful?"
                                          withStringArray:@[@"YES", @"NO"]
                                                 delegate:self];
    
    // Show string array defined at top of this file with title.
}

#pragma mark - IRColorSelectorScrollerViewDelegate


- (void)picker:(IRColorSelectorScrollerView *)picker forIndex:(int)index{
    
    NSLog(@"idx %d",index);
    self.selectedColor.backgroundColor = [IRColorSelectorScrollerView colorForIdx:index];
    
}



#pragma mark - IRPopoverViewDelegate

- (void)popoverView:(IRPopoverView *)popoverView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"%s item:%d", __PRETTY_FUNCTION__, (int)index);
    
    
    // alternatively, you can use
    [popoverView showSuccess];
    // or
    // [popoverView showError];
    
    // Dismiss the PopoverView after 0.5 seconds
    [popoverView performSelector:@selector(dismiss) withObject:nil afterDelay:0.5f];
}

- (void)popoverViewDidDismiss:(IRPopoverView *)popoverView
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
}


#pragma mark - IRHorizontalPickerViewDataSource

- (NSInteger)numberOfItemsInPicker:(IRHorizontalPickerView *)pickerView{
    
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return [self.viewArray count];
}

- (NSString *)picker:(IRHorizontalPickerView *)pickerView stringForItem:(NSInteger)item{
    return [NSString stringWithFormat:@"%d",(int)item+1];
}

- (UIView *)picker:(IRHorizontalPickerView *)pickerView contentView:(UIView *)contentView viewForItem:(NSInteger)item{
    
    UIView *myView = [[UIView alloc] initWithFrame:contentView.bounds];
    
    myView.backgroundColor = [UIColor greenColor];
    
    return self.viewArray[item];
}

#pragma mark - IRHorizontalPickerViewDelegate


- (void)horizontalPicker:(IRHorizontalPickerView *)pickerView forIndex:(int)index{
    
    
}
    


@end
