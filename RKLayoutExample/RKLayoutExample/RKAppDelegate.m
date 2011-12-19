//
//  RKAppDelegate.m
//  RKLayoutExample
//
//  Created by Robert Kovačević on 12/18/11.
//  Copyright (c) 2011 Robert Kovačević. All rights reserved.
//

#import "RKAppDelegate.h"

#import "RKViewController.h"

@implementation RKAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.viewController = [[RKViewController alloc] init];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
