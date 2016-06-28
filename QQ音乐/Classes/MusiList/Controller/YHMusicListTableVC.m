//
//  YHMusicListTableVC.m
//  QQ音乐
//
//  Created by bot on 16/6/26.
//  Copyright © 2016年 bot. All rights reserved.
//

#import "YHMusicListTableVC.h"
#import "YHTopBackgroundImageView.h"
#import "YHMusicPlayTool.h"
#import "YHMusicDataTool.h"
#import "YHMusicModel.h"
#import "YHMusicListCell.h"
#import "YHMusicPlayerViewController.h"


CGFloat const YHTopBgImageHeight = 350;
CGFloat const YHTopCoveredHeight  = 90;
CGFloat const YHTableViewInset = YHTopBgImageHeight - YHTopCoveredHeight;

@interface YHMusicListTableVC ()

@property (weak,nonatomic) YHTopBackgroundImageView * topBgImageView;
@property (strong,nonatomic) YHMusicPlayerViewController * playingVC;

@end

@implementation YHMusicListTableVC

#pragma mark - view生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}


//设置UI
- (void)setupUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.contentInset = UIEdgeInsetsMake(YHTableViewInset, 0, 0, 0);
    
    YHTopBackgroundImageView *topImageView = [[YHTopBackgroundImageView alloc]initWithFrame:CGRectMake(0,-YHTopBgImageHeight, self.view.width, YHTopBgImageHeight)];
    _topBgImageView = topImageView;
    [self.view insertSubview:topImageView atIndex:0];
}

#pragma mark - UITableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [YHMusicDataTool allMusics].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YHMusicListCell *cell = [YHMusicListCell cellWithTableView:tableView];
    cell.model = [YHMusicDataTool allMusics][indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    YHMusicModel *model = [YHMusicDataTool allMusics][indexPath.row];
    [YHMusicDataTool setCurrentMusicWith:model];
    
    
    [self.playingVC show];

}



#pragma mark - UIScorllView 代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat down = - YHTableViewInset - offsetY;
    
    CGFloat maxDownDistance = 250;
    CGFloat scaleW = down * 0.6 / maxDownDistance + 1;
    CGFloat scaleH = down  / maxDownDistance + 1;
    
    if (down < 0) {
        return;
    }
    _topBgImageView.transform = CGAffineTransformMakeScale(scaleW, scaleH);
}

#pragma mark - 懒加载
- (YHMusicPlayerViewController *)playingVC
{
    if (!_playingVC) {
        _playingVC = [[YHMusicPlayerViewController alloc]init];
    }
    return _playingVC;
}



@end
