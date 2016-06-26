//
//  UIView+YHFrame.h
//  QQ音乐
//
//  Created by bot on 16/6/26.
//  Copyright © 2016年 bot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YHFrame)

@property (assign,nonatomic) CGFloat x;
@property (assign,nonatomic) CGFloat y;
@property (assign,nonatomic) CGFloat width;
@property (assign,nonatomic) CGFloat height;
@property (assign,nonatomic) CGFloat centerX;
@property (assign,nonatomic) CGFloat centerY;
@property (assign,nonatomic,readonly) CGFloat maxY;
@property (assign,nonatomic,readonly) CGFloat maxX;
@property (assign,nonatomic,readonly) CGFloat minY;
@property (assign,nonatomic,readonly) CGFloat minX;
@property (assign,nonatomic,readonly) CGFloat midX;
@property (assign,nonatomic,readonly) CGFloat midY;

@end
