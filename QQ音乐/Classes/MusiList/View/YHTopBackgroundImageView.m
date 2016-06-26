//
//  YHTopBackgroundImageView.m
//  QQ音乐
//
//  Created by bot on 16/6/26.
//  Copyright © 2016年 bot. All rights reserved.
//

#import "YHTopBackgroundImageView.h"

@implementation YHTopBackgroundImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.image = [UIImage imageNamed:@"QQbackground3"];
        self.contentMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}

@end
