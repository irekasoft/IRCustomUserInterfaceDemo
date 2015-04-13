//
//  IRPickerView
//  Created by Muhammad Hijazi on 14/03/12.

#import "IRPickerView.h"

@implementation IRPickerView

static float durationAnimation = 0.3f;

- (id)initWithOptions:(NSArray *)array withSelectedIndex:(int)index{
    
    if (self = [super init]) {
        self.optionsArray = [NSMutableArray arrayWithArray:array];
        self.selectedPicker = index;

	}
	return self;
}

- (void)show{
    
    windowBounds = [[UIScreen mainScreen] bounds];
    
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.delegate   = self;
    self.pickerView.dataSource = self;
    self.pickerView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    self.pickerView.showsSelectionIndicator=YES;
    [self.pickerView selectRow:self.selectedPicker inComponent:0 animated:NO];
    [self.view addSubview:self.pickerView];

    [self createToolbar];
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.view];
    
    
    /** Animation */

    CGFloat winHeight = [[UIScreen mainScreen] bounds].size.height;
    
    self.pickerView.frame = CGRectMake(0, winHeight, windowBounds.size.width, 216.0);
	
	//animate picker view
	self.pickerView.hidden  = NO;
    self.toolBar.hidden     = NO;
    
	[UIView animateWithDuration:durationAnimation animations:^(void){

		CGAffineTransform transform = CGAffineTransformMakeTranslation(0, -216);
		self.pickerView.transform = transform;
        self.toolBar.transform= CGAffineTransformMakeTranslation(0, -216-50);
        
	}completion:^(BOOL finished){
        
	}];
    
	//animate overlaybutton

	overlayButton.hidden = NO;
    [UIView animateWithDuration:durationAnimation animations:^(void){
		overlayButton.alpha = 0.5;
        
	} completion:^(BOOL finished){
        
	}];
    
    [super becomeFirstResponder];
	

}

- (void) createToolbar {

	
	

	self.pickerView.frame =CGRectMake(0, windowBounds.size.height,
                                      windowBounds.size.width, 216);


    overlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    overlayButton.backgroundColor = [UIColor blackColor];
    overlayButton.frame = windowBounds;
    [overlayButton addTarget:self action:@selector(pickerDoneClicked:) forControlEvents:UIControlEventTouchUpInside];
    overlayButton.alpha     =0.0;
    overlayButton.hidden    =YES;

    
    [self.view addSubview:overlayButton];
    
    self.toolBar = [[UIToolbar alloc] init];
    self.toolBar.tintColor = [UIColor colorWithRed:0.0f green:0.49f blue:0.96f alpha:1.0f];
    self.toolBar.translucent = YES;
   
    self.toolBar.hidden=YES;
    [self.toolBar sizeToFit];
    
    CGRect rect = self.pickerView.frame;
    rect.size.height = 50;
    self.toolBar.frame = rect;
    
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(pickerDoneClicked:)] ;
    
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    [self.toolBar setItems:[NSArray arrayWithObjects:flexibleSpace,doneButton, nil]];

    [self.view addSubview:self.toolBar];
    [self.view bringSubviewToFront:self.pickerView];


}

- (void)pickerDoneClicked:(UIBarButtonItem*) sender{
    
    // excecption
    if ([self.optionsArray count] == 0) {
        return;
    }
    
    if([self.delegate respondsToSelector:@selector(picker:DoneClicked:forIndex:)]){
        
        int index = (int)[self.pickerView selectedRowInComponent:0];
        
        [self.delegate picker:self DoneClicked:self.optionsArray[index] forIndex:index];
        

    }
    [self hide];
}

- (void)hide {

	[UIView animateWithDuration:durationAnimation animations:^(void){

	self.pickerView.transform = CGAffineTransformMakeTranslation(0, 264);
    self.toolBar.transform=  CGAffineTransformMakeTranslation(0, 264+50);
        
	}completion:^(BOOL finished){
		[self.view removeFromSuperview];
	}];
	
	//animate overlaybutton
	[UIView animateWithDuration:durationAnimation animations:^(void){
		overlayButton.alpha = 0.0;
	}completion:^(BOOL finished){
		overlayButton.hidden=YES;
        
	}];
    
    
	
}

#pragma mark - self.pickerView delegate methods

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
}


- (CGFloat)pickerView:(UIPickerView *)pickerViews rowHeightForComponent:(NSInteger)component {
	return 50;
}


#pragma mark data source

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *retval = (id)view;
    
    if (!retval) {
        retval= [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f,
                                                          [pickerView rowSizeForComponent:component].width-10,
                                                          [pickerView rowSizeForComponent:component].height)];
        retval.textAlignment = NSTextAlignmentCenter;
    }
    
    retval.text = [self.optionsArray objectAtIndex:row];
    retval.font = [UIFont systemFontOfSize:22];
    retval.adjustsFontSizeToFitWidth = YES;
    retval.minimumScaleFactor = 0.1f;
    return retval;
}

//- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//	return [self.optionsArray objectAtIndex:row];
//}
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *str = [self.optionsArray objectAtIndex:row];
    NSDictionary *att = @{NSFontAttributeName: [UIFont fontWithName:@"Arial" size:4],NSForegroundColorAttributeName:[[UIColor blackColor] colorWithAlphaComponent:0.9]};
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:str attributes:att];
    
    return attString;
    
}



// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return [self.optionsArray count];
    
}



@end