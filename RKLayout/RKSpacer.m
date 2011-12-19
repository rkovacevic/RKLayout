//
//  RKSpacer.m
//
//  Created by Robert Kovačević on 12/19/11.
//  Copyright (c) 2011 Robert Kovačević. All rights reserved.
//

#import "RKSpacer.h"
#import "RKLayout.h"

@implementation RKSpacer

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
    }
    return self;
}

+ (id)spacerWithWidth:(CGFloat)width withHeight:(CGFloat)height
{
    return [[RKSpacer alloc] initWithFrame:RKOriginRectMake(width, height)];
}

+ (id)spacerWithWidth:(CGFloat)width
{
    return [RKSpacer spacerWithWidth:width withHeight:0.0f];
}

+ (id)spacerWithHeight:(CGFloat)height
{
    return [RKSpacer spacerWithWidth:0.0f withHeight:height];
}

@end
