//
//  OfficialAccountItem.m
//  OfficialAccount
//
//  Created by xueqooy on 2022/8/21.
//

#import "OfficialAccountModel.h"

@interface OfficialAccountModel ()

@property (nonatomic, copy) NSString *OAID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *avatarUrl;

@end

@implementation OfficialAccountModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
        @"OAID" : @"OAID",
        @"title" : @"title",
        @"avatarUrl" : @"avatarUrl"
    };
}

- (NSString *)OAID {
    return _OAID ?: @"";
}

- (NSString *)title {
    return _title ?: @"";
}

- (NSString *)avatarUrl {
    return _avatarUrl ?: @"";
}

@end
