//
//  YHBackgroundAlbumView.m
//  QQ音乐
//
//  Created by bot on 16/6/26.
//  Copyright © 2016年 bot. All rights reserved.
//

#import "YHBackgroundAlbumView.h"
#import "YHFooterMenu.h"


@interface YHBackgroundAlbumView ()

@property (weak,nonatomic) YHFooterMenu * footerMenu;
@property (weak,nonatomic) UIImageView * iconImageView;

@end

@implementation YHBackgroundAlbumView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor greenColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    //底部菜单
    YHFooterMenu *footerMenu = [[YHFooterMenu alloc]init];
    [self addSubview:footerMenu];
    _footerMenu = footerMenu;
    
    //中间icon
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.backgroundColor = [UIColor orangeColor];
    [self addSubview:imageView];
    _iconImageView = imageView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat bgW = self.bounds.size.width;
    CGFloat bgH = self.bounds.size.height;
    
    //底部菜单
    CGFloat meunH = bgH * 0.25;
    CGFloat menuX = 0;
    CGFloat menuY = bgH - meunH;
    _footerMenu.frame = (CGRect){menuX,menuY,bgW,meunH};
    
    //中间icon
    CGFloat iconW = bgW * 0.7;
    _iconImageView.frame = (CGRect){0,0,iconW,iconW};
    _iconImageView.centerX = bgW * 0.5;
    _iconImageView.centerY = YHStatusBarHeight + (self.height - YHStatusBarHeight - meunH) * 0.5;
    _iconImageView.layer.cornerRadius = iconW * 0.5;
    _iconImageView.layer.borderColor = [UIColor colorWithRed:36/255.0 green:36/255.0 blue:36/255.0 alpha:1].CGColor;
    _iconImageView.layer.borderWidth = iconW * 0.07;
}

@end
