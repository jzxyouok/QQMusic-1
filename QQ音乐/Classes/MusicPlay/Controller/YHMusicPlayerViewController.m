//
//  YHMusicPlayerViewController.m
//  QQ音乐
//
//  Created by bot on 16/6/26.
//  Copyright © 2016年 bot. All rights reserved.
//

#import "YHMusicPlayerViewController.h"
#import "YHBackgroundAlbumView.h"

@interface YHMusicPlayerViewController ()

@property (weak,nonatomic) YHBackgroundAlbumView * albumView;

@end

@implementation YHMusicPlayerViewController

#pragma mark - view生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupUI];
}



#pragma mark - 配置UI
- (void)setupUI
{
    YHBackgroundAlbumView *bgAlbum = [[YHBackgroundAlbumView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:bgAlbum];
    _albumView = bgAlbum;
}

- (void)play
{
 
}

- (void)pause
{
   
}

- (void)next
{
    
}

- (void)last
{
   
}












@end
