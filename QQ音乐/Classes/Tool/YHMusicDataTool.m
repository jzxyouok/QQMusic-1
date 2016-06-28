//
//  YHMusicDataTool.m
//  QQ音乐
//
//  Created by bot on 16/6/28.
//  Copyright © 2016年 bot. All rights reserved.
//

#import "YHMusicDataTool.h"
#import "YHMusicModel.h"
#import "MJExtension.h"

static NSArray<YHMusicModel *> *_musics;
static YHMusicModel *_currentModel;
@implementation YHMusicDataTool

+ (void)initialize
{
    _musics = [YHMusicModel objectArrayWithFile:[[NSBundle mainBundle] pathForResource:@"Musics.plist" ofType:nil]];
    _currentModel = _musics[0];
}

+ (NSArray *)allMusics
{
    return _musics;
}

+ (YHMusicModel *)getCurrentMusic
{
    return _currentModel;
}

+ (void)setCurrentMusicWith:(YHMusicModel *)model
{
    if (model == nil) return;
   
    if ([_musics containsObject:model]) {
        
        _currentModel = model;
    }
    
}

+ (YHMusicModel *)nextMusic
{
    NSInteger currentIndex = [_musics indexOfObject:_currentModel];
    
    if (currentIndex >= _musics.count - 1){
        return [_musics firstObject];
    }
    
    return _musics[currentIndex + 1];
}

+ (YHMusicModel *)previousMusic
{
    NSInteger currentIndex = [_musics indexOfObject:_currentModel];
    
    if (currentIndex <= 0){
        return [_musics lastObject];
    }
    return _musics[currentIndex - 1];
}

@end
