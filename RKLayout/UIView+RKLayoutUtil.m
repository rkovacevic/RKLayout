//
//  UIView+NTHLayoutUtil.m
//
//  Created by Robert Kovačević on 12/17/11.
//  Copyright (c) 2011 Robert Kovačević. All rights reserved.
//

#import "UIView+RKLayoutUtil.h"
#import "RKFrameAdjustBlockManager.h"

@implementation UIView (RKLayoutUtil)

- (void)beginFrameAdjust
{
    [RKFrameAdjustBlockManager sharedRKFrameAdjustBlockManager].insideFrameAdjustBlock = YES;
    [RKFrameAdjustBlockManager sharedRKFrameAdjustBlockManager].frame = self.frame;
}

- (void)commitFrameAdjust
{
    self.frame = [RKFrameAdjustBlockManager sharedRKFrameAdjustBlockManager].frame;
    [RKFrameAdjustBlockManager sharedRKFrameAdjustBlockManager].insideFrameAdjustBlock = YES;
}

- (CGFloat)frameWidth
{
    return self.frame.size.width;
}

- (void)setFrameWidth:(CGFloat)width
{
    width = roundf(width);
    if ([RKFrameAdjustBlockManager sharedRKFrameAdjustBlockManager].insideFrameAdjustBlock)
    {
        CGRect frame = [RKFrameAdjustBlockManager sharedRKFrameAdjustBlockManager].frame;
        frame = CGRectMake(frame.origin.x, frame.origin.y, width, frame.size.height);
        [RKFrameAdjustBlockManager sharedRKFrameAdjustBlockManager].frame = frame;
    }
    else
    {
        self.frame = CGRectMake(self.frameX, self.frameY, width, self.frameHeight);
    }
}

- (CGFloat)frameHeight
{
    return self.frame.size.height;
}

- (void)setFrameHeight:(CGFloat)height
{
    height = roundf(height);
    if ([RKFrameAdjustBlockManager sharedRKFrameAdjustBlockManager].insideFrameAdjustBlock)
    {
        CGRect frame = [RKFrameAdjustBlockManager sharedRKFrameAdjustBlockManager].frame;
        frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.height, height);
        [RKFrameAdjustBlockManager sharedRKFrameAdjustBlockManager].frame = frame;
    }
    else
    {
        self.frame = CGRectMake(self.frameX, self.frameY, self.frameWidth, height);
    }
}

- (CGFloat)frameX
{
    return self.frame.origin.x;
}

- (void)setFrameX:(CGFloat)x
{
    x = roundf(x);
    if ([RKFrameAdjustBlockManager sharedRKFrameAdjustBlockManager].insideFrameAdjustBlock)
    {
        CGRect frame = [RKFrameAdjustBlockManager sharedRKFrameAdjustBlockManager].frame;
        frame = CGRectMake(x, frame.origin.y, frame.size.width, frame.size.height);
        [RKFrameAdjustBlockManager sharedRKFrameAdjustBlockManager].frame = frame;
    }
    else
    {
        self.frame = CGRectMake(x, self.frameY, self.frameWidth, self.frameHeight);
    }
}

- (CGFloat)frameY
{
    return self.frame.origin.y;
}

- (void)setFrameY:(CGFloat)y
{
    y = roundf(y);
    if ([RKFrameAdjustBlockManager sharedRKFrameAdjustBlockManager].insideFrameAdjustBlock)
    {
        CGRect frame = [RKFrameAdjustBlockManager sharedRKFrameAdjustBlockManager].frame;
        frame = CGRectMake(frame.origin.x, y, frame.size.width, frame.size.height);
        [RKFrameAdjustBlockManager sharedRKFrameAdjustBlockManager].frame = frame;
    }
    else
    {
        self.frame = CGRectMake(self.frameX, y, self.frameWidth, self.frameHeight);
    }
}

- (CGFloat)sumOfSubviewWidths
{
    CGFloat sumOfSubviewWidths = 0.0f;
    for (UIView* subview in self.subviews)
    {
        sumOfSubviewWidths += subview.frameWidth;
    }
    return sumOfSubviewWidths;
}

- (CGFloat)sumOfSubviewHeights
{
    CGFloat sumOfSubviewHeights = 0.0f;
    for (UIView* subview in self.subviews)
    {
        sumOfSubviewHeights += subview.frameHeight;
    }
    return sumOfSubviewHeights;
}

- (CGFloat)maxSubviewWidth
{
    CGFloat maxSubviewWidth = 0.0f;
    for (UIView* subview in self.subviews)
    {
        maxSubviewWidth = MAX(maxSubviewWidth, subview.frameWidth);
    }
    return maxSubviewWidth;
}

- (CGFloat)maxSubviewHeight
{
    CGFloat maxSubviewHeight = 0.0f;
    for (UIView* subview in self.subviews)
    {
        maxSubviewHeight = MAX(maxSubviewHeight, subview.frameHeight);
    }
    return maxSubviewHeight;
}

@end
