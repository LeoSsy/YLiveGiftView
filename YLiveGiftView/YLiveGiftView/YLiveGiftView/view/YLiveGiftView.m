//
//  YLiveGiftView.m
//  YLiveGiftView
//
//  Created by shusy on 2017/12/15.
//  Copyright © 2017年 杭州爱卿科技. All rights reserved.
//

#import "YLiveGiftView.h"
#import "YGiftLabel.h"
#import "YChanelView.h"
#import "YGiftModel.h"

#define giftViewShowNum 2 //最多显示多少个礼物视图
#define giftViewHeight 45 //礼物视图的高度
#define giftViewMargin 10 //间距

@interface YLiveGiftView()
@property(nonatomic,strong)NSMutableArray *chanelViews;
@property(nonatomic,strong)NSMutableArray *caches;
@end

@implementation YLiveGiftView

- (NSMutableArray *)chanelViews {
    if (!_chanelViews) {
        _chanelViews = [NSMutableArray array];
    }
    return _chanelViews;
}

- (NSMutableArray *)caches {
    if (!_caches) {
        _caches = [NSMutableArray array];
    }
    return _caches;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

/**
 显示礼物视图
 */
- (void)showGiftViewWithMode:(YGiftModel*)mode {
    //首先判断是否有正在显示的视图 如果已经有一样的正在显示的视图 就将当前的操作加入缓存
    YChanelView *chanelView = [self checkUsingChanelView:mode];
    if (chanelView != nil) {
        //将当前礼物视图的执行此时加1
        [chanelView addToWaitingQueue];
        return;
    }
    //再检查是否有闲置的视图 如果有就只将礼物模型交给当前闲置的礼物视图即可
    YChanelView *idelChanelView = [self checkIdelChanelView];
    if (idelChanelView != nil) {
        idelChanelView.giftModel = mode;
        return;
    }
    //上面两种情形都没有 就加入缓存中
    [self.caches addObject:mode];
}

/**
 检查是否有正在显示的视图
 */
- (YChanelView*)checkUsingChanelView:(YGiftModel*)mode{
    for (YChanelView *chanelView  in self.chanelViews) {
        //如果状态不是闲置状态 同时内部的模型是同一个模型
        if (chanelView.status!=YChanelViewStatusIdel && [chanelView.giftModel isEqual:mode] ) {
            return chanelView;
        }
    }
    return nil;
}


/**
 检查是否有闲置的视图
 */
- (YChanelView*)checkIdelChanelView{
    for (YChanelView *chanelView  in self.chanelViews) {
        //如果状态不是闲置状态 同时内部的模型是同一个模型
        if (chanelView.status==YChanelViewStatusIdel) {
            return chanelView;
        }
    }
    return nil;
}

/**
 初始化
 */
- (void)setup{
    CGFloat y = giftViewMargin;
    CGFloat width = self.bounds.size.width*0.85;
    for (int i = 0 ; i < giftViewShowNum ; i++) {
        YChanelView *chanelView = [[YChanelView alloc] init];
        chanelView.frame = CGRectMake(-[UIScreen mainScreen].bounds.size.width, y, width, giftViewHeight);
        [self addSubview:chanelView];
        y+= giftViewHeight + giftViewMargin;
        [self.chanelViews addObject:chanelView];
        //监听chanelView的动画完成回调
        __weak typeof(self)weakSelf = self;
        chanelView.completionn = ^(YChanelView *view) {
            //执行完成后 继续去缓存中找是否有缓存
            if (weakSelf.caches.firstObject == nil) { return;}
            YGiftModel *mode = weakSelf.caches.firstObject;
            view.giftModel = mode;
            //删除已经使用的缓存
            [weakSelf.caches removeObjectAtIndex:0];
            //同时要缓存中是否存在相同的礼物模型 就将它的执行次数加1 同时删除当前位置对应的缓存
            for (int i = (int)weakSelf.caches.count - 1 ; i>= 0 ; i--) {
                YGiftModel *newModel  = weakSelf.caches[i];
                if ([mode isEqual:newModel]) {
                    [view addToWaitingQueue];
                    [self.caches removeObjectAtIndex:i];
                }
            }
        };
    }
}

@end
