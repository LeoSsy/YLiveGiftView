//
//  YChanelView.h
//  YLiveGiftView
//
//  Created by shusy on 2017/12/15.
//  Copyright © 2017年 杭州爱卿科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,YChanelViewStatusType){
    YChanelViewStatusIdel,  //闲置状态
    YChanelViewStatusAnimating, //动画执行中
    YChanelViewStatusWillEnd, //将要结束动画状态
    YChanelViewStatusEnd //结束动画状态
};

@class YGiftModel,YChanelView;

typedef void(^completionn)(YChanelView *view); //将自己传出去可以方便直接使用

@interface YChanelView : UIView
/** 礼物模型*/
@property(nonatomic,strong)YGiftModel *giftModel; //动画执行完成之后的回调
@property(nonatomic,assign)YChanelViewStatusType status; //当前的状态
@property(nonatomic,strong)completionn completionn; //动画执行完成之后的回调

/**
 展示动画
 */
- (void)showAnimation;
/**
 销毁动画
 */
- (void)dismissAnimation;
/**
 如果连续点击的话 添加到等待队列中
 */
- (void)addToWaitingQueue;
@end
