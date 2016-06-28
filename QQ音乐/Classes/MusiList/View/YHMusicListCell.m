//
//  YHMusicListCell.m
//  QQ音乐
//
//  Created by bot on 16/6/26.
//  Copyright © 2016年 bot. All rights reserved.
//

#import "YHMusicListCell.h"
#import "YHMusicModel.h"

@interface YHMusicListCell ()

@property (weak,nonatomic) UIView * playingIndictorView;
@property (weak,nonatomic) UIImageView * operationIndictorView;
@property (weak,nonatomic) UILabel * musicNameLabel;
@property (weak,nonatomic) UILabel * singerNameLabel;

@end

@implementation YHMusicListCell

#pragma mark - 初始化
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"Cell";
    YHMusicListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YHMusicListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}
#pragma mark - 配置UI
- (void)setupUI
{
    //右边操作指示view
    UIImageView *right = [[UIImageView alloc]init];
    right.image = [UIImage imageNamed:@"miniplayer_btn_playlist_close"];
    [self.contentView addSubview:right];
    _operationIndictorView = right;
    
    //是否正在播放的指示view
    UIView *indicator = [[UIView alloc]init];
    indicator.backgroundColor = [UIColor greenColor];
    indicator.hidden = YES;
    [self.contentView addSubview:indicator];
    _playingIndictorView = indicator;
    
    //歌曲名
    UILabel *music = [[UILabel alloc]init];
//    music.backgroundColor = [UIColor purpleColor];
    music.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:music];
    _musicNameLabel = music;
    
    //歌手名
    UILabel *singer = [[UILabel alloc]init];
//    singer.backgroundColor = [UIColor yellowColor];
    singer.font = [UIFont systemFontOfSize:13];
    singer.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:singer];
    _singerNameLabel = singer;
}

- (void)setModel:(YHMusicModel *)model
{
    _model = model;
    _musicNameLabel.text = model.name;
    _singerNameLabel.text = model.singer;

}



#pragma mark - 布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat margin = 10;
    
    //是否正在播放指示view
    CGFloat playingIndicatoerMargin = 0;
    _playingIndictorView.frame = (CGRect){0,playingIndicatoerMargin,10,self.contentView.height - 2 * playingIndicatoerMargin};
    
    //歌曲名
    _musicNameLabel.frame = (CGRect){_playingIndictorView.maxX + margin,0,250,self.contentView.height * 0.5};
    
    //歌手名
    _singerNameLabel.frame = (CGRect) {_musicNameLabel.minX,_musicNameLabel.maxY,250,self.contentView.height * 0.4};
    
    //操作指示view
    CGFloat indictorW = 25;
    _operationIndictorView.frame = (CGRect){self.contentView.width - margin - indictorW,self.contentView.midY - indictorW * 0.5,indictorW,indictorW};
}


@end
