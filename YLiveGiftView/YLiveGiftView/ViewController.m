//
//  ViewController.m
//  YLiveGiftView
//
//  Created by shusy on 2017/12/15.
//  Copyright © 2017年 杭州爱卿科技. All rights reserved.
//

#import "ViewController.h"
#import "YLiveGiftView.h"
#import "YGiftModel.h"

@interface ViewController ()
@property(nonatomic,strong)YLiveGiftView *giftView;
@property(nonatomic,strong)NSMutableArray *gifts;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _giftView = [[YLiveGiftView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 300)];
    [self.view addSubview:_giftView];
    
    _gifts = [NSMutableArray array];
    for (int i = 1 ; i< 19 ; i++) {
        [_gifts addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
}

- (IBAction)gift1:(id)sender {
    
    YGiftModel *mode = [[YGiftModel alloc] initWithName:@"萧艾敷荣" iconName:@"2" giftName:@"跑车" giftIcon:self.gifts[arc4random_uniform(17)] desc:@"萧艾敷荣 送出礼物"];
    [self.giftView showGiftViewWithMode:mode];
}

- (IBAction)gift2:(id)sender {
    YGiftModel *mode = [[YGiftModel alloc] initWithName:@"萧艾敷荣123" iconName:@"123" giftName:@"飞机" giftIcon:self.gifts[arc4random_uniform(17)] desc:@"萧艾敷荣 送出礼物"];
    [self.giftView showGiftViewWithMode:mode];
}

- (IBAction)gift3:(id)sender {
    YGiftModel *mode = [[YGiftModel alloc] initWithName:@"嘎嘎萧艾敷荣" iconName:@"2" giftName:@"火箭" giftIcon:self.gifts[arc4random_uniform(17)] desc:@"萧艾敷荣 送出礼物"];
    [self.giftView showGiftViewWithMode:mode];
}


@end
