//
//  YHFooterMenu.h
//  QQ音乐
//
//  Created by bot on 16/6/26.
//  Copyright © 2016年 bot. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,YHFooterMenuBtnType) {
    YHFooterMenuBtnTypeStartOrPause = 10,
    YHFooterMenuBtnTypeNextSong,
    YHFooterMenuBtnTypeLastSong
};

@protocol YHFooterMenuDelegate <NSObject>

- (void)next;
- (void)previous;
- (void)start;
- (void)pause;
- (void)sliderBeginChange;
- (void)sliderChanging;
- (void)sliderEndChange:(NSTimeInterval)endTime;

@end

@interface YHFooterMenu : UIView

@property (weak,nonatomic) id<YHFooterMenuDelegate> delegate;
- (void)setBtnSelected:(BOOL)select;
- (void)setTotalTime:(NSTimeInterval )total;
- (void)setProgressTime:(NSTimeInterval)progress;



@end
