//
//  RKAppDelegate.h
//  RKLayoutExample
//
//  Created by Robert Kovačević on 12/18/11.
//  Copyright (c) 2011 Robert Kovačević. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RKViewController;

@interface RKAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) RKViewController *viewController;

@end
