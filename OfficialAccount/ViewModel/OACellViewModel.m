//
//  OACellViewModel.m
//  OfficialAccount
//
//  Created by zhengjf on 2019/7/4.
//  Copyright © 2019 hongyu. All rights reserved.
//

#import "OACellViewModel.h"

@implementation OACellViewModel

- (instancetype)initWithModel:(OfficialAccountModel *)model {
    self = [super init];
    if (self) {
        _model = model;
        _isFollowedIconHidden = YES;
    }
    return self;
}

- (void)follow {
    _isFollowedIconHidden = NO;
}

@end
