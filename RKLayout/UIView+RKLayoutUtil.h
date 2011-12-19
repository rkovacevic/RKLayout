//
//  UIView+NTHLayoutUtil.h
//
//  Created by Robert Kovačević on 12/17/11.
//  Copyright (c) 2011 Robert Kovačević. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RKLayoutUtil)

- (void)beginFrameAdjust;
- (void)commitFrameAdjust;

// Frame getter / setter helpers

- (CGFloat)frameWidth;
- (void)setFrameWidth:(CGFloat)width;

- (CGFloat)frameHeight;
- (void)setFrameHeight:(CGFloat)height;

- (CGFloat)frameX;
- (void)setFrameX:(CGFloat)x;

- (CGFloat)frameY;
- (void)setFrameY:(CGFloat)y;

// Common calculations

- (CGFloat)sumOfSubviewWidths;
- (CGFloat)sumOfSubviewHeights;
- (CGFloat)maxSubviewWidth;
- (CGFloat)maxSubviewHeight;

@end
