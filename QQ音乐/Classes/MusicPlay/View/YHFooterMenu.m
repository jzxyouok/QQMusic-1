//
//  YHFooterMenu.m
//  QQ音乐
//
//  Created by bot on 16/6/26.
//  Copyright © 2016年 bot. All rights reserved.
//

#import "YHFooterMenu.h"
#import "YHFooterMenuSubOptionsMenu.h"
#import "YHStartOrPauseBtn.h"

/**
 * 这个类既发出播放音乐的通知，同时也是播放音乐通知的接受者
 */

@interface YHFooterMenu ()

@property (weak,nonatomic) UISlider * progressSlider;
@property (weak,nonatomic) YHStartOrPauseBtn * startOrPauseBtn;
@property (weak,nonatomic) UIButton * nextSongBtn;
@property (weak,nonatomic) UIButton * lastSongBtn;

@property (weak,nonatomic) YHFooterMenuSubOptionsMenu * subOptionsMenu;

@end

@implementation YHFooterMenu

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor purpleColor];
        [YHNotificationCenter addObserver:self selector:@selector(play) name:YHPlayNotification object:nil];
        [self setupUI];
    }
    return self;
}

//当点击进cell时，决定播放按钮是否选中
- (void)play
{    
    if (self.startOrPauseBtn.selected == NO) {
        self.startOrPauseBtn.selected = YES;
    }
}

#pragma mark - 配置UI
- (void)setupUI
{
    //播放进度条
    UISlider *slider = [[UISlider alloc]init];
    [slider setThumbImage:[UIImage imageNamed:@"player_slider_playback_thumb"] forState:UIControlStateNormal];
    slider.backgroundColor = [UIColor blueColor];
    [self addSubview:slider];
    _progressSlider = slider;
    
    
    //上一首
    UIButton *btn2 = [self btnWithImage:[UIImage imageNamed:@"player_btn_pre_normal"] selectedImage:nil highlightedImage:[UIImage imageNamed:@"player_btn_pre_highlight"] withTag:YHFooterMenuBtnTypeLastSong];
    [self addSubview:btn2];
    _lastSongBtn = btn2;
    
    //暂停或继续按钮
    YHStartOrPauseBtn *btn1 = (YHStartOrPauseBtn *)[self btnWithImage:[UIImage imageNamed:@"player_btn_play_normal"] selectedImage:[UIImage imageNamed:@"player_btn_pause_normal"] highlightedImage:[UIImage imageNamed:@"player_btn_play_highlight"] withTag:YHFooterMenuBtnTypeStartOrPause];
    btn1.backgroundColor = [UIColor redColor];
    [self addSubview:btn1];
    _startOrPauseBtn = btn1;

    //下一首
    UIButton *btn3 = [self btnWithImage:[UIImage imageNamed:@"player_btn_next_normal"] selectedImage:nil highlightedImage:[UIImage imageNamed:@"player_btn_next_highlight"] withTag:YHFooterMenuBtnTypeNextSong];
    [self addSubview:btn3];
    _nextSongBtn = btn3;
}

- (UIButton *)btnWithImage:(UIImage *)image selectedImage:(UIImage *)selImage  highlightedImage:(UIImage *)hgImage withTag:(YHFooterMenuBtnType)type
{
    if (type == YHFooterMenuBtnTypeStartOrPause) {
        YHStartOrPauseBtn *btn = [YHStartOrPauseBtn buttonWithType:UIButtonTypeCustom];
        [self setBtn:btn image:image selectedImage:selImage highlightedImage:hgImage withTag:type];
        return btn;
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setBtn:btn image:image selectedImage:selImage highlightedImage:hgImage withTag:type];
    return btn;
}

- (void)setBtn:(UIButton *)btn image:(UIImage *)image selectedImage:(UIImage *)selImage  highlightedImage:(UIImage *)hgImage withTag:(YHFooterMenuBtnType)type
{
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn setImage:hgImage forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = type;
}

#pragma mark - 点击事件
- (void)btnDidClick:(UIButton *)btn
{
    switch (btn.tag) {
        case YHFooterMenuBtnTypeStartOrPause:
            [self startOrPause:(YHStartOrPauseBtn *)btn];
            break;
        case YHFooterMenuBtnTypeLastSong:
            [self lastSong:btn];
            break;
        case YHFooterMenuBtnTypeNextSong:
            [self nextSong:btn];
        default:
            break;
    }
}

- (void)startOrPause:(YHStartOrPauseBtn *)btn
{
    btn.selected = !btn.isSelected;
    if (btn.isSelected) {//播放音乐
        [YHNotificationCenter postNotificationName:YHPlayNotification object:self];
    }else{//暂停播放
        [YHNotificationCenter postNotificationName:YHPauseNotificaiton object:self];
    }
}

- (void)lastSong:(UIButton *)btn
{
    //切换到上一首
    [YHNotificationCenter postNotificationName:YHLastSongNotification object:self];
}


- (void)nextSong:(UIButton *)btn
{
    //切换到下一首
    [YHNotificationCenter postNotificationName:YHNextSongNotificaiton object:self];
}

#pragma mark - 布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
   
   //进度条
    CGFloat menuW = self.bounds.size.width;
    CGFloat sliderH = 20;
    _progressSlider.frame = (CGRect){0,0,menuW,sliderH};
    
    //播放按钮
    CGFloat btnW1 = menuW * 0.3;
    UIButton *btn1 = [self viewWithTag:YHFooterMenuBtnTypeStartOrPause];
    btn1.frame = (CGRect){0,0,btnW1,btnW1};
    btn1.center = (CGPoint){menuW / 2,btnW1 *0.5 + sliderH};
    
   //上一首
    CGFloat btnW2 = menuW * 0.2;
    UIButton *btn2 = [self viewWithTag:YHFooterMenuBtnTypeLastSong];
    btn2.frame = (CGRect){0,0,btnW2,btnW2};
    btn2.center = (CGPoint){btn1.center.x - (btnW1 + btnW2) * 0.5,btn1.center.y};
    
    //下一首
    UIButton *btn3 = [self viewWithTag:YHFooterMenuBtnTypeNextSong];
    btn3.frame = (CGRect){0,0,btnW2,btnW2};
    btn3.center = (CGPoint){btn1.center.x + (btnW1 + btnW2) * 0.5,btn1.center.y};
}


@end
