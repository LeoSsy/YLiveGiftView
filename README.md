# YLiveGiftView
直播页面礼物连击效果展示视图

![MacDown Screenshot](./gift.gif)

使用方法：
###### 首先创建礼物视图：
``` objc
_giftView = [[YLiveGiftView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 300)];
[self.view addSubview:_giftView];

```
###### 在需要展示的时候调用如下方法：
``` objc

YGiftModel *mode = [[YGiftModel alloc] initWithName:@"萧艾敷荣" iconName:@"2" giftName:@"跑车" giftIcon:@“car” desc:@"萧艾敷荣 送出礼物"];
[self.giftView showGiftViewWithMode:mode];

```




