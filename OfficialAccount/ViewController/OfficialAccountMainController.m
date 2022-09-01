//
//  OfficialAccountMainController.m
//  OfficialAccount
//
//  Created by zhengjf on 2019/7/4.
//  Copyright © 2019 hongyu. All rights reserved.
//

#import "OfficialAccountMainController.h"
#import "OfficialAccountMainViewModel.h"
#import "OACellView.h"
#import "OACellViewModel.h"
#import <KVOController/FBKVOController.h>
#import "OfficialAccountRecommendController.h"
#import "OAUtil.h"

@interface OfficialAccountMainController ()

@property (nonatomic, strong) OfficialAccountMainViewModel *viewModel;

@end

@implementation OfficialAccountMainController

@dynamic viewModel;

- (instancetype)initWithViewModel:(OfficialAccountMainViewModel *)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"公众号";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"general_top_icon_add_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(viewRecommendations)];
}

#pragma mark - Override

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    OACellViewModel *cellvm = self.viewModel.cellViewModels[indexPath.row];
    [OAUtil showComfirmationAlertWithTitle:nil message:[NSString stringWithFormat:@"您点击了%@", cellvm.model.title]];
}

#pragma mark - Private

- (void)viewRecommendations {
    OfficialAccountRecommentViewModel *viewModel = [[OfficialAccountRecommentViewModel alloc] initWithMainViewModel:self.viewModel];
    OfficialAccountRecommendController *viewController = [[OfficialAccountRecommendController alloc] initWithViewModel:viewModel];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
