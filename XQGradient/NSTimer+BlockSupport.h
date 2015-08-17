//
//  NSTimer+BlockSupport.h
//  XQCalculator
//
//  Created by Candy Love on 15/8/10.
//  Copyright (c) 2015年 XQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer(BlockSupport)
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         block:(void(^)())block
                                       repeats:(BOOL)repeats;
@end
