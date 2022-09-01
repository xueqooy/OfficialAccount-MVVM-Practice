//
//  OACellViewModel.h
//  OfficialAccount
//
//  Created by zhengjf on 2019/7/4.
//  Copyright © 2019 hongyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OfficialAccountModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 单元格View Model
 */
@interface OACellViewModel : NSObject

@property (nonatomic, strong) OfficialAccountModel *model;

/// 是否隐藏已关注图标
@property (nonatomic, assign, readonly) BOOL isFollowedIconHidden;

- (instancetype)initWithModel:(OfficialAccountModel *)model;

/// 关注
- (void)follow;

@end

NS_ASSUME_NONNULL_END
