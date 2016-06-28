//
//  YHNavigationViewController.m
//  QQ音乐
//
//  Created by bot on 16/6/26.
//  Copyright © 2016年 bot. All rights reserved.
//

#import "YHNavigationViewController.h"
#import "YHMusicPlayerViewController.h"

@interface YHNavigationViewController ()

@end

@implementation YHNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    self.navigationBar.shadowImage = [UIImage new];
    self.navigationBar.backgroundColor = [UIColor clearColor];
    self.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    
    [super pushViewController:viewController animated:animated];
}




@end
