//
//  YHMusicPlayTool.m
//  QQ音乐
//
//  Created by bot on 16/6/26.
//  Copyright © 2016年 bot. All rights reserved.
//

#import "YHMusicPlayTool.h"
#import "YHMusicModel.h"
#import "YHMusicDataTool.h"

static NSMutableDictionary *_songs;
@implementation YHMusicPlayTool

+ (void)initialize
{
    _songs = [NSMutableDictionary dictionary];
}

+ (AVAudioPlayer *)getCurrentPlayer
{
    YHMusicModel *current = [YHMusicDataTool getCurrentMusic];
    
    AVAudioPlayer *player = _songs[current.name];
    
    return player;
}


/**
 * 播放制定音乐
 */
+ (AVAudioPlayer *)playMusicWithModel:(YHMusicModel *)model
{
    
    AVAudioPlayer *player = _songs[model.name];
    if (player == nil) {
        NSURL *songUrl = [[NSBundle mainBundle] URLForResource:model.filename withExtension:nil];
        player = [[AVAudioPlayer alloc]initWithContentsOfURL:songUrl error:nil];
        _songs[model.name] = player;
    }
    
    [player prepareToPlay];
    [player play];
    
    return player;
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
    if (model == nil) return;
    
    AVAudioPlayer *current = _songs[model.name];
    [current stop];
    [_songs removeObjectForKey:model.name];
    current = nil;
}
@end
