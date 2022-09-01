//
//  OfficialAccountModel.h
//  OfficialAccount
//
//  Created by xueqooy on 2022/8/21.
//

#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface OfficialAccountModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *OAID;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *avatarUrl;

@end

NS_ASSUME_NONNULL_END
