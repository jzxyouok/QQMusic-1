//
//  YHMusicPlayTool.h
//  QQ音乐
//
//  Created by bot on 16/6/26.
//  Copyright © 2016年 bot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "YHMusicDataTool.h"

@class YHMusicModel;
@interface YHMusicPlayTool : NSObject


+ (void)pauseMusicWithModel:(YHMusicModel *)model;

+ (void)stopPlayingMusicWithModel:(YHMusicModel *)model;

+ (void)playMusicWithModel:(YHMusicModel *)model;


@end
