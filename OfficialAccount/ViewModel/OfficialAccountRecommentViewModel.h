//
//  OfficialAccountRecommentViewModel.h
//  OfficialAccount
//
//  Created by zhengjf on 2019/7/4.
//  Copyright © 2019 hongyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OfficialAccountMainViewModel.h"
#import "OfficialAccountViewModelType.h"
@import PromiseKit;

NS_ASSUME_NONNULL_BEGIN

/**
 推荐
 */
@class OACellViewModel;
@interface OfficialAccountRecommentViewModel : NSObject<OfficialAccountViewModelType>

// Output

// 重载指定单元格
@property (nonatomic, copy, nullable) void (^reloadCell)(NSInteger index);


- (instancetype)initWithMainViewModel:(OfficialAccountMainViewModel *)mainViewModel;


// Input

/// 关注
- (void)followOfficalAccountWithCellViewModel:(OACellViewModel *)cellViewModel;

@end

NS_ASSUME_NONNULL_END
