//
//  YHMusicDataTool.h
//  QQ音乐
//
//  Created by bot on 16/6/28.
//  Copyright © 2016年 bot. All rights reserved.
//

#import <Foundation/Foundation.h>


@class YHMusicModel;
@interface YHMusicDataTool : NSObject

+ (NSArray *)allMusics;

+ (void)setCurrentMusicWith:(YHMusicModel *)model;
+ (YHMusicModel *)getCurrentMusic;
+ (YHMusicModel *)nextMusic;
+ (YHMusicModel *)previousMusic;



@end
