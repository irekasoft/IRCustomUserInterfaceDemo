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
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)openPopup:(UIButton *)sender {
    
    point = sender.center;
    
    IRPopoverView *pv = [IRPopoverView showPopoverAtPoint:point
                                  inView:self.view
                               withTitle:@"Was this helpful?"
                                          withStringArray:@[@"YES", @"NO"]
                                delegate:self]; // Show string array defined at top of this file with title.
}


#pragma mark - PopoverViewDelegate Methods

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


@end
