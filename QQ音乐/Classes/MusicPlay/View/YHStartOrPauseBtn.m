//
//  YHStartOrPauseBtn.m
//  QQ音乐
//
//  Created by bot on 16/6/26.
//  Copyright © 2016年 bot. All rights reserved.
//

#import "YHStartOrPauseBtn.h"

@implementation YHStartOrPauseBtn

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat inset = 0.13 * self.bounds.size.width;
    self.imageView.frame = (CGRect) {inset,inset,self.width - 2 * inset,self.height - 2 * inset};
}

@end
