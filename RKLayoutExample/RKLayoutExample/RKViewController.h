//
//  RKViewController.h
//  RKLayoutExample
//
//  Created by Robert Kovačević on 12/18/11.
//  Copyright (c) 2011 Robert Kovačević. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RKLayout;

@interface RKViewController : UIViewController {
    RKLayout* _controlsLayout;
    RKLayout* _mainLayout;
    UISegmentedControl* _horizontalAlignModeSegmentedControl;
    UISegmentedControl* _verticalAlignModeSegmentedControl;
    UISegmentedControl* _spacingModeSegmentedControl;
    UISegmentedControl* _layoutModeSegmentedControl;
    UIButton* _addSubviewButton;
    UIButton* _removeSubviewButton;
    
    RKLayout* _layoutDemoView;
}

@end
