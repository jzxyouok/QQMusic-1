//
//  YHMusicPlayerViewController.m
//  QQ音乐
//
//  Created by bot on 16/6/26.
//  Copyright © 2016年 bot. All rights reserved.
//

#import "YHMusicPlayerViewController.h"
#import "YHBackgroundAlbumView.h"
#import "YHMusicPlayTool.h"
#import "YHMusicModel.h"

@interface YHMusicPlayerViewController ()

@property (copy,nonatomic) void(^delayExecuteBlock)(YHMusicModel *model);

@end

@implementation YHMusicPlayerViewController

#pragma mark - view生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupUI];
    
    [YHNotificationCenter addObserver:self selector:@selector(play) name:YHPlayNotification object:nil];
    [YHNotificationCenter addObserver:self selector:@selector(pause) name:YHPauseNotificaiton object:nil];
    [YHNotificationCenter addObserver:self selector:@selector(last) name:YHLastSongNotification object:nil];
    [YHNotificationCenter addObserver:self selector:@selector(next) name:YHNextSongNotificaiton object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [YHNotificationCenter removeObserver:self name:YHPlayNotification object:nil];
    [YHNotificationCenter removeObserver:self name:YHPauseNotificaiton object:nil];
    [YHNotificationCenter removeObserver:self name:YHLastSongNotification object:nil];
    [YHNotificationCenter removeObserver:self name:YHNextSongNotificaiton object:nil];
}

#pragma mark - 设置播放数据
- (void)setModel:(YHMusicModel *)model
{
    _model = model;
    
    //这一段代码要放到开始按钮加载完后调用，因为播放音乐会发出通知，若按钮没加载完，则无法接收到通知
    typeof(self) WeakSelf = self;
    self.delayExecuteBlock = ^(YHMusicModel *model){

        //进入这个if,代表两次点击了相同的cell
        if ([YHMusicPlayTool currentModel] != nil && [[YHMusicPlayTool currentModel].name isEqualToString:WeakSelf.model.name]) {
            
            //判断上次退出时有没有暂停播放
            if (![YHMusicPlayTool isCurrentModelPause]) {
                //如果上次播放时没有暂停播放，那么设置播放按钮为选中状态
                [YHNotificationCenter postNotificationName:YHPlayNotification object:WeakSelf];
            }
            //不管上次有没有暂停播放，只要两次点击了相同的cell,那么就不执行下面的代码
            return;
        }
        //如果执行到这，代表点击的是不同的cell,先判断当前是否正在播放音乐，如果是，那么直接停掉。
        if ([YHMusicPlayTool currentModel] != nil) {
            [YHMusicPlayTool stopCurrentPlayingMusic];
        }
        //如果执行到这里，代表两次点击的是不同的cell,并且已经上次播放的音乐停掉，那么开始播放这个cell的音乐
        [YHMusicPlayTool playMusicWithModel:WeakSelf.model];
    };
}

#pragma mark - 配置UI
- (void)setupUI
{
    YHBackgroundAlbumView *bgAlbum = [[YHBackgroundAlbumView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:bgAlbum];
    
    
    self.delayExecuteBlock(_model);
}

- (void)play
{
    [YHMusicPlayTool playCurrentMusic];
}

- (void)pause
{
    [YHMusicPlayTool pauseCurrentPlayingMusic];
}

- (void)next
{
    NSLog(@"nextSong");
}

- (void)last
{
    NSLog(@"lastSong");
}







@end
