//
//  YHTimeIntervalTool.m
//  QQ音乐
//
//  Created by bot on 16/6/28.
//  Copyright © 2016年 bot. All rights reserved.
//

#import "YHTimeIntervalTool.h"

#define YHSecondsPerHour (60 * 60)
#define YHSecondsPerMin  60

@implementation YHTimeIntervalTool

+ (NSString *)playTimeFomartWith:(NSTimeInterval)timeInterval
{
//    NSLog(@"%f",timeInterval);
    //时
    NSInteger hour = timeInterval / YHSecondsPerHour;
//    NSLog(@"%ld",hour);
    
    //分
    NSInteger min = (timeInterval - hour * YHSecondsPerHour ) / YHSecondsPerMin;
//    NSLog(@"%ld",min);
    
    NSInteger sec = timeInterval - hour * YHSecondsPerHour - min * YHSecondsPerMin;
//    NSLog(@"%ld",sec);
    
    //215 --> 0 --> 3 --> 35
    // 45s --> 0 --> 0 --> 45s
    // 60s --> 0 --> 1 --> 0
    
    NSString *time = [NSString stringWithFormat:@"%02ld:%02ld",min,sec];
    
    return time;
}

@end
