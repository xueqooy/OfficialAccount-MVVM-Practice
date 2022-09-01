//
//  OAService.m
//  OfficialAccount
//
//  Created by xueqooy on 2022/8/21.
//

#import "OAService.h"
#import "OADefine.h"
#import "OfficialAccountModel.h"
@import AFNetworking;

@interface OAService ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation OAService

- (instancetype)init {
    self = [super init];
    if (self) {
        NSURL *baseURL = [NSURL URLWithString:kOfficialAccount_Base_Url];
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    }
    return self;
}

- (AnyPromise *)fetchOfficalAccountList {
    return [self fetchListForPath:kOfficialAccount_List];
}

- (AnyPromise *)fetchRecommendedAccountList {
    return [self fetchListForPath:kOfficialAccount_Recommend];
}

- (AnyPromise *)followOfficalAccountWithID:(NSString *)OAID {
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver _Nonnull resolve) {
        NSString *path = [NSString stringWithFormat:kOfficialAccount_Follow, OAID];
        [self.manager POST:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            resolve(responseObject[@"OAID"]);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            resolve(error);
        }];
    }];
}

#pragma mark - Private

- (AnyPromise *)fetchListForPath:(NSString *)path {
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver _Nonnull resolve) {
        [self.manager GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *items = responseObject[@"items"] ?: @[];
            NSError *error;
            NSArray<OfficialAccountModel *> *models = [MTLJSONAdapter modelsOfClass:OfficialAccountModel.class fromJSONArray:items error:&error];
            resolve(models ?: error);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            resolve(error);
        }];
    }];
    
}

@end
