//
//  OAStorage.h
//  OfficialAccount
//
//  Created by xueqooy on 2022/8/21.
//

#import <Foundation/Foundation.h>
#import "OfficialAccountModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 数据库存储
 */

@interface OAStorage : NSObject

@property (nonatomic, copy, readonly) NSString *name;

-  (instancetype)initWithName:(NSString *)name;

/// 获取数据
- (NSArray<OfficialAccountModel *> *)getOfficialAccounts;

/// 添加数据
- (void)addOfficialAccounts:(NSArray<OfficialAccountModel *> *)models;

/// 清空所有数据
- (void)clearData;

@end

NS_ASSUME_NONNULL_END
