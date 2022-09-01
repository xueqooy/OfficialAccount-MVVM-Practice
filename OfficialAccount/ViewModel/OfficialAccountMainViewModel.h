//
//  OfficialAccountMainViewModel.h
//  OfficialAccount
//
//  Created by zhengjf on 2019/7/4.
//  Copyright © 2019 hongyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OAService.h"
#import "OAStorage.h"
#import "OfficialAccountModel.h"
#import "OfficialAccountViewModelType.h"

NS_ASSUME_NONNULL_BEGIN

@class OACellViewModel;
@interface OfficialAccountMainViewModel : NSObject<OfficialAccountViewModelType>

@property (nonatomic, strong, readonly) OAService *service;
@property (nonatomic, strong, readonly) OAStorage *storage;


- (instancetype)initWithService:(OAService *)service storage:(OAStorage *)storage;

// Input

/// 已关注某个公众号
- (void)didFollow:(OfficialAccountModel *)model;

@end

NS_ASSUME_NONNULL_END
