//
//  MBProgressHUD+YXAddition.h
//  CXMerchant
//
//  Created by zainguo on 2019/3/16.
//  Copyright © 2019年 zainguo. All rights reserved.
//

#import <CXSwiftCommonModule/MBProgressHUD.h>


@interface MBProgressHUD (YXAddition)

/// 文字提示 显示时间为2妙
+ (instancetype)yx_showMessage:(NSString *)message;

/// 文字提示显示到指定View
+ (instancetype)yx_showMessage:(NSString *)message
                        toView:(UIView *)view;

/// 显示带图片和文字
+ (instancetype)yx_showMessage:(NSString *)message
                   imageName:(NSString *)imageName
                    toView:(UIView *)view;

/// 加载提示
+ (instancetype)yx_showLoding;

/// 加载文字提示到指定View
+ (instancetype)yx_showLodingWithMessage:(NSString *)message
                                  toView:(UIView *)view;

/// 指定view加载显示loding
+ (instancetype)yx_showLodingToView:(UIView *)view;
/// 加载文字提示
+ (instancetype)yx_showLodingWithMessage:(NSString *)message;

/// 自定义ActivityIndicator 背景是透明的
+ (instancetype)yx_showActivityIndicatorToView:(UIView *)view
                                       message:(NSString *)message;
/// 自定义ActivityIndicator
+ (instancetype)yx_showActivityIndicatorToView:(UIView *)view;
/// 加载动画
+ (instancetype)yx_cxuser_lodingToView:(UIView *)view;
/// 移除
+ (void)yx_hudDismiss;


@end

