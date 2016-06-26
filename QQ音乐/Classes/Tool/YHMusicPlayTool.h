//
//  YHMusicPlayTool.h
//  QQ音乐
//
//  Created by bot on 16/6/26.
//  Copyright © 2016年 bot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@class YHMusicModel;
@interface YHMusicPlayTool : NSObject

+ (NSArray<YHMusicModel *> *)allMusicModels;
//播放指定音乐
+ (void)playMusicWithModel:(YHMusicModel *)model;
//暂停指定音乐
+ (void)pauseMusicWithModel:(YHMusicModel *)model;
//返回当前播放音乐的模型
+ (YHMusicModel *)currentModel;
//返回当前的播放器是否暂停
+ (BOOL)isCurrentModelPause;
//暂停当前播放音乐
+ (void)pauseCurrentPlayingMusic;
//停止当前播放音乐
+ (void)stopCurrentPlayingMusic;
//继续播放当前音乐
+ (void)playCurrentMusic;


@end
