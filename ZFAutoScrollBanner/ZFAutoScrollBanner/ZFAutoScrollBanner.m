//
//  ZFAutoScrollBanner.m
//  HaiNiu
//
//  Created by 张帆 on 2018/12/12.
//  Copyright © 2018 张帆. All rights reserved.
//

#import "ZFAutoScrollBanner.h"
#import <Masonry.h>

@implementation ZFAutoBannerItem
- (instancetype)initWithName:(NSString *)name percent:(float)percent price:(float)price {

    self = [super init];
    if (self) {
        _name = name;
        _currentPercent = percent;
        _currentPrice = price;
    }
    return self;
    
}

@end

@interface ZFAutoBannerItemView ()
@property (nonatomic, strong) UIButton *button;
@end

@implementation ZFAutoBannerItemView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleLabel = ({
            UILabel *label = [[UILabel alloc] init];
            [label setFont:[UIFont systemFontOfSize:15]];
            [self addSubview:label];
            [label setTextColor:[UIColor blackColor]];
            [label setText:@"-/-"];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self).offset(20);
                make.centerY.mas_equalTo(self);
            }];
            label;
        });
        self.percentLabel = ({
            UILabel *label = [[UILabel alloc] init];
            [label setFont:[UIFont systemFontOfSize:13]];
            [self addSubview:label];
            [label setTextColor:[UIColor grayColor]];
            [label setText:@"0.000"];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self).offset(-25);
                make.centerY.mas_equalTo(self.titleLabel);
            }];
            label;
        });
        self.indexLabel = ({
            UILabel *label = [[UILabel alloc] init];
            [label setFont:[UIFont systemFontOfSize:13]];
            [self addSubview:label];
            [label setTextColor:[UIColor grayColor]];
            [label setText:@"0.00%"];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.percentLabel.mas_left).offset(-35);
                make.centerY.mas_equalTo(self.percentLabel);
            }];
            label;
        });
    }
    return self;
}

- (void)setItem:(ZFAutoBannerItem *)item {
    _item = item;
    [self.titleLabel setText:item.name];
    [self.indexLabel setText:[NSString stringWithFormat:@"%.2f", item.currentPrice]];
    [self.percentLabel setText:[NSString stringWithFormat:@"%.2f%%", item.currentPercent]];
    UIColor *currentColor = nil;
    
    if (item.currentPercent < 0) {
        currentColor = UIColor.greenColor;
    } else if (item.currentPercent > 0) {
        currentColor = UIColor.redColor;
    } else {
        currentColor = UIColor.grayColor;
    }
    
    [self.indexLabel setTextColor:currentColor];
    [self.percentLabel setTextColor:currentColor];
}
@end

@interface ZFAutoScrollBanner ()
@property (nonatomic, strong) ZFAutoBannerItemView *banner0;
@property (nonatomic, strong) ZFAutoBannerItemView *banner1;
@property (nonatomic, strong) NSTimer *tiemr;
@property (nonatomic, assign) BOOL flag;
@property (nonatomic, assign) int index;

@end

@implementation ZFAutoScrollBanner

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.layer.masksToBounds = YES;
        self.banner0 = ({
            ZFAutoBannerItemView *banner = [[ZFAutoBannerItemView alloc] init];
            [self addSubview:banner];
            banner.titleLabel.text = @"1";
            banner;
        });
        self.banner1 = ({
            ZFAutoBannerItemView *banner = [[ZFAutoBannerItemView alloc] init];
            [self addSubview:banner];
            banner.titleLabel.text = @"2";
            banner;
        });
        
        [self makeConstraints];
        
        self.tiemr = ({
            NSTimer *timer = [[NSTimer alloc] initWithFireDate:[NSDate date] interval:3.0 target:self selector:@selector(scroll) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
            timer;
        });
    }
    return self;
}

- (void)setDataArr:(NSArray *)dataArr {
    _dataArr = dataArr;
    [self configBannerItemsIndex:0];
}

- (void)scroll {

    self.index++;
    if (self.index == self.dataArr.count) {
        self.index = 0;
    }

    [self configBannerItemsIndex:self.index];
    
    [UIView animateWithDuration:.3 animations:^{
        [self.banner0 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(-30);
        }];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.flag = !self.flag;
        ZFAutoBannerItemView *temp = self.banner1;
        self.banner1 = self.banner0;
        self.banner0 = temp;
        [self makeConstraints];
    }];
}

- (void)configBannerItemsIndex:(int)index{
    self.banner0.item = _dataArr[index];
    
    int nextIndex = (index + 1);
    if (nextIndex == _dataArr.count) {
        nextIndex = 0;
    }
    
    if (self.dataArr.count >=2) {
        self.banner1.item = _dataArr[nextIndex];
    }
}

- (void)makeConstraints {
    CGFloat w = 30;
    [self.banner0 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.height.mas_equalTo(w);
    }];
    [self.banner1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self.banner0.mas_bottom);
        make.height.mas_equalTo(w);
    }];
}

@end
