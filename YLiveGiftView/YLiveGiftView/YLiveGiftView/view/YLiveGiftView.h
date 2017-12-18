//
//  YLiveGiftView.h
//  YLiveGiftView
//
//  Created by shusy on 2017/12/15.
//  Copyright © 2017年 杭州爱卿科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YGiftModel;

@interface YLiveGiftView : UIView
/**
 页面展示多少个礼物弹出框
 */
@property(nonatomic,assign)NSInteger displayNum;
/**
 初始化方法
 @param frame frame
 @param num 显示弹出框个数
 @return YLiveGiftView
 */
- (instancetype)initWithFrame:(CGRect)frame displayNum:(NSInteger)num;
/**
 显示礼物视图
 */
- (void)showGiftViewWithMode:(YGiftModel*)mode;

@end
