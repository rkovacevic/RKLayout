//
//  RKLayout.m
//
//  Created by Robert Kovačević on 12/17/11.
//  Copyright (c) 2011 Robert Kovačević. All rights reserved.
//

#import "RKLayout.h"
#import "UIView+RKLayoutUtil.h"
#import "RKFrameAdjustBlockManager.h"

@interface RKLayout ()

- (CGSize)contentSizeVertical;
- (CGSize)contentSizeHorizontal;
- (CGSize)contentSizeGrid;

- (void)layoutSubviewsVertical;
- (void)layoutSubviewsHorizontal;
- (void)layoutSubviewsGrid;

- (CGFloat)horizontalAlignMargin;
- (CGFloat)verticalAlignMargin;

- (CGFloat)gridAutoSpacing;

@end

@implementation RKLayout

@synthesize layoutMode = _layoutMode;
@synthesize spacingMode = _spacingMode;
@synthesize horizontalAlign = _horizontalAlign;
@synthesize verticalAlign = _verticalAlign;
@synthesize spacing = _spacing;

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Set defaults
        _layoutMode = RKLayoutModeHorizontal;
        _spacingMode = RKLayoutSpacingModeFixed;
        _horizontalAlign = RKLayoutHorizontalAlignLeft;
        _verticalAlign = RKLayoutVerticalAlignTop;
        _spacing = 0;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withSpacing:(CGFloat)spacing
{
    self = [self initWithFrame:frame];
    if (self) {
        _spacing = spacing;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withMode:(RKLayoutMode)mode withSpacing:(CGFloat)spacing
{
    self = [self initWithFrame:frame withSpacing:spacing];
    if (self) {
        _layoutMode = mode;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withMode:(RKLayoutMode)mode
{
    return [self initWithFrame:frame withMode:mode withSpacing:0.0f];
}

#pragma mark - Public

- (void)setLayoutMode:(RKLayoutMode)layoutMode
{
    _layoutMode = layoutMode;
    [self setNeedsLayout];
}

- (void)setSpacingMode:(RKLayoutSpacingMode)spacingMode
{
    _spacingMode = spacingMode;
    [self setNeedsLayout];
}

- (CGSize)contentSize
{
    switch (self.layoutMode) {
        case RKLayoutModeVertical:
            return [self contentSizeVertical];
        case RKLayoutModeGrid:
            return [self contentSizeGrid];
        default:
            return [self contentSizeHorizontal];
    }
}

#pragma mark - UIView overrides

- (void)layoutSubviews
{
    switch (self.layoutMode) {
        case RKLayoutModeVertical:
            [self layoutSubviewsVertical];
            break;
        case RKLayoutModeGrid:
            [self layoutSubviewsGrid];
            break;
        default:
            [self layoutSubviewsHorizontal];
            break;
    }
}

#pragma mark - Private

- (void)layoutSubviewsHorizontal
{
    CGFloat horizontalAlignMargin = self.horizontalAlignMargin;
    CGFloat verticalAlignMargin = self.verticalAlignMargin;
    
    CGFloat spacing = self.spacing;
    if (self.spacingMode == RKLayoutSpacingModeAuto)
    {
        spacing = (self.frameWidth - self.sumOfSubviewWidths) / (self.subviews.count + 1);
    }
    
    CGFloat maxSubviewHeight = self.maxSubviewWidth;
    
    CGFloat currentX = horizontalAlignMargin + spacing;
    for (UIView* subview in self.subviews)
    {
        CGFloat frameX = currentX;
        CGFloat frameY = verticalAlignMargin;
        if (self.verticalAlign == RKLayoutVerticalAlignCenter)
        {
            frameY = frameY + (maxSubviewHeight - subview.frameHeight) / 2;
        }
        subview.frame = CGRectMake(frameX, frameY, subview.frameWidth, subview.frameHeight);
        currentX += spacing + subview.frameWidth;
    }
}

- (void)layoutSubviewsVertical
{
    CGFloat horizontalAlignMargin = self.horizontalAlignMargin;
    CGFloat verticalAlignMargin = self.verticalAlignMargin;

    CGFloat spacing = self.spacing;
    if (self.spacingMode == RKLayoutSpacingModeAuto)
    {
        spacing = (self.frameHeight - self.sumOfSubviewHeights) / (self.subviews.count + 1);
    }
    
    CGFloat maxSubviewWidth = self.maxSubviewWidth;
    
    CGFloat currentY = verticalAlignMargin + spacing;
    for (UIView* subview in self.subviews)
    {
        CGFloat frameY = currentY;
        CGFloat frameX = horizontalAlignMargin;
        if (self.horizontalAlign == RKLayoutHorizontalAlignCenter)
        {
            frameX = frameX + (maxSubviewWidth - subview.frameWidth) / 2;
        }
        subview.frame = CGRectMake(frameX, frameY, subview.frameWidth, subview.frameHeight);
        currentY += spacing + subview.frameHeight;
    }
}

- (void)layoutSubviewsGrid
{
    CGFloat horizontalAlignMargin = self.horizontalAlignMargin;
    CGFloat verticalAlignMargin = self.verticalAlignMargin;

    CGFloat maxSubviewWidth = self.maxSubviewWidth;
    CGFloat maxSubviewHeight = self.maxSubviewHeight;
    
    CGFloat spacing = self.spacing;
    if (self.spacingMode == RKLayoutSpacingModeAuto)
    {
        spacing = self.gridAutoSpacing;
    }
    
    NSInteger currentColumn = 0;
    NSInteger currentRow = 0;
    CGFloat currentColumnWidth = horizontalAlignMargin + spacing;
    CGFloat curreRKeight = verticalAlignMargin + spacing;
    
    for (UIView* subview in self.subviews)
    {
        if (currentColumn > 0 && (currentColumnWidth + maxSubviewWidth + spacing) > self.frameWidth) 
        {
            // Next row
            currentRow++;
            currentColumn = 0;
            currentColumnWidth = horizontalAlignMargin + spacing;
            curreRKeight += spacing + maxSubviewHeight;
        }
        CGRect cellRect = CGRectMake(currentColumnWidth, curreRKeight, maxSubviewWidth, maxSubviewHeight);
        [RKLayout centerView:subview inFrame:cellRect];
        currentColumnWidth += maxSubviewWidth + spacing;
        currentColumn++;
    }
}

- (CGFloat)horizontalAlignMargin
{
    if (self.layoutMode == RKLayoutModeHorizontal && 
        self.spacingMode == RKLayoutSpacingModeAuto) return 0.0f;

    CGSize contentSize = self.contentSize;
    CGFloat horizontalAlignMargin = 0.0f;
    switch (self.horizontalAlign) {
        case RKLayoutHorizontalAlignCenter:
            horizontalAlignMargin = (self.frameWidth - contentSize.width) / 2;
            break;
        case RKLayoutHorizontalAlignRight:
            horizontalAlignMargin = self.frameWidth - contentSize.width;
            break;
        default:
            horizontalAlignMargin = 0.0f;
            break;
    }
    
    return MAX(0.0f, horizontalAlignMargin);
}

- (CGFloat)verticalAlignMargin
{
    if (self.layoutMode == RKLayoutModeVertical &&
        self.spacingMode == RKLayoutSpacingModeAuto) return 0.0f;
    
    CGSize contentSize = self.contentSize;
    
    CGFloat verticalAlignMargin = 0.0f;
    switch (self.verticalAlign) {
        case RKLayoutVerticalAlignCenter:
            verticalAlignMargin = (self.frameHeight - contentSize.height) / 2;
            break;
        case RKLayoutVerticalAlignBottom:
            verticalAlignMargin = self.frameHeight - contentSize.height;
            break;
        default:
            verticalAlignMargin = 0.0f;
            break;
    }
    
    return MAX(0.0f, verticalAlignMargin);
}

- (CGSize)contentSizeHorizontal
{
    CGFloat maxSubviewHeight = 0.0f;
    CGFloat contentWidth = self.spacing;
    
    for (UIView* subview in self.subviews)
    {
        contentWidth += subview.frameWidth + self.spacing;
        maxSubviewHeight = MAX(maxSubviewHeight, subview.frameHeight);
    }
    
    switch (self.spacingMode) {
        case RKLayoutSpacingModeFixed:
            return CGSizeMake(contentWidth, maxSubviewHeight);            
        default:
            return CGSizeMake(self.frameWidth, maxSubviewHeight);
    }
}

- (CGSize)contentSizeVertical
{
    CGFloat maxSubviewWidth = 0.0f;
    CGFloat contentHeight = self.spacing;
    
    for (UIView* subview in self.subviews)
    {
        contentHeight += subview.frameHeight + self.spacing;
        maxSubviewWidth = MAX(maxSubviewWidth, subview.frameWidth);
    }
    
    switch (self.spacingMode) {
        case RKLayoutSpacingModeFixed:
            return CGSizeMake(maxSubviewWidth, contentHeight);
        default:
            return CGSizeMake(maxSubviewWidth, self.frameHeight);
    }
}

- (CGSize)contentSizeGrid
{
    CGFloat spacing = self.spacing;
    if (self.spacingMode == RKLayoutSpacingModeAuto)
    {
        spacing = self.gridAutoSpacing;
    }
    
    CGFloat maxSubviewWidth = self.maxSubviewWidth;
    CGFloat maxSubviewHeight = self.maxSubviewHeight;
    
    NSInteger numberOfColumns = 0;
    NSInteger numberOfRows = 1;
    NSInteger currentColumn = 0;
    NSInteger currentRow = 0;
    CGFloat currentColumnWidth = spacing;
    CGFloat contentWidth = 0.0f;
    CGFloat conteRKeight = spacing + maxSubviewHeight;
    for (UIView* subview in self.subviews)
    {
        if (currentColumn > 0 && (currentColumnWidth + maxSubviewWidth + spacing) > self.frameWidth) 
        {
            // Next row
            currentRow++;
            numberOfRows++;
            currentColumn = 0;
            currentColumnWidth = spacing;
            conteRKeight += spacing + maxSubviewHeight;
        }
        currentColumnWidth += maxSubviewWidth + spacing;
        currentColumn++;
        contentWidth = MAX(contentWidth, currentColumnWidth);
        numberOfColumns = MAX(numberOfColumns, currentColumn + 1);
    }
    
    return CGSizeMake(contentWidth, conteRKeight);
}

- (CGFloat)gridAutoSpacing
{
    NSUInteger numberOfColumnsOrRows = lroundf(sqrtf(self.subviews.count));
    CGFloat largerDimension = MAX(self.maxSubviewWidth, self.maxSubviewHeight);
    return (self.frameHeight - (numberOfColumnsOrRows * largerDimension)) / (self.subviews.count + 1);
}

@end

@implementation RKLayout (RKLayoutPositioning)

+ (void)positionView:(UIView*)view rightOfView:(UIView*)baseView
{
    [RKLayout positionView:view rightOfView:baseView withSpacing:0.0f];
}

+ (void)positionView:(UIView*)view rightOfView:(UIView*)baseView withSpacing:(CGFloat)spacing
{
    if (baseView == nil)
    {
        view.frameX = spacing;
        return;
    }
    
    view.frameX = baseView.frameX + baseView.frameWidth + spacing;
}

+ (void)positionView:(UIView*)view leftOfView:(UIView*)baseView
{
    [RKLayout positionView:view leftOfView:baseView withSpacing:0.0f];
}

+ (void)positionView:(UIView*)view leftOfView:(UIView*)baseView withSpacing:(CGFloat)spacing
{
    if (baseView == nil)
    {
        view.frameX = -view.frameWidth;
        return;
    }
    
    view.frameX = baseView.frameX - spacing - view.frameWidth;
}

+ (void)positionView:(UIView*)view aboveView:(UIView*)baseView
{
    [RKLayout positionView:view aboveView:baseView withSpacing:0.0f];
}

+ (void)positionView:(UIView*)view aboveView:(UIView*)baseView withSpacing:(CGFloat)spacing
{
    if (baseView == nil)
    {
        view.frameY = -view.frameHeight;
        return;
    }
    
    view.frameY = baseView.frameY - spacing - view.frameHeight;
}

+ (void)positionView:(UIView*)view bellowView:(UIView*)baseView
{
    [RKLayout positionView:view bellowView:baseView withSpacing:0.0f];
}

+ (void)positionView:(UIView*)view bellowView:(UIView*)baseView withSpacing:(CGFloat)spacing
{
    if (baseView == nil)
    {
        view.frameY = spacing;
        return;
    }
    
    view.frameY = baseView.frameY + baseView.frameHeight + spacing;
}

+ (void)centerView:(UIView*)view inFrame:(CGRect)frame
{
    [view beginFrameAdjust];
    view.frameX = frame.origin.x + (frame.size.width - view.frameWidth) / 2;
    view.frameY = frame.origin.y + (frame.size.height - view.frameHeight) / 2;
    [view commitFrameAdjust];
}

@end

