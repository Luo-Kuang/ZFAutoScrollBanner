//
//  ViewController.m
//  ZFAutoScrollBanner
//
//  Created by 张帆 on 2018/12/13.
//  Copyright © 2018 张帆. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "ZFAutoScrollBanner/ZFAutoScrollBanner.h"

@interface ViewController ()
@property (nonatomic, strong) ZFAutoScrollBanner *banner;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.banner = ({
        ZFAutoScrollBanner *banner = [[ZFAutoScrollBanner alloc] init];
        [self.view addSubview:banner];
        [banner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view);
            make.right.mas_equalTo(self.view);
            make.centerY.mas_equalTo(self.view);
            make.height.mas_equalTo(30);
        }];
        banner.dataArr = [self demoArr];
        banner;
    });
    
}
- (NSArray *)demoArr {
    NSArray *arr = @[
                     [ZFAutoBannerItem.alloc initWithName:@"test1" percent:10 price:3131],
                     [ZFAutoBannerItem.alloc initWithName:@"test2" percent:-0.5 price:2324],
                     [ZFAutoBannerItem.alloc initWithName:@"test3" percent:-4.2 price:444],
                     
                     ];
    return arr;
}

@end
