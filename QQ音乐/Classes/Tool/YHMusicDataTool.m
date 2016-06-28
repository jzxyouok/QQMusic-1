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
static NSInteger _currentIndex;
@implementation YHMusicDataTool

+ (void)initialize
{
    _musics = [YHMusicModel objectArrayWithFile:[[NSBundle mainBundle] pathForResource:@"Musics.plist" ofType:nil]];
    _currentIndex = 0;
}

+ (NSArray *)allMusics
{
    return _musics;
}

+ (YHMusicModel *)getCurrentMusic
{
    return _musics[_currentIndex];
}

+ (void)setCurrentMusicWith:(YHMusicModel *)model
{
    if (model == nil) {
        _currentIndex = 0;
        return;
    }
    [_musics enumerateObjectsUsingBlock:^(YHMusicModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.name isEqualToString:model.name]) {
            _currentIndex = idx;
        }
    }];
}

+ (YHMusicModel *)lastMusic
{
    if (_currentIndex - 1 >= 0) {
        return _musics[_currentIndex - 1];
    }else{
        return nil;
    }
}

+ (YHMusicModel *)nextMusic
{
    if (_currentIndex + 1 <= _musics.count - 1) {
        return _musics[_currentIndex + 1];
    }else{
        return nil;
    }
}

@end
