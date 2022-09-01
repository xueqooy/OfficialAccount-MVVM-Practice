//
//  OAUtil.h
//  OfficialAccount
//
//  Created by xueqooy on 2022/8/21.
//

#import <Foundation/Foundation.h>
#import "OACellViewModel.h"
#import "OfficialAccountModel.h"
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

/**
 工具类
 */
@interface OAUtil : NSObject

/// 根据model创建cell view model
+ (NSArray<OACellViewModel *> *)cellViewModelsForModels:(NSArray<OfficialAccountModel *> *)models;

/// 显示确认弹窗
+ (void)showComfirmationAlertWithTitle:(NSString *_Nullable)title message:(NSString *_Nullable)message;

/// 显示视图加载指示器
+ (void)showCenteralLoadingIndicatorInView:(UIView *)view;
/// 隐藏视图加载指示器
+ (void)hideCenteralLoadingIndicatorInView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
