//
//  RKLayout.h
//
//  Created by Robert Kovačević on 12/17/11.
//  Copyright (c) 2011 Robert Kovačević. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RKLayoutVersion 1.0

typedef enum {
    RKLayoutModeHorizontal,
    RKLayoutModeVertical,
    RKLayoutModeGrid
} RKLayoutMode;

typedef enum {
    RKLayoutSpacingModeFixed,
    RKLayoutSpacingModeAuto
} RKLayoutSpacingMode;

typedef enum {
    RKLayoutHorizontalAlignLeft,
    RKLayoutHorizontalAlignRight,
    RKLayoutHorizontalAlignCenter
} RKLayoutHorizontalAlign;

typedef enum {
    RKLayoutVerticalAlignTop,
    RKLayoutVerticalAlignBottom,
    RKLayoutVerticalAlignCenter
} RKLayoutVerticalAlign;

@interface RKLayout : UIView

@property (nonatomic, assign) RKLayoutMode layoutMode; // default is RKLayoutModeHorizontal
@property (nonatomic, assign) RKLayoutSpacingMode spacingMode; // default is RKLayoutSpacingModeFixed
@property (nonatomic, assign) RKLayoutHorizontalAlign horizontalAlign; // default is RKLayoutHorizontalAlignLeft
@property (nonatomic, assign) RKLayoutVerticalAlign verticalAlign; // default is RKLayoutVerticalAlignTop
@property (nonatomic, assign) CGFloat spacing; // spacing between subviews, default is zero

- (id)initWithFrame:(CGRect)frame withSpacing:(CGFloat)spacing;
- (id)initWithFrame:(CGRect)frame withMode:(RKLayoutMode)mode withSpacing:(CGFloat)spacing;
- (id)initWithFrame:(CGRect)frame withMode:(RKLayoutMode)mode;

- (CGSize)contentSize;

@end

@interface RKLayout (RKLayoutPositioning)

+ (void)positionView:(UIView*)view rightOfView:(UIView*)baseView;
+ (void)positionView:(UIView*)view rightOfView:(UIView*)baseView withSpacing:(CGFloat)spacing;

+ (void)positionView:(UIView*)view leftOfView:(UIView*)baseView;
+ (void)positionView:(UIView*)view leftOfView:(UIView*)baseView withSpacing:(CGFloat)spacing;

+ (void)positionView:(UIView*)view aboveView:(UIView*)baseView;
+ (void)positionView:(UIView*)view aboveView:(UIView*)baseView withSpacing:(CGFloat)spacing;

+ (void)positionView:(UIView*)view bellowView:(UIView*)baseView;
+ (void)positionView:(UIView*)view bellowView:(UIView*)baseView withSpacing:(CGFloat)spacing;

+ (void)centerView:(UIView*)view inFrame:(CGRect)frame;

@end

CG_INLINE CGRect
RKOriginRectMake(CGFloat width, CGFloat height)
{
    CGRect rect;
    rect.origin.x = 0; rect.origin.y = 0;
    rect.size.width = width; rect.size.height = height;
    return rect;
}
