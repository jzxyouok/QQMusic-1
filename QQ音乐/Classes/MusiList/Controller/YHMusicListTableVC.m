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
@property (strong,nonatomic) NSArray<YHMusicModel*> *musics;

@end

@implementation YHMusicListTableVC

#pragma mark - view生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupUI];
}

#pragma mark - 初始化
//设置数据
- (void)setupData
{
    self.musics = [YHMusicDataTool allMusics];
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
    return self.musics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YHMusicListCell *cell = [YHMusicListCell cellWithTableView:tableView];
    cell.model = self.musics[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //显示正在播放的标示
    [self showIndictorWhilePlaying:indexPath];
    
    //跳转控制器
    YHMusicPlayerViewController *playerVC = [[YHMusicPlayerViewController alloc]init];
    
    playerVC.model = self.musics[indexPath.row];
    [self.navigationController pushViewController:playerVC animated:YES];
}

- (void)showIndictorWhilePlaying:(NSIndexPath *)indexPath
{
    [self.musics enumerateObjectsUsingBlock:^(YHMusicModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == indexPath.row) {
            obj.playing = YES;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            return ;
        }
        obj.playing = NO;
    }];
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



@end
