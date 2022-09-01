//
//  OAService.h
//  OfficialAccount
//
//  Created by xueqooy on 2022/8/21.
//

#import <Foundation/Foundation.h>
@import PromiseKit;

NS_ASSUME_NONNULL_BEGIN

/**
  网络请求服务
 */
@interface OAService : NSObject

/// 获取已关注的公众号列表
- (AnyPromise *)fetchOfficalAccountList;

/// 获取推荐的公众号列表
- (AnyPromise *)fetchRecommendedAccountList;

/// 关注公众号
- (AnyPromise *)followOfficalAccountWithID:(NSString *)OAID;

@end

NS_ASSUME_NONNULL_END
