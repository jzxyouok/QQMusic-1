//
//  UIView+YHFrame.m
//  QQ音乐
//
//  Created by bot on 16/6/26.
//  Copyright © 2016年 bot. All rights reserved.
//

#import "UIView+YHFrame.h"

@implementation UIView (YHFrame)

// frame.origin.x
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

// frame.origin.y
- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

//frame.size.width
- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

//frame.size.height
- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

//centerx
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

//centery
- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

//frame 最大X
- (CGFloat)maxX
{
    return CGRectGetMaxX(self.frame);
}

//frame 最大Y
- (CGFloat)maxY
{
    return CGRectGetMaxY(self.frame);
}

//frame 最小X
- (CGFloat)minX
{
    return CGRectGetMinX(self.frame);
}
//frame 最小Y
- (CGFloat)minY
{
    return CGRectGetMinY(self.frame);
}
//frame 中间X
- (CGFloat)midX
{
    return CGRectGetMidX(self.frame);
}

//frame 中间Y
- (CGFloat)midY
{
    return CGRectGetMidY(self.frame);
}






@end
