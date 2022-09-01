//
//  OfficialAccountRecommentViewModel.m
//  OfficialAccount
//
//  Created by zhengjf on 2019/7/4.
//  Copyright © 2019 hongyu. All rights reserved.
//

#import "OfficialAccountRecommentViewModel.h"
#import "OACellViewModel.h"
#import "OAService.h"
#import "OfficialAccountMainViewModel.h"
#import "OAUtil.h"

@interface OfficialAccountRecommentViewModel()

@property (nonatomic, weak, nullable) OfficialAccountMainViewModel *mainViewModel;

@property (nonatomic, copy) NSArray<OACellViewModel *> *cellViewModels;

@end

@implementation OfficialAccountRecommentViewModel

@synthesize refreshList;
@synthesize showsRefreshingIndicator;
@synthesize showsCenteralLoadingIndicator;

- (instancetype)initWithMainViewModel:(OfficialAccountMainViewModel *)mainViewModel {
    self = [super init];
    if (self) {
        _mainViewModel = mainViewModel;
    }
    return self;
}

- (void)refreshData {
    // 从服务端获取数据
    !self.showsRefreshingIndicator ?: self.showsRefreshingIndicator(YES);
    __weak OfficialAccountRecommentViewModel *weakSelf = self;
    [self.mainViewModel.service fetchRecommendedAccountList].then(^(NSArray<OfficialAccountModel *> *models){
        OfficialAccountRecommentViewModel *strongSelf = weakSelf;
        if (!strongSelf) return;
        
        strongSelf.cellViewModels = [OAUtil cellViewModelsForModels:models];
        !strongSelf.refreshList ?: strongSelf.refreshList();
        
    }).catch(^(NSError *error){
        [OAUtil showComfirmationAlertWithTitle:@"出现错误了" message:error.localizedDescription];
    }).ensure(^{
        OfficialAccountRecommentViewModel *strongSelf = weakSelf;
        if (!strongSelf) return;
        
        !strongSelf.showsRefreshingIndicator ?: strongSelf.showsRefreshingIndicator(NO);
    });
}

- (void)followOfficalAccountWithCellViewModel:(OACellViewModel *)cellViewModel {
    OfficialAccountMainViewModel *mainViewModel = self.mainViewModel;
    __weak OfficialAccountRecommentViewModel *weakSelf = self;
    !self.showsCenteralLoadingIndicator ?: self.showsCenteralLoadingIndicator(YES);
    [_mainViewModel.service followOfficalAccountWithID:cellViewModel.model.OAID].then(^{
        [mainViewModel didFollow:cellViewModel.model];
        
        OfficialAccountRecommentViewModel *strongSelf = weakSelf;
        if (!strongSelf) return;
        
        [cellViewModel follow];
        NSInteger index = [strongSelf.cellViewModels indexOfObject:cellViewModel];
        if (index != NSNotFound) {
            !weakSelf.reloadCell ?: weakSelf.reloadCell(index);
        }
    }).catch(^(NSError *error){
        [OAUtil showComfirmationAlertWithTitle:@"出现错误了" message:error.localizedDescription];
    }).ensure(^{
        OfficialAccountRecommentViewModel *strongSelf = weakSelf;
        if (!strongSelf) return;
        
        !strongSelf.showsCenteralLoadingIndicator ?: strongSelf.showsCenteralLoadingIndicator(NO);
    });
}

@end
