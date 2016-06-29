//
//  YHMusicPlayerViewController.m
//  QQ音乐
//
//  Created by bot on 16/6/26.
//  Copyright © 2016年 bot. All rights reserved.
//

#import "YHMusicPlayerViewController.h"
#import "YHBackgroundAlbumView.h"
#import "YHHeaderMenu.h"
#import "YHFooterMenu.h"

@interface YHMusicPlayerViewController ()<YHFooterMenuDelegate>

@property (strong,nonatomic) YHBackgroundAlbumView * albumView;
@property (strong,nonatomic) YHHeaderMenu *headerMenu;
@property (strong,nonatomic) YHFooterMenu  * footerMenu;

@property (strong,nonatomic) YHMusicModel *current;

@property (strong,nonatomic) NSTimer *timer;

@end

@implementation YHMusicPlayerViewController

#pragma mark - 出现动画
- (void)show
{
    [YHNotificationCenter addObserver:self selector:@selector(dismiss) name:YHDismissNotification object:nil];
    
    self.view.frame = YHKeyWindow.bounds;
    [YHKeyWindow addSubview:self.view];
    
   
    self.albumView.frame = YHKeyWindow.bounds;
    YHMusicModel *current = [YHMusicDataTool getCurrentMusic];
    self.albumView.albumImage = [UIImage imageNamed:current.icon];
    [YHKeyWindow addSubview:self.albumView];
    self.albumView.alpha = 0;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.albumView.alpha = 1;
    } completion:^(BOOL finished) {
        
        [self showHeaderMenu];
        [self showFooterMenu];
        
        [self startPlayingMusic];
        
        
    }];
}

- (void)showHeaderMenu
{
    self.headerMenu.frame = (CGRect){0,0,self.view.width,100};
    self.headerMenu.y = - 100;
    [YHKeyWindow addSubview:self.headerMenu];
    
   [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
       self.headerMenu.y = 0;
   } completion:nil];
    
}

- (void)showFooterMenu
{
    self.footerMenu.frame = (CGRect){0,0,self.view.width,170};
    self.footerMenu.y = self.view.height;
    [YHKeyWindow addSubview:self.footerMenu];
    
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.footerMenu.y = self.view.height - 170;
    } completion:nil];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
    
        self.headerMenu.y = - 100;
        self.footerMenu.y = self.view.height;
    } completion:^(BOOL finished) {
        

        [UIView animateWithDuration:0.3 animations:^{
            self.albumView.alpha = 0;
        } completion:^(BOOL finished) {
            [self.headerMenu removeFromSuperview];
            [self.footerMenu removeFromSuperview];
            [self.albumView removeFromSuperview];
            [self.view removeFromSuperview];
            
            [YHNotificationCenter removeObserver:self name:YHDismissNotification object:nil];
        }];
    }];
}

#pragma mark - 定时源
- (void)addProgressTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)removeProgressTimer
{
    [_timer invalidate];
    _timer = nil;
}

- (void)updateProgress
{
    AVAudioPlayer *currentPlayer = [YHMusicPlayTool getCurrentPlayer];
    
    [self.footerMenu setProgressTime:currentPlayer.currentTime];
}

#pragma mark - 播放音乐
- (void)startPlayingMusic
{
    [self removeProgressTimer];
    
    
    YHMusicModel *model = [YHMusicDataTool getCurrentMusic];
    
    if (![model.name isEqualToString:self.current.name]) {
        [YHMusicPlayTool stopPlayingMusicWithModel:self.current];
        [self.footerMenu setProgressTime:0];
    }else{
        AVAudioPlayer *currentPlayer = [YHMusicPlayTool getCurrentPlayer];
        if (!currentPlayer.isPlaying && currentPlayer != nil) {
            return;
        }
    }
    [self addProgressTimer];
   
    
   AVAudioPlayer *player = [YHMusicPlayTool playMusicWithModel:model];
    self.current = model;
    [self.footerMenu setTotalTime:player.duration];
    
    //播放音乐，将btn设置为选中
    [self.footerMenu setBtnSelected:YES];
}

#pragma mark - YHFootMenu 代理方法

- (void)start
{
    AVAudioPlayer *currentPlayer = [YHMusicPlayTool getCurrentPlayer];
    if (!currentPlayer.isPlaying && currentPlayer != nil) {
        [self addProgressTimer];
        [currentPlayer play];
    }
}

- (void)pause
{
    YHMusicModel *current = [YHMusicDataTool getCurrentMusic];
    [YHMusicPlayTool pauseMusicWithModel:current];
    
    [self removeProgressTimer];
    
}

- (void)next
{
    [self removeProgressTimer];
    [self addProgressTimer];
    
    YHMusicModel *current = [YHMusicDataTool getCurrentMusic];
    [YHMusicPlayTool stopPlayingMusicWithModel:current];
    
    YHMusicModel *next = [YHMusicDataTool nextMusic];
   AVAudioPlayer *player = [YHMusicPlayTool playMusicWithModel:next];
    [YHMusicDataTool setCurrentMusicWith:next];
    self.current = next;
    self.albumView.albumImage = [UIImage imageNamed:next.icon];
    [self.footerMenu setTotalTime:player.duration];
    
    //播放音乐，将btn设置为选中
    [self.footerMenu setBtnSelected:YES];
}

- (void)previous
{
    [self removeProgressTimer];
    [self addProgressTimer];
    
    YHMusicModel *current = [YHMusicDataTool getCurrentMusic];
    [YHMusicPlayTool stopPlayingMusicWithModel:current];
    
    YHMusicModel *previous = [YHMusicDataTool previousMusic];
   AVAudioPlayer *player = [YHMusicPlayTool playMusicWithModel:previous];
    [YHMusicDataTool setCurrentMusicWith:previous];
    self.current = previous;
    self.albumView.albumImage = [UIImage imageNamed:previous.icon];
    [self.footerMenu setTotalTime:player.duration];
    
    //播放音乐，将btn设置为选中
    [self.footerMenu setBtnSelected:YES];
}

- (void)sliderBeginChange
{
    [self removeProgressTimer];
    
}

- (void)sliderEndChange:(NSTimeInterval)endTime
{
    [self removeProgressTimer];
    
    AVAudioPlayer *currentPlayer = [YHMusicPlayTool getCurrentPlayer];
    
    currentPlayer.currentTime = endTime;
    
    
    if (!currentPlayer.isPlaying && currentPlayer != nil) {
        [self addProgressTimer];
        [currentPlayer play];
        [self.footerMenu setBtnSelected:YES];
    }else if (currentPlayer != nil && currentPlayer.isPlaying){
        [self addProgressTimer];
    }
    
   
    
}


#pragma mark - 懒加载
- (YHBackgroundAlbumView *)albumView
{
    if (!_albumView) {
        _albumView = [[YHBackgroundAlbumView alloc]init];
    }
    return _albumView;
}
- (YHHeaderMenu *)headerMenu
{
    if (!_headerMenu) {
        _headerMenu = [[YHHeaderMenu alloc]init];
    }
    return _headerMenu;
}

- (YHFooterMenu *)footerMenu
{
    if (!_footerMenu) {
        _footerMenu = [[YHFooterMenu alloc]init];
        _footerMenu.delegate = self;
    }
    return _footerMenu;
}

@end
