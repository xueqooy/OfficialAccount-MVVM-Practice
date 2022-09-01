//
//  OAStorage.m
//  OfficialAccount
//
//  Created by xueqooy on 2022/8/21.
//

#import "OAStorage.h"
@import FMDB;

@interface OAStorage()

@property (nonatomic, strong) FMDatabase *db;

@end

@implementation OAStorage

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = name;
        [self initializeDB];
    }
    return self;
}

- (void)initializeDB {
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.db", _name]];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    if ([db open]) {
        BOOL res = [db executeUpdate: @"create table if not exists OfficalAccount (OAID text primary key, title text, avatarUrl text)"];
        if (!res) {
            NSLog(@"create table 'OfficialAccount' failed: %@", _db.lastError);
        }
        [db close];
    } else {
        NSLog(@"db open failed: %@", _db.lastError);
    }
    
    self.db = db;
}

- (NSArray<OfficialAccountModel *> *)getOfficialAccounts {
    if (![_db open]) {
        NSLog(@"db open failed: %@", _db.lastError);
        return @[];
    }
    
    NSMutableArray<OfficialAccountModel *> *result = @[].mutableCopy;
    
    FMResultSet *s = [_db executeQuery:@"select * from OfficalAccount"];
    while ([s next]) {
        OfficialAccountModel *model = [MTLJSONAdapter modelOfClass:OfficialAccountModel.class fromJSONDictionary:@{
            @"OAID" : [s stringForColumn:@"OAID"],
            @"title" : [s stringForColumn:@"title"] ?: @"",
            @"avatarUrl" : [s stringForColumn:@"avatarUrl"] ?: @""
        } error:nil];
        
        if (model) {
            [result addObject:model];
        }
    }
    [_db close];
    
    return result.copy;
}

- (void)addOfficialAccounts:(NSArray<OfficialAccountModel *> *)models {
    if (![_db open]) {
        NSLog(@"db open failed: %@", _db.lastError);
        return;
    }
    
    for (OfficialAccountModel *model in models) {
        BOOL res = [_db executeUpdate:@"insert into OfficalAccount(OAID, title, avatarUrl) values(?, ?, ?)" withArgumentsInArray:@[model.OAID, model.title, model.avatarUrl]];
        if (!res) {
            NSLog(@"insert item %@ failed: %@", model.dictionaryValue, _db.lastError);
        }
    }
    
    [_db close];
}

- (void)clearData {
    if (![_db open]) {
        NSLog(@"db open failed: %@", _db.lastError);
        return;
    }
    
    BOOL res = [_db executeUpdate:@"delete from OfficalAccount"];
    if (!res) {
        NSLog(@"clear data failed: %@", _db.lastError);
    }
    
    [_db close];
}

@end
