# ZFAutoScrollBanner
###  类似于淘宝头条的自动竖直滚动的Bannnnnnnner
gif图有丢帧，其实动画是连续的

![ZFAutoScrollBanner.gif](https://upload-images.jianshu.io/upload_images/12218267-237c1eca48f84ac0.gif?imageMogr2/auto-orient/strip)

核心代码
```
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

```
