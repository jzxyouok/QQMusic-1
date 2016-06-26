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

static NSMutableDictionary *_songs;
static NSArray *_musics;
static YHMusicModel *_currentModel;
@implementation YHMusicPlayTool

+ (void)initialize
{
    _songs = [NSMutableDictionary dictionary];
    _musics = [NSMutableArray array];
}

#pragma mark - 返回当前播放歌曲名称
/**
 * 返回当前播放歌曲的播放器
 */
+ (YHMusicModel *)currentModel
{
    return _currentModel;
}

/**
 * 返回当前的播放器是否暂停
 */
+ (BOOL)isCurrentModelPause
{
    AVAudioPlayer *current = _songs[_currentModel.name];
    
    return !current.isPlaying;
}

/**
 * 返回本地所有播放器
 */
+ (NSArray<YHMusicModel *> *)allMusicModels
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Musics.plist" ofType:nil];
    _musics = [YHMusicModel objectArrayWithFile:path];
    return _musics;
}

/**
 * 播放指定文件名音乐
 */
+ (void)playMusicWithModel:(YHMusicModel *)model
{
    _currentModel = model;
    
    AVAudioPlayer *player = _songs[model.name];
    if (!player) {
        NSURL *songUrl = [[NSBundle mainBundle] URLForResource:model.filename withExtension:nil];
        player = [[AVAudioPlayer alloc]initWithContentsOfURL:songUrl error:nil];
        _songs[model.name] = player;
        
    }
    [player prepareToPlay];
    [player play];
    
    //播放音乐同时发出通知
    [YHNotificationCenter postNotificationName:YHPlayNotification object:self];
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
 * 继续播放当前音乐
 */
+ (void)playCurrentMusic
{
    AVAudioPlayer *player = _songs[_currentModel.name];
    [player play];
}

/**
 * 暂停当前播放音乐
 */
+ (void)pauseCurrentPlayingMusic
{
    AVAudioPlayer *current = _songs[_currentModel.name];
    [current pause];
}

/**
 * 停止播放当前音乐
 */
+ (void)stopCurrentPlayingMusic
{

    AVAudioPlayer *current = _songs[_currentModel.name];
    [current stop];
    [_songs removeObjectForKey:_currentModel.name];
    current = nil;
    
    _currentModel = nil;
}
@end
