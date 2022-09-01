//
//  OfficialAccountViewModelType.h
//  OfficialAccount
//
//  Created by xueqooy on 2022/8/21.
//

#import <Foundation/Foundation.h>
#import "OACellViewModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 视图控制器View Model类型，定义通用的输入和输出 
 */
@protocol OfficialAccountViewModelType <NSObject>

// Output

@property (nonatomic, copy, readonly) NSArray<OACellViewModel *> *cellViewModels;

/// 刷新数据
@property (nonatomic, copy, nullable) void(^refreshList)(void);

/// 显示/隐藏刷新指示器
@property (nonatomic, copy, nullable) void(^showsRefreshingIndicator)(BOOL shows);

/// 显示/隐藏加载指示器
@property (nonatomic, copy, nullable) void(^showsCenteralLoadingIndicator)(BOOL shows);


// Input

/// 获取数据
- (void)refreshData;

@end

NS_ASSUME_NONNULL_END
