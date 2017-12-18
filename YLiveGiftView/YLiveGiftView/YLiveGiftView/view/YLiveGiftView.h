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
 显示礼物视图
 */
- (void)showGiftViewWithMode:(YGiftModel*)mode;

@end
