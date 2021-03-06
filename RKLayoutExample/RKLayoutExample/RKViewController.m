//
//  RKViewController.m
//  RKLayoutExample
//
//  Created by Robert Kovačević on 12/18/11.
//  Copyright (c) 2011 Robert Kovačević. All rights reserved.
//

#import "RKViewController.h"
#import "RKLayout.h"

@interface RKViewController ()

- (void)layoutViews;

@end

@implementation RKViewController

#pragma mark - View lifecycle

- (void)loadView
{
    [super loadView];
    
    NSArray *layoutModes = [NSArray arrayWithObjects: @"Horizontal", @"Vertical", @"Grid", nil];
    NSArray *spacingModes = [NSArray arrayWithObjects: @"Fixed spacing", @"Auto spacing", nil];
    NSArray *horizontalAlignModes = [NSArray arrayWithObjects: @"Left", @"Center", @"Right", nil];
    NSArray *verticalAlignModes = [NSArray arrayWithObjects: @"Top", @"Center", @"Bottom", nil];
    
    _mainLayout = [[RKLayout alloc] initWithFrame:self.view.bounds withMode:RKLayoutModeVertical];
    _mainLayout.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _mainLayout.horizontalAlign = RKLayoutHorizontalAlignCenter;
    _mainLayout.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_mainLayout];
    
    _controlsLayout = [[RKLayout alloc] initWithFrame:RKOriginRectMake(300.0f, 155.0f) withMode:RKLayoutModeVertical withSpacing:5.0f];
    [_mainLayout addSubview:_controlsLayout];

    _horizontalAlignModeSegmentedControl = [[UISegmentedControl alloc] initWithItems:horizontalAlignModes];
    _horizontalAlignModeSegmentedControl.frame = RKOriginRectMake(300, 25);
    _horizontalAlignModeSegmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
    _horizontalAlignModeSegmentedControl.selectedSegmentIndex = 1;
    [_horizontalAlignModeSegmentedControl addTarget:self action:@selector(horizontalAlignModeSelected:) forControlEvents:UIControlEventValueChanged];
    
    [_controlsLayout addSubview:_horizontalAlignModeSegmentedControl];

    _verticalAlignModeSegmentedControl = [[UISegmentedControl alloc] initWithItems:verticalAlignModes];
    _verticalAlignModeSegmentedControl.frame = RKOriginRectMake(300, 25);
    _verticalAlignModeSegmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
    _verticalAlignModeSegmentedControl.selectedSegmentIndex = 1;
    [_verticalAlignModeSegmentedControl addTarget:self action:@selector(verticalAlignModeSelected:) forControlEvents:UIControlEventValueChanged];
    
    [_controlsLayout addSubview:_verticalAlignModeSegmentedControl];
    
    _layoutModeSegmentedControl = [[UISegmentedControl alloc] initWithItems:layoutModes];
    _layoutModeSegmentedControl.frame = RKOriginRectMake(300, 25);
    _layoutModeSegmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
    _layoutModeSegmentedControl.selectedSegmentIndex = 0;
    [_layoutModeSegmentedControl addTarget:self action:@selector(layoutModeSelected:) forControlEvents:UIControlEventValueChanged];
    
    [_controlsLayout addSubview:_layoutModeSegmentedControl];
    
    UISegmentedControl* spacingSegmentedControl = [[UISegmentedControl alloc] initWithItems:spacingModes];
    spacingSegmentedControl.frame = RKOriginRectMake(300, 25);
    spacingSegmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
    spacingSegmentedControl.selectedSegmentIndex = 0;
    [spacingSegmentedControl addTarget:self action:@selector(spacingModeSelected:) forControlEvents:UIControlEventValueChanged];
    
    [_controlsLayout addSubview:spacingSegmentedControl];
	
    RKLayout* buttonsLayout = [[RKLayout alloc] initWithFrame:RKOriginRectMake(300, 25) withMode:RKLayoutModeHorizontal withSpacing:5.0f];
    buttonsLayout.horizontalAlign = RKLayoutHorizontalAlignCenter;
    [_controlsLayout addSubview:buttonsLayout];
    
    _addSubviewButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _addSubviewButton.frame = RKOriginRectMake(120, 25);
    [_addSubviewButton setTitle:@"Add subview" forState:UIControlStateNormal];
    [_addSubviewButton addTarget:self action:@selector(addSubviewButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [buttonsLayout addSubview:_addSubviewButton];
    
    _removeSubviewButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _removeSubviewButton.frame = RKOriginRectMake(140, 25);
    [_removeSubviewButton setTitle:@"Remove subview" forState:UIControlStateNormal];
    [_removeSubviewButton addTarget:self action:@selector(removeSubviewButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [buttonsLayout addSubview:_removeSubviewButton];
    
    _layoutDemoView = [[RKLayout alloc] initWithFrame:CGRectZero withMode:RKLayoutModeHorizontal withSpacing:10.0f];
    _layoutDemoView.horizontalAlign = RKLayoutHorizontalAlignCenter;
    _layoutDemoView.verticalAlign = RKLayoutVerticalAlignCenter;
    _layoutDemoView.spacingMode = RKLayoutSpacingModeFixed;
    _layoutDemoView.backgroundColor = [UIColor yellowColor];
    
    for (int i = 0; i < 10; i++)
    {
        UIView* test = [[UIView alloc] initWithFrame:CGRectMake(0, 0, RANDOM_FLOAT(10, 100), RANDOM_FLOAT(10, 100))];
        test.backgroundColor = [UIColor redColor];
        [_layoutDemoView addSubview:test];
    }
    
    [_mainLayout addSubview:_layoutDemoView];
    
    [self layoutViews];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
 
    [self layoutViews];
}

#pragma mark - Private

- (void)layoutViews
{
    _layoutDemoView.frame = RKOriginRectMake(self.view.bounds.size.width, self.view.bounds.size.height - _controlsLayout.frame.size.height);
    
    [self.view setNeedsLayout];
}

- (void)addSubviewButtonTapped
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    UIView* test = [[UIView alloc] initWithFrame:CGRectMake(0, 0, RANDOM_FLOAT(10, 100), RANDOM_FLOAT(10, 100))];
    test.backgroundColor = [UIColor redColor];
    [_layoutDemoView addSubview:test];

    [_layoutDemoView layoutIfNeeded];
    [UIView commitAnimations];
}

- (void)removeSubviewButtonTapped
{
    if (_layoutDemoView.subviews.count <= 0) return;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    [[_layoutDemoView.subviews objectAtIndex:(_layoutDemoView.subviews.count - 1)] removeFromSuperview];
    
    [_layoutDemoView layoutIfNeeded];
    [UIView commitAnimations];
}


- (void)layoutModeSelected:(id)sender
{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];

    switch (segmentedControl.selectedSegmentIndex)
    {
        case 0:
            _layoutDemoView.layoutMode = RKLayoutModeHorizontal;
            break;
        case 1:
            _layoutDemoView.layoutMode = RKLayoutModeVertical;
            break;
        default:
            _layoutDemoView.layoutMode = RKLayoutModeGrid;
            break;
    }
    [_layoutDemoView layoutIfNeeded];
    [UIView commitAnimations];
}

- (void)horizontalAlignModeSelected:(id)sender
{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    switch (segmentedControl.selectedSegmentIndex)
    {
        case 0:
            _layoutDemoView.horizontalAlign = RKLayoutHorizontalAlignLeft;
            break;
        case 1:
            _layoutDemoView.horizontalAlign = RKLayoutHorizontalAlignCenter;
            break;
        default:
            _layoutDemoView.horizontalAlign = RKLayoutHorizontalAlignRight;
            break;
    }
    [_layoutDemoView layoutIfNeeded];
    [UIView commitAnimations];
}

- (void)verticalAlignModeSelected:(id)sender
{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    switch (segmentedControl.selectedSegmentIndex)
    {
        case 0:
            _layoutDemoView.verticalAlign = RKLayoutVerticalAlignTop;
            break;
        case 1:
            _layoutDemoView.verticalAlign = RKLayoutVerticalAlignCenter;
            break;
        default:
            _layoutDemoView.verticalAlign = RKLayoutVerticalAlignBottom;
            break;
    }
    [_layoutDemoView layoutIfNeeded];
    [UIView commitAnimations];
}

- (void)spacingModeSelected:(id)sender
{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    switch (segmentedControl.selectedSegmentIndex)
    {
        case 0:
            _layoutDemoView.spacingMode = RKLayoutSpacingModeFixed;
            break;
        default:
            _layoutDemoView.spacingMode = RKLayoutSpacingModeAuto;
    }
    [_layoutDemoView layoutIfNeeded];
    [UIView commitAnimations];
}

@end
