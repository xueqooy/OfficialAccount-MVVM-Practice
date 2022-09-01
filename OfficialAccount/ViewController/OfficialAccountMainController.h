//
//  OfficialAccountMainController.h
//  OfficialAccount
//
//  Created by zhengjf on 2019/7/4.
//  Copyright © 2019 hongyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OfficialAccountMainViewModel.h"
#import "OfficialAccountBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface OfficialAccountMainController : OfficialAccountBaseViewController

- (instancetype)initWithViewModel:(OfficialAccountMainViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
