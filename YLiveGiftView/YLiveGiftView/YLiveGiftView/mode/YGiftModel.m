//
//  YGiftModel.m
//  YLiveGiftView
//
//  Created by shusy on 2017/12/18.
//  Copyright © 2017年 杭州爱卿科技. All rights reserved.
//

#import "YGiftModel.h"

@implementation YGiftModel

- (instancetype)initWithName:(NSString*)userName iconUrl:(NSString*)iconUrl giftName:(NSString*)giftName giftUrl:(NSString*)giftUrl desc:(NSString*)desc {
    if (self = [super init]) {
        self.userName = userName;
        self.iconUrl = iconUrl;
        self.giftName = giftName;
        self.giftUrl = giftUrl;
        self.desc = desc;
    }
    return self;
}

- (instancetype)initWithName:(NSString*)userName iconName:(NSString*)iconName giftName:(NSString*)giftName giftIcon:(NSString*)giftIcon desc:(NSString*)desc{
    if (self = [super init]) {
        self.userName = userName;
        self.iconName = iconName;
        self.giftName = giftName;
        self.giftIcon = giftIcon;
        self.desc = desc;
    }
    return self;
}

- (BOOL)isEqual:(id)object {
    if (object) {
        YGiftModel *model = (YGiftModel*)object;
        if ([self.giftName isEqualToString:model.giftName] && [self.userName isEqualToString:model.userName]) {
            return true;
        }else{
            return false;
        }
    }else{
        return false;
    }
}

@end
