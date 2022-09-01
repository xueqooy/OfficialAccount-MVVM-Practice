//
//  OfficialAccountBaseViewController.h
//  OfficialAccount
//
//  Created by xueqooy on 2022/8/21.
//

#import <UIKit/UIKit.h>
#import "OACellViewModel.h"
#import "OfficialAccountViewModelType.h"

NS_ASSUME_NONNULL_BEGIN

/**
 视图控制器基类
 */
@interface OfficialAccountBaseViewController : UITableViewController

@property (nonatomic, strong) id<OfficialAccountViewModelType> viewModel;

- (void)bindViewModel NS_REQUIRES_SUPER;

- (void)refreshData NS_REQUIRES_SUPER;


@end

NS_ASSUME_NONNULL_END
