//
//  OfficialAccountRecommendController.m
//  OfficialAccount
//
//  Created by zhengjf on 2019/7/4.
//  Copyright © 2019 hongyu. All rights reserved.
//

#import "OfficialAccountRecommendController.h"
#import "OfficialAccountRecommentViewModel.h"
#import "OACellView.h"
#import "OACellViewModel.h"
#import <KVOController/FBKVOController.h>
#import "OAUtil.h"

@interface OfficialAccountRecommendController ()

@property (nonatomic, strong) OfficialAccountRecommentViewModel *viewModel;
@property (nonatomic, strong) FBKVOController *kvoController;

@end

@implementation OfficialAccountRecommendController

@dynamic viewModel;

- (instancetype)initWithViewModel:(OfficialAccountRecommentViewModel *)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"推荐号";
}

#pragma mark - Override

- (void)bindViewModel {
    [super bindViewModel];
    
    __weak typeof(self) weakSelf = self;
    self.viewModel.reloadCell = ^(NSInteger index) {
        [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    OACellViewModel *cellvm = self.viewModel.cellViewModels[indexPath.row];
    [self showFollowingAlert:cellvm];
}

#pragma mark - private

- (void)showFollowingAlert:(OACellViewModel *)viewModel {
    if (!viewModel.isFollowedIconHidden) {
        [OAUtil showComfirmationAlertWithTitle:nil message:[NSString stringWithFormat:@"您已经关注了%@", viewModel.model.title]];
        return;
    }
    
    NSString *strPrompt = [NSString stringWithFormat:@"关注公众号\"%@\"", viewModel.model.title];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"关注" message:strPrompt preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 关注公众号
        [self.viewModel followOfficalAccountWithCellViewModel:viewModel];
    }];
    [alertVC addAction:actionCancel];
    [alertVC addAction:actionConfirm];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
