//
//  YHMusicModel.h
//  QQ音乐
//
//  Created by bot on 16/6/26.
//  Copyright © 2016年 bot. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YHMusicModel : NSObject
/**
 * 歌曲名称
 */
@property (copy,nonatomic) NSString *name;
/**
 * 文件名
 */
@property (copy,nonatomic) NSString *filename;
/**
 * 歌词文件名
 */
@property (copy,nonatomic) NSString *lrcname;
/**
 * 歌手名
 */
@property (copy,nonatomic) NSString *singer;
/**
 * 歌曲icon
 */
@property (copy,nonatomic) NSString *icon;

@end
