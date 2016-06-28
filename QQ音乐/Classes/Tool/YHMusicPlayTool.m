//
//  YHMusicPlayTool.m
//  QQ音乐
//
//  Created by bot on 16/6/26.
//  Copyright © 2016年 bot. All rights reserved.
//

#import "YHMusicPlayTool.h"
#import "MJExtension.h"
#import "YHMusicModel.h"
#import "YHTimeIntervalTool.h"
#import "YHMusicDataTool.h"

static NSMutableDictionary *_songs;
@implementation YHMusicPlayTool

+ (void)initialize
{
    _songs = [NSMutableDictionary dictionary];
}


/**
 * 播放制定音乐
 */
+ (void)playMusicWithModel:(YHMusicModel *)model
{
    
    AVAudioPlayer *player = _songs[model.name];
    if (player == nil) {
        NSURL *songUrl = [[NSBundle mainBundle] URLForResource:model.filename withExtension:nil];
        player = [[AVAudioPlayer alloc]initWithContentsOfURL:songUrl error:nil];
        _songs[model.name] = player;
        [YHMusicDataTool setCurrentMusicWith:model];
        
    }
    [player prepareToPlay];
    [player play];
    
    //播放音乐同时发出通知
//    [YHNotificationCenter postNotificationName:YHPlayNotification object:self];
}
/**
 * 暂停指定文件名音乐
 */
+ (void)pauseMusicWithModel:(YHMusicModel *)model
{
    
    AVAudioPlayer *player = _songs[model.name];
    if (!player) return;
    [player pause];
}


/**
 * 停止播放音乐
 */
+ (void)stopPlayingMusicWithModel:(YHMusicModel *)model
{

    AVAudioPlayer *current = _songs[model.name];
    [current stop];
    [_songs removeObjectForKey:model.name];
    current = nil;
    [YHMusicDataTool setCurrentMusicWith:nil];
}
@end
