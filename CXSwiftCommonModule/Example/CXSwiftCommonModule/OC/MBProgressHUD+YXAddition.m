//
//  MBProgressHUD+YXAddition.m
//  CXMerchant
//
//  Created by zainguo on 2019/3/16.
//  Copyright © 2019年 zainguo. All rights reserved.
//

#import "MBProgressHUD+YXAddition.h"
#import "MBProgressHUD.h"

static MBProgressHUD *_HUD;


@implementation MBProgressHUD (YXAddition)


#pragma mark - Private Methods
+ (instancetype)initHudWithView:(UIView *)view {
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    // 设置等待框背景色为黑色
    HUD.bezelView.backgroundColor = [UIColor blackColor];
    // 设置文字颜色
    HUD.contentColor = [UIColor whiteColor];
    // 隐藏时候从父控件中移除
    HUD.removeFromSuperViewOnHide = YES;
    return HUD;
}

#pragma mark 显示带图片或者不带图片的信息
+ (instancetype)pm_showMessage:(NSString *)message
                          icon:(NSString *)icon
                          view:(UIView *)view {
    
    [self yx_hudDismiss];
    
    MBProgressHUD *HUD = [self initHudWithView:view];
    // 判断是否显示图片
    if (!icon) {
        HUD.mode = MBProgressHUDModeText;
        
    } else {
        // 设置图片
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]];
        img = img == nil ? [UIImage imageNamed:icon]:img;
        HUD.customView = [[UIImageView alloc] initWithImage:img];
        // 再设置模式
        HUD.mode = MBProgressHUDModeCustomView;
    }
    [HUD hideAnimated:YES afterDelay:2];
    HUD.detailsLabel.text = message;
    _HUD = HUD;
    
    return HUD;
}

/// 文字提示 显示时间为2妙
+ (instancetype)yx_showMessage:(NSString *)message {
    
    return [self pm_showMessage:message icon:nil view:nil];
}

/// 文字提示显示到指定View
+ (instancetype)yx_showMessage:(NSString *)message
                        toView:(UIView *)view {
    
    return [self pm_showMessage:message icon:nil view:view];
}

+ (instancetype)yx_showLodingWithMessage:(NSString *)message
                                  toView:(UIView *)view {
    
    [self yx_hudDismiss];
    
    MBProgressHUD *HUD = [MBProgressHUD initHudWithView:view];
    // 设置模式
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.detailsLabel.text = message;
    _HUD = HUD;
    
    return HUD;
}

/// 加载文字提示
+ (instancetype)yx_showLodingWithMessage:(NSString *)message {
    
    return [self yx_showLodingWithMessage:message toView:nil];
}

/// 显示带图片和文字
+ (instancetype)yx_showMessage:(NSString *)message
                     imageName:(NSString *)imageName
                        toView:(UIView *)view {
    
    return [self pm_showMessage:message icon:imageName view:view];
}
/// 加载提示
+ (instancetype)yx_showLoding {
    
    return [self yx_showLodingWithMessage:nil toView:nil];
}

/// 指定view加载显示loding
+ (instancetype)yx_showLodingToView:(UIView *)view {
    
    return [self yx_showLodingWithMessage:nil toView:view];
}

+ (instancetype)yx_showActivityIndicatorToView:(UIView *)view
                                       message:(NSString *)message {
    
    [self yx_hudDismiss];
    
    MBProgressHUD *HUD = [self initHudWithView:view];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.bezelView.backgroundColor = [UIColor clearColor];
    HUD.contentColor = [UIColor lightGrayColor];
    HUD.detailsLabel.text = message;
    
    UIView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [(UIActivityIndicatorView *)indicator startAnimating];
    indicator.transform = CGAffineTransformMakeScale(0.85, 0.85);
    HUD.customView = indicator;
    _HUD = HUD;
    
    return HUD;
}
+ (instancetype)yx_showActivityIndicatorToView:(UIView *)view {
    
    return [self yx_showActivityIndicatorToView:view message:nil];
}

+ (instancetype)yx_cxuser_lodingToView:(UIView *)view {
    
    [self yx_hudDismiss];
    
    MBProgressHUD *HUD = [MBProgressHUD initHudWithView:view];
    HUD.mode = MBProgressHUDModeCustomView;
    
    UIImageView *animation = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 49, 49)];
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:8];
    for (NSInteger i = 1; i < 9; i ++) {
        
        NSBundle *bundle ;;
        NSURL *url = [bundle URLForResource:@"CaiXinUerLoding" withExtension:@"bundle"];
        NSBundle *targetBundle = [NSBundle bundleWithURL:url];
        
        NSString *imagePath = [targetBundle pathForResource:[NSString stringWithFormat:@"cxuser%02zd@2x",i] ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        [images addObject:image];
        
    }
    animation.animationDuration = 1;
    animation.animationImages = images;
    animation.animationRepeatCount = 0;
    [animation startAnimating];
    HUD.customView = animation;
    // 隐藏时候从父控件中移除
    HUD.removeFromSuperViewOnHide = YES;
    //设置等待框背景色为黑色
    HUD.bezelView.backgroundColor = [UIColor clearColor];
    HUD.animationType = MBProgressHUDAnimationFade;
    _HUD = HUD;
    return HUD;
}
/// 移除
+ (void)yx_hudDismiss {
    
    [_HUD hideAnimated:YES];
    [_HUD removeFromSuperview];
    _HUD = nil;
}

@end
