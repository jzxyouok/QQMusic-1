//
//  YHHeaderMenu.m
//  QQ音乐
//
//  Created by bot on 16/6/29.
//  Copyright © 2016年 bot. All rights reserved.
//

#import "YHHeaderMenu.h"

@interface YHHeaderMenu ()

@property (weak,nonatomic) UIButton * backBtn;
@property (weak,nonatomic) UIButton * menuBtn;

@end

@implementation YHHeaderMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor redColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setImage:[UIImage imageNamed:@"miniplayer_btn_playlist_close_b"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:back];
    _backBtn = back;
    
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [menuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [menuBtn setTitle:@"..." forState:UIControlStateNormal];
    menuBtn.titleLabel.font = [UIFont systemFontOfSize:40];
    [self addSubview:menuBtn];
    _menuBtn = menuBtn;
}

- (void)dismiss
{
    [YHNotificationCenter postNotificationName:YHDismissNotification object:self];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    _backBtn.frame = (CGRect) {10,30,50,50};
    
    _menuBtn.frame = (CGRect){310,30,50,50};
    
    
    
    
}


@end
