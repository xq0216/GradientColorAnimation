//
//  NSTimer+BlockSupport.m
//  XQCalculator
//
//  Created by Candy Love on 15/8/10.
//  Copyright (c) 2015年 XQ. All rights reserved.
//

#import "NSTimer+BlockSupport.h"

@implementation NSTimer(BlockSupport)
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      block:(void(^)())block
                                    repeats:(BOOL)repeats
{
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(blockInvoke:)
                                       userInfo:[block copy]
                                        repeats:repeats];
}

+ (void)blockInvoke:(NSTimer *)timer {
    void (^block)() = timer.userInfo;
    if(block) {
        block();
    }
}
@end
