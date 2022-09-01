//
//  OfficialAccountMainViewModel.m
//  OfficialAccount
//
//  Created by zhengjf on 2019/7/4.
//  Copyright © 2019 hongyu. All rights reserved.
//

#import "OfficialAccountMainViewModel.h"
#import "OACellViewModel.h"
#import "OAService.h"
#import "OAUtil.h"

@interface OfficialAccountMainViewModel()

@property (nonatomic, copy) NSArray<OACellViewModel *> *cellViewModels;

@end

@implementation OfficialAccountMainViewModel

@synthesize refreshList;
@synthesize showsRefreshingIndicator;
@synthesize showsCenteralLoadingIndicator;

- (instancetype)initWithService:(OAService *)service storage:(nonnull OAStorage *)storage {
    self = [super init];
    if (self) {
        _service = service;
        _storage = storage;
    }
    return self;
}

- (void)refreshData {
    // 已加载的数据为空时，从数据库读取
    if (self.cellViewModels.count == 0) {
        NSArray<OfficialAccountModel *> *models = [self.storage getOfficialAccounts];
        if (models.count > 0) {
            self.cellViewModels = [OAUtil cellViewModelsForModels:models];
            !self.refreshList ?: self.refreshList();
        }
    }
    
    // 从服务端获取
    !self.showsRefreshingIndicator ?: self.showsRefreshingIndicator(YES);
    __weak OfficialAccountMainViewModel *weakSelf = self;
    OAStorage *storage = self.storage;
    [self.service fetchOfficalAccountList].then(^(NSArray<OfficialAccountModel *> *models){
        // 写入数据库
        [storage clearData];
        [storage addOfficialAccounts:models];
        
        OfficialAccountMainViewModel *strongSelf = weakSelf;
        if (!strongSelf) return;
        
        // 刷新列表
        strongSelf.cellViewModels = [OAUtil cellViewModelsForModels:models];
        !strongSelf.refreshList ?: strongSelf.refreshList();
        
    }).catch(^(NSError *error){
        [OAUtil showComfirmationAlertWithTitle:@"出现错误了" message:error.localizedDescription];
    }).ensure(^{
        OfficialAccountMainViewModel *strongSelf = weakSelf;
        if (!strongSelf) return;
        
        !strongSelf.showsRefreshingIndicator ?: strongSelf.showsRefreshingIndicator(NO);
    });
}

- (void)didFollow:(OfficialAccountModel *)model {
    // 如果已经在列表中，则忽略
    if ([(NSArray *)[self.cellViewModels valueForKeyPath:@"model.OAID"] containsObject:model.OAID]) {
        return;
    }
    
    // 写入数据库
    [self.storage addOfficialAccounts:@[model]];
    
    // 刷新列表
    NSArray<OACellViewModel *>*appendedCellViewModels = [OAUtil cellViewModelsForModels:@[model]];
    NSMutableArray *updatedCellViewModels = self.cellViewModels.mutableCopy;
    [updatedCellViewModels addObjectsFromArray:appendedCellViewModels];
    self.cellViewModels = updatedCellViewModels.copy;
    !self.refreshList ?: self.refreshList();
}

@end
