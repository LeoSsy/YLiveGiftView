//
//  YGiftLabel.h
//  YLiveGiftView
//
//  Created by shusy on 2017/12/15.
//  Copyright © 2017年 杭州爱卿科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^completion)(BOOL finished);
@interface YGiftLabel : UILabel

/**
 开始动画
 @param completion 动画结束后的回调
 */
- (void)startAnimation:(completion) completion;
@end
