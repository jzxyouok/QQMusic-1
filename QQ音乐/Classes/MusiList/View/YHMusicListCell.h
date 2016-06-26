//
//  YHMusicListCell.h
//  QQ音乐
//
//  Created by bot on 16/6/26.
//  Copyright © 2016年 bot. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHMusicModel;
@interface YHMusicListCell : UITableViewCell

@property (strong,nonatomic) YHMusicModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
