//
//  OfficialAccountRecommendControllerTableViewController.h
//  OfficialAccount
//
//  Created by zhengjf on 2019/7/4.
//  Copyright © 2019 hongyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OfficialAccountRecommentViewModel.h"
#import "OfficialAccountBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface OfficialAccountRecommendController : OfficialAccountBaseViewController

- (instancetype)initWithViewModel:(OfficialAccountRecommentViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
