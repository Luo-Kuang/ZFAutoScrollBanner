//
//  ZFAutoScrollBanner.h
//  HaiNiu
//
//  Created by 张帆 on 2018/12/12.
//  Copyright © 2018 张帆. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN


@interface ZFAutoBannerItem : NSObject
/*
 this object just a simple for ZFAutoScrollBanner
 */
- (instancetype)initWithName:(NSString *)name percent:(float)percent price:(float)price NS_DESIGNATED_INITIALIZER;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) float currentPercent;
@property (nonatomic, assign) float currentPrice;


- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

@interface ZFAutoBannerItemView : UIView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *percentLabel;
@property (nonatomic, strong) UILabel *indexLabel;
@property (nonatomic, strong) ZFAutoBannerItem *item;
@end

@interface ZFAutoScrollBanner : UIView
@property (nonatomic, strong) NSArray *dataArr;
@end

NS_ASSUME_NONNULL_END
