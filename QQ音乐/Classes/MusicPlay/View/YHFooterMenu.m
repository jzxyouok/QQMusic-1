//
//  YHFooterMenu.m
//  QQ音乐
//
//  Created by bot on 16/6/26.
//  Copyright © 2016年 bot. All rights reserved.
//

#import "YHFooterMenu.h"
#import "YHStartOrPauseBtn.h"
#import "YHMusicPlayTool.h"
#import "YHTimeIntervalTool.h"

/**
 * 这个类既发出播放音乐的通知，同时也是播放音乐通知的接受者
 */

#define YHSliderProgressIndicatorFont [UIFont systemFontOfSize:11]

@interface YHFooterMenu ()

@property (weak,nonatomic) UISlider                   * progressSlider;
@property (weak,nonatomic) UILabel                    * progressTimeLabel;
@property (weak,nonatomic) UILabel                    * totalTimeLabel;
@property (weak,nonatomic) YHStartOrPauseBtn          * startOrPauseBtn;
@property (weak,nonatomic) UIButton                   * nextSongBtn;
@property (weak,nonatomic) UIButton                   * lastSongBtn;

@property (assign,nonatomic) NSTimeInterval            totalTimeInterval;

@end

@implementation YHFooterMenu

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       
        [self setupUI];
    }
    return self;
}

#pragma mark - 配置UI
- (void)setupUI
{
    //播放进度条
    UISlider *slider = [[UISlider alloc]init];
    [slider setThumbImage:[UIImage imageNamed:@"player_slider_playback_thumb"] forState:UIControlStateNormal];
    [self addSubview:slider];
    slider.maximumValue = 1;
    slider.minimumValue = 0;
    [slider addTarget:self action:@selector(beginChange) forControlEvents:UIControlEventTouchDown];
    [slider addTarget:self action:@selector(changing:) forControlEvents:UIControlEventValueChanged];
    [slider addTarget:self action:@selector(endChange:) forControlEvents:UIControlEventTouchUpInside];
    _progressSlider = slider;
    
    //播放进度
    UILabel *progress = [[UILabel alloc]init];
    progress.textAlignment = NSTextAlignmentCenter;
    progress.textColor = [UIColor whiteColor];
    progress.font = YHSliderProgressIndicatorFont;
    [self addSubview:progress];
    _progressTimeLabel = progress;
    
    //播放总时长
    UILabel *totalTime = [[UILabel alloc]init];
    totalTime.textAlignment = NSTextAlignmentCenter;
    totalTime.textColor = [UIColor whiteColor];
    totalTime.font = YHSliderProgressIndicatorFont;
    [self addSubview:totalTime];
    _totalTimeLabel = totalTime;
    
    //上一首
    UIButton *btn2 = [self btnWithImage:[UIImage imageNamed:@"player_btn_pre_normal"] selectedImage:nil highlightedImage:[UIImage imageNamed:@"player_btn_pre_highlight"] withTag:YHFooterMenuBtnTypeLastSong];
    [self addSubview:btn2];
    _lastSongBtn = btn2;
    
    //暂停或继续按钮
    YHStartOrPauseBtn *btn1 = (YHStartOrPauseBtn *)[self btnWithImage:[UIImage imageNamed:@"player_btn_play_normal"] selectedImage:[UIImage imageNamed:@"player_btn_pause_normal"] highlightedImage:[UIImage imageNamed:@"player_btn_play_highlight"] withTag:YHFooterMenuBtnTypeStartOrPause];
    btn1.selected = YES;
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

#pragma mark - 传值
- (void)setBtnSelected:(BOOL)select
{
    if (select) {
        self.startOrPauseBtn.selected = YES;
    }else{
        self.startOrPauseBtn.selected = NO;
    }
}

- (void)setTotalTime:(NSTimeInterval)total
{
    _totalTimeLabel.text = [YHTimeIntervalTool playTimeFomartWith:total];
    self.totalTimeInterval = total;
}

- (void)setProgressTime:(NSTimeInterval)progress
{
    _progressTimeLabel.text = [YHTimeIntervalTool playTimeFomartWith:progress];
    
    _progressSlider.value = progress / self.totalTimeInterval;
    
    if (_progressSlider.value >= 0.99) {
        [self nextSong:nil];
    }
    
}


#pragma mark - 点击事件
- (void)beginChange
{
    if ([_delegate respondsToSelector:@selector(sliderBeginChange)]) {
        [_delegate sliderBeginChange];
    }
}

- (void)changing:(UISlider *)slider
{
    _progressTimeLabel.text = [YHTimeIntervalTool playTimeFomartWith:slider.value * self.totalTimeInterval];
    
    if ([_delegate respondsToSelector:@selector(sliderChanging)]) {
        [_delegate sliderChanging];
    }
}

- (void)endChange:(UISlider *)slider
{
    _progressTimeLabel.text = [YHTimeIntervalTool playTimeFomartWith:slider.value * self.totalTimeInterval];
    
    if ([_delegate respondsToSelector:@selector(sliderEndChange:)]) {
        [_delegate sliderEndChange:slider.value * self.totalTimeInterval];
    }
}


- (void)btnDidClick:(UIButton *)btn
{
    switch (btn.tag) {
        case YHFooterMenuBtnTypeStartOrPause:
            [self startOrPause:(YHStartOrPauseBtn *)btn];
            break;
        case YHFooterMenuBtnTypeLastSong:
            [self previousSong:btn];
            break;
        case YHFooterMenuBtnTypeNextSong:
            [self nextSong:btn];
        default:
            break;
    }
}

- (void)startOrPause:(YHStartOrPauseBtn *)btn
{
    
    
    if (btn.isSelected) {//播放音乐
        
        if ([_delegate respondsToSelector:@selector(pause)]) {
            [_delegate pause];
        }
       
    }else{//暂停播放
        if ([_delegate respondsToSelector:@selector(start)]) {
            [_delegate start];
        }
    }
    
    btn.selected = !btn.isSelected;
}

- (void)previousSong:(UIButton *)btn
{
    if ([_delegate respondsToSelector:@selector(previous)]) {
        [_delegate previous];
    }
}


- (void)nextSong:(UIButton *)btn
{
    if ([_delegate respondsToSelector:@selector(next)]) {
        [_delegate next];
    }
}

#pragma mark - 布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat menuW = self.bounds.size.width;
    CGFloat sliderH = 20;
    
    //播放进度
    CGFloat labelW = menuW * 0.1;
    CGFloat labelH = sliderH;
    _progressTimeLabel.frame = (CGRect){0,0,labelW,labelH};
    
   //进度条
    CGFloat sliderW = menuW - 2 * labelW;
    _progressSlider.frame = (CGRect){labelW,0,sliderW,sliderH};
    
    //播放总时长
    _totalTimeLabel.frame = (CGRect){_progressSlider.maxX,0,labelW,labelH};
    
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
