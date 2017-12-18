//
//  YChanelView.m
//  YLiveGiftView
//
//  Created by shusy on 2017/12/15.
//  Copyright © 2017年 杭州爱卿科技. All rights reserved.
//

#import "YChanelView.h"
#import "YGiftLabel.h"
#import "YGiftModel.h"

@interface YChanelView()
//视图
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)UIImageView *iconImageV;
@property(nonatomic,strong)UILabel *nameL;
@property(nonatomic,strong)UILabel *descL;
@property(nonatomic,strong)UIImageView *tailImageV;
@property(nonatomic,strong)YGiftLabel *numberL;
//辅助属性
@property(nonatomic,assign)NSInteger currentNum; //当前礼物的数目
@property(nonatomic,assign)NSInteger waitingNum; //等待执行的礼物次数
@end

@implementation YChanelView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.currentNum = 0;
        self.waitingNum = 0;
        
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self addSubview:_contentView];
        
        _iconImageV = [[UIImageView alloc] init];
        _iconImageV.backgroundColor = [UIColor lightGrayColor];
        _iconImageV.clipsToBounds = YES;
        _iconImageV.image = [UIImage imageNamed:@"Easy"];
        [self addSubview:_iconImageV];
        
        _nameL = [[UILabel alloc] init];
        _nameL.text = @"移花接木哈哈";
        _nameL.font = [UIFont systemFontOfSize:12];
        _nameL.textColor = [UIColor whiteColor];
        [self addSubview:_nameL];
        
        _descL = [[UILabel alloc] init];
        _descL.text = @"hong 送出礼物🎁";
        _descL.font = [UIFont systemFontOfSize:12];
        _descL.textColor = [UIColor orangeColor];
        [self addSubview:_descL];
        
        
        _tailImageV = [[UIImageView alloc] init];
        _tailImageV.contentMode = UIViewContentModeScaleAspectFit;
        _tailImageV.image = [UIImage imageNamed:@"prop_b"];
        [self addSubview:_tailImageV];
        
        _numberL = [[YGiftLabel alloc] init];
        _numberL.text = @" x 1 ";
        _numberL.font = [UIFont systemFontOfSize:22];
        _numberL.textColor = [UIColor whiteColor];
        [self addSubview:_numberL];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    CGFloat margin  = 5;
    CGFloat numberW = 80;
    _numberL.preferredMaxLayoutWidth = numberW;
    [_numberL sizeToFit];
    _numberL.frame = CGRectMake(width-numberW, 0, _numberL.frame.size.width, height);
    
    _contentView.frame = CGRectMake(0, 0, width-numberW-20, height);
    _contentView.layer.cornerRadius = height*0.5;
    
    _iconImageV.frame = CGRectMake(0, 0, height, height);
    _iconImageV.layer.cornerRadius = height*0.5;
    
    CGFloat tailImageW = 50;
    _tailImageV.frame = CGRectMake(width-numberW-tailImageW-25, 0, tailImageW, height);
    
    CGFloat nameX =  CGRectGetMaxX(_iconImageV.frame)+margin;
    CGFloat nameY =  margin;
    CGFloat nameW = _contentView.frame.size.width - nameX - tailImageW;
    CGFloat nameH = 20;
    _nameL.frame = CGRectMake(nameX, nameY, nameW, nameH);
    _descL.frame = CGRectMake(nameX, height - margin-nameH, nameW, nameH);
}

/**
 设置数据
 */
- (void)setGiftModel:(YGiftModel *)giftModel{
    if (giftModel==nil) { return; }
    _giftModel = giftModel;
    self.nameL.text = giftModel.userName;
    self.iconImageV.image = [UIImage imageNamed:giftModel.iconName];
    self.tailImageV.image = [UIImage imageNamed:giftModel.giftIcon];
    self.descL.text = giftModel.desc;
    [self showAnimation];
}

/**
 如果连续点击的话 添加到等待队列中
 */
- (void)addToWaitingQueue {
    if (self.status == YChanelViewStatusWillEnd) {
        //连续点击 取消上一次的操作
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [self numberAnimation];
    }else{
        self.waitingNum++;
    }
}

/**
 展示动画
 */
- (void)showAnimation {
    CGRect frame = self.frame;
    frame.origin.x = 0;
    _numberL.text = @" x 1 ";
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1.0;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self numberAnimation];
    }];
}

/**
 展示数字放大动画
 */
- (void)numberAnimation{
    self.currentNum ++;
    self.numberL.text = [NSString stringWithFormat:@" x %zd ",self.currentNum];
    __weak typeof(self) weakSelf = self;
    [self.numberL startAnimation:^(BOOL finished) {
        if (weakSelf.waitingNum > 0 ) {
            weakSelf.waitingNum --;
            [weakSelf  numberAnimation];
        }else{
            //这里首先不能盲目的马上销毁动画 因为很有可能 正在执行最后一次的动画 因为最后一次动画执行完之后 模型为清空 所以 这里通过模型判断当前的最后一次动画是否执行完毕
            if (weakSelf.giftModel != nil) {
                //最有一次动画执行 设置状态为将要结束
                weakSelf.status = YChanelViewStatusWillEnd;
                [weakSelf performSelector:@selector(dismissAnimation) withObject:self afterDelay:3.0];
            }else{
                [weakSelf dismissAnimation];
            }
        }
    }];
}

/**
 销毁动画
 */
- (void)dismissAnimation {
    //如果动画还没有结束就不执行
    if (self.status != YChanelViewStatusWillEnd) {return;}
    //设置状态为结束状体
    self.status = YChanelViewStatusEnd;
    //修改frame
    CGRect frame = self.frame;
    frame.origin.x = [UIScreen mainScreen].bounds.size.width;
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = frame;
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        CGRect frame = self.frame;
        frame.origin.x = -[UIScreen mainScreen].bounds.size.width;
        self.frame = frame;
        self.status = YChanelViewStatusIdel;
        self.currentNum = 0;
        self.waitingNum = 0;
        self.giftModel = nil;
        //执行回调
        if (self.completionn) {
            self.completionn(self);
        }
    }];
}

@end
