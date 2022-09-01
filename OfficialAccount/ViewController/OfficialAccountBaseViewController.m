//
//  OfficialAccountBaseViewController.m
//  OfficialAccount
//
//  Created by xueqooy on 2022/8/21.
//

#import "OfficialAccountBaseViewController.h"
#import "OACellView.h"
#import "OAUtil.h"

@interface OfficialAccountBaseViewController ()

@end

@implementation OfficialAccountBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;

    self.tableView.rowHeight = 50;
    [self.tableView registerClass:[OACellView class] forCellReuseIdentifier:@"OACellView"];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
    [self refreshData];
}

- (void)setViewModel:(id<OfficialAccountViewModelType> _Nonnull)viewModel {
    _viewModel = viewModel;
    [self bindViewModel];
}

- (void)bindViewModel {
    __weak typeof(self) weakSelf = self;
    self.viewModel.refreshList = ^{
        __strong typeof(self) strongSelf = weakSelf;
        
        [strongSelf.tableView reloadData];
    };
    self.viewModel.showsRefreshingIndicator = ^(BOOL shows) {
        __strong typeof(self) strongSelf = weakSelf;
        
        if (shows) {
            [strongSelf.refreshControl beginRefreshing];
        } else {
            [strongSelf.refreshControl endRefreshing];
        }
    };
    self.viewModel.showsCenteralLoadingIndicator = ^(BOOL shows) {
        __strong typeof(self) strongSelf = weakSelf;
        
        if (shows) {
            [OAUtil showCenteralLoadingIndicatorInView:strongSelf.view];
        } else {
            [OAUtil hideCenteralLoadingIndicatorInView:strongSelf.view];
        }
    };}

- (void)refreshData {
    [self.viewModel refreshData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.cellViewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OACellView *cell = [tableView dequeueReusableCellWithIdentifier:@"OACellView"];
    OACellViewModel *cellvm = self.viewModel.cellViewModels[indexPath.row];
    [cell bindViewModel:cellvm];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

