//
//  YHBackgroundAlbumView.m
//  QQ音乐
//
//  Created by bot on 16/6/26.
//  Copyright © 2016年 bot. All rights reserved.
//

#import "YHBackgroundAlbumView.h"
#import "YHFooterMenu.h"
#import "YHMusicModel.h"
#import "YHMusicPlayTool.h"


@interface YHBackgroundAlbumView ()


@property (weak,nonatomic) YHFooterMenu * footerMenu;
@property (weak,nonatomic) UIImageView * backgroundView;
@property (weak,nonatomic) UIImageView * iconImageView;
@property (weak,nonatomic) UIToolbar * toolBar;

@end

@implementation YHBackgroundAlbumView
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
        [self setupUI];
        
    }
    return self;
}

- (void)setup
{
    self.userInteractionEnabled = YES;
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroundColor = [UIColor greenColor];
    
    
    //歌曲图片背景
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.userInteractionEnabled = YES;
    [self addSubview:imageView];
    _backgroundView = imageView;
    
    //毛玻璃
    UIToolbar *toolBar = [[UIToolbar alloc]init];
    toolBar.barStyle = UIBarStyleBlack;
    toolBar.alpha = 1;
    [_backgroundView addSubview:toolBar];
    _toolBar = toolBar;
  
}
- (void)setupUI
{
    //底部菜单
    YHFooterMenu *footerMenu = [[YHFooterMenu alloc]init];
    [_backgroundView addSubview:footerMenu];
    _footerMenu = footerMenu;
    
    //中间icon
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_backgroundView addSubview:imageView];
    _iconImageView = imageView;
    
   
}

#pragma mark - 布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat bgW = self.bounds.size.width;
    CGFloat bgH = self.bounds.size.height;
    
    //背景视图
    _backgroundView.frame = self.bounds;
    
    //毛玻璃
    _toolBar.frame = self.bounds;
    
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
    _iconImageView.layer.masksToBounds = YES;
}

@end
