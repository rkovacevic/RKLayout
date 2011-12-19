//
//  RKFrameAdjustBlockManager.h
//  RKLayoutExample
//
//  Created by Robert Kovačević on 12/19/11.
//  Copyright (c) 2011 Robert Kovačević. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RKFrameAdjustBlockManager : NSObject

@property (nonatomic, assign) BOOL insideFrameAdjustBlock;
@property (nonatomic, assign) CGRect frame;

+ (RKFrameAdjustBlockManager*)sharedRKFrameAdjustBlockManager;

@end
