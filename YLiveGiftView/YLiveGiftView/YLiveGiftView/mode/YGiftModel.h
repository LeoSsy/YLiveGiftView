//
//  YGiftModel.h
//  YLiveGiftView
//
//  Created by shusy on 2017/12/18.
//  Copyright © 2017年 杭州爱卿科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YGiftModel : NSObject
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *desc;
@property(nonatomic,strong)NSString *iconUrl;
@property(nonatomic,strong)NSString *iconName;
@property(nonatomic,strong)NSString *giftName;
@property(nonatomic,strong)NSString *giftUrl;
@property(nonatomic,strong)NSString *giftIcon;

- (instancetype)initWithName:(NSString*)userName iconUrl:(NSString*)iconUrl giftName:(NSString*)giftName giftUrl:(NSString*)giftUrl desc:(NSString*)desc;

- (instancetype)initWithName:(NSString*)userName iconName:(NSString*)iconName giftName:(NSString*)giftName giftIcon:(NSString*)giftIcon desc:(NSString*)desc;

- (BOOL)isEqual:(id)object;

@end
