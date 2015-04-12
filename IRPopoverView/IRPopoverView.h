//
//  IRPopoverView.h
//  IRCustomUserInterfaceDemo
//
//  Created by Hijazi on 13/4/15.
//  Copyright (c) 2015 iReka Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CFTYPECAST(exp) (exp)

@protocol IRPopoverViewDelegate;

@interface IRPopoverView : UIView {
    
    CGRect boxFrame;
    CGSize contentSize;
    CGPoint arrowPoint;
    
    BOOL above;
    
    UIView *parentView;
    
    UIView *topView;
    
    NSArray *dividerRects;
    
    
    UIActivityIndicatorView *activityIndicator;
    
    //Instance variable that can change at runtime
    BOOL showDividerRects;

}

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSArray *subviewsArray;

@property (nonatomic, weak) id<IRPopoverViewDelegate> delegate;
#pragma mark - Class Static Showing Methods

//These are the main static methods you can use to display the popover.
//Simply call [PopoverView show...] with your arguments, and the popover will be generated, added to the view stack, and notify you when it's done.

+ (IRPopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withText:(NSString *)text delegate:(id<IRPopoverViewDelegate>)delegate;

+ (IRPopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withText:(NSString *)text delegate:(id<IRPopoverViewDelegate>)delegate;

+ (IRPopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withViewArray:(NSArray *)viewArray delegate:(id<IRPopoverViewDelegate>)delegate;

+ (IRPopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withViewArray:(NSArray *)viewArray delegate:(id<IRPopoverViewDelegate>)delegate;

+ (IRPopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withStringArray:(NSArray *)stringArray delegate:(id<IRPopoverViewDelegate>)delegate;

+ (IRPopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withStringArray:(NSArray *)stringArray delegate:(id<IRPopoverViewDelegate>)delegate;

+ (IRPopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withStringArray:(NSArray *)stringArray withImageArray:(NSArray *)imageArray delegate:(id<IRPopoverViewDelegate>)delegate;

+ (IRPopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withStringArray:(NSArray *)stringArray withImageArray:(NSArray *)imageArray delegate:(id<IRPopoverViewDelegate>)delegate;

+ (IRPopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withContentView:(UIView *)cView delegate:(id<IRPopoverViewDelegate>)delegate;

+ (IRPopoverView *)showPopoverAtPoint:(CGPoint)point inView:(UIView *)view withContentView:(UIView *)cView delegate:(id<IRPopoverViewDelegate>)delegate;

#pragma mark - Instance Showing Methods

//Adds/animates in the popover to the top of the view stack with the arrow pointing at the "point"
//within the specified view.  The contentView will be added to the popover, and should have either
//a clear color backgroundColor, or perhaps a rounded corner bg rect (radius 4.f if you're going to
//round).
- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withContentView:(UIView *)contentView;

//Calls above method with a UILabel containing the text you deliver to this method.
- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withText:(NSString *)text;

//Calls top method with an array of UIView objects.  This method will stack these views vertically
//with kBoxPadding padding between each view in the y-direction.
- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withViewArray:(NSArray *)viewArray;

//Does same as above, but adds a title label at top of the popover.
- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withViewArray:(NSArray *)viewArray;

//Calls the viewArray method with an array of UILabels created with the strings
//in stringArray.  All contents of stringArray must be NSStrings.
- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withStringArray:(NSArray *)stringArray;

//This method does same as above, but with a title label at the top of the popover.
- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withStringArray:(NSArray *)stringArray;

//Draws a vertical list of the NSString elements of stringArray with UIImages
//from imageArray placed centered above them.
- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withStringArray:(NSArray *)stringArray withImageArray:(NSArray *)imageArray;

//Does the same as above, but with a title
- (void)showAtPoint:(CGPoint)point inView:(UIView *)view withTitle:(NSString *)title withStringArray:(NSArray *)stringArray withImageArray:(NSArray *)imageArray;

//Lays out the PopoverView at a point once all of the views have already been setup elsewhere
- (void)layoutAtPoint:(CGPoint)point inView:(UIView *)view;

#pragma mark - Other Interaction
//This method animates the rotation of the PopoverView to a new point
- (void)animateRotationToNewPoint:(CGPoint)point inView:(UIView *)view withDuration:(NSTimeInterval)duration;

#pragma mark - Dismissal
//Dismisses the view, and removes it from the view stack.
- (void)dismiss;
- (void)dismiss:(BOOL)animated;

#pragma mark - Activity Indicator Methods

//Shows the activity indicator, and changes the title (if the title is available, and is a UILabel).
- (void)showActivityIndicatorWithMessage:(NSString *)msg;

//Hides the activity indicator, and changes the title (if the title is available) to the msg
- (void)hideActivityIndicatorWithMessage:(NSString *)msg;

#pragma mark - Custom Image Showing

//Animate in, and display the image provided here.
- (void)showImage:(UIImage *)image withMessage:(NSString *)msg;

#pragma mark - Error/Success Methods

//Shows (and animates in) an error X in the contentView
- (void)showError;

//Shows (and animates in) a success checkmark in the contentView
- (void)showSuccess;

@end

@protocol IRPopoverViewDelegate <NSObject>

@optional

//Delegate receives this call as soon as the item has been selected
- (void)popoverView:(IRPopoverView *)popoverView didSelectItemAtIndex:(NSInteger)index;

//Delegate receives this call once the popover has begun the dismissal animation
- (void)popoverViewDidDismiss:(IRPopoverView *)popoverView;

@end

// BOX GEOMETRY

//Height/width of the actual arrow
#define kArrowHeight 12.f

//padding within the box for the contentView
#define kBoxPadding 10.f

//control point offset for rounding corners of the main popover box
#define kCPOffset 1.8f

//radius for the rounded corners of the main popover box
#define kBoxRadius 2.f

//Curvature value for the arrow.  Set to 0.f to make it linear.
#define kArrowCurvature 6.f

//Minimum distance from the side of the arrow to the beginning of curvature for the box
#define kArrowHorizontalPadding 5.f

//Alpha value for the shadow behind the PopoverView
#define kShadowAlpha 0.4f

//Blur for the shadow behind the PopoverView
#define kShadowBlur 3.f;

//Box gradient bg alpha
#define kBoxAlpha 0.95f

//Padding along top of screen to allow for any nav/status bars
#define kTopMargin 50.f

//margin along the left and right of the box
#define kHorizontalMargin 10.f

//padding along top of icons/images
#define kImageTopPadding 3.f

//padding along bottom of icons/images
#define kImageBottomPadding 3.f


// DIVIDERS BETWEEN VIEWS

//Bool that turns off/on the dividers
#define kShowDividersBetweenViews YES

//color for the divider fill
#define kDividerColor [UIColor colorWithRed:0.329 green:0.341 blue:0.353 alpha:0.15f]


// BACKGROUND GRADIENT

//bottom color white in gradient bg
#define kGradientBottomColor [UIColor colorWithRed:0.98f green:0.98f blue:0.98f alpha:kBoxAlpha]

//top color white value in gradient bg
#define kGradientTopColor [UIColor colorWithRed:1.f green:1.f blue:1.f alpha:kBoxAlpha]


// TITLE GRADIENT

//bool that turns off/on title gradient
#define kDrawTitleGradient NO

//bottom color white value in title gradient bg
#define kGradientTitleBottomColor [UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:kBoxAlpha]

//top color white value in title gradient bg
#define kGradientTitleTopColor [UIColor colorWithRed:1.f green:1.f blue:1.f alpha:kBoxAlpha]


// FONTS

//normal text font
#define kTextFont [UIFont fontWithName:@"HelveticaNeue" size:16.f]

//normal text color
#define kTextColor [UIColor colorWithRed:0.329 green:0.341 blue:0.353 alpha:1]
// highlighted text color
#define kTextHighlightColor [UIColor colorWithRed:0.098 green:0.102 blue:0.106 alpha:1.000]

//normal text alignment
#define kTextAlignment UITextAlignmentCenter

//title font
#define kTitleFont [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.f]

//title text color
#define kTitleColor [UIColor colorWithRed:0.329 green:0.341 blue:0.353 alpha:1]


// BORDER

//bool that turns off/on the border
#define kDrawBorder NO

//border color
#define kBorderColor [UIColor blackColor]

//border width
#define kBorderWidth 1.f
