//
//  AppDelegate.m
//  OfficialAccount
//
//  Created by zhengjf on 2019/7/4.
//  Copyright © 2019 hongyu. All rights reserved.
//

#import "AppDelegate.h"
#import <OHHTTPStubs/OHHTTPStubs.h>
#import <OHHTTPStubs/OHHTTPStubsResponse+JSON.h>
#import <AFNetworking/AFNetworking.h>
#import <SDWebImage/SDWebImage.h>
#import "OADefine.h"
#import "OfficialAccountMainController.h"

@interface AppDelegate ()

@property (nonatomic, strong) NSMutableDictionary *officialAccounts;
@property (nonatomic, strong) NSMutableDictionary *recomments;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initData];
    
    
    [OHHTTPStubs setEnabled:YES];
    [self addOtherRequestStub];
    [self addGetOfficialAccountsStub];
    [self addGetRecommentsStub];
    [self addPostFollowStub];
    
    SDWebImageDownloaderConfig *config = [SDWebImageDownloaderConfig new];
    config.sessionConfiguration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"customConfig"];
    SDWebImageDownloader *loader = [[SDWebImageDownloader alloc] initWithConfig:config];
    
    SDWebImageManager.defaultImageLoader = loader;
    
    // Setup root view controller
    OAService *service = [OAService new];
    OAStorage *storage = [[OAStorage alloc] initWithName:@"SHARE"];
    OfficialAccountMainViewModel *viewModel = [[OfficialAccountMainViewModel alloc] initWithService:service storage:storage]; 
    OfficialAccountMainController *mainController = [[OfficialAccountMainController alloc] initWithViewModel:viewModel];
    UINavigationController *rootViewController = [[UINavigationController alloc] initWithRootViewController:mainController];
    UIWindow *window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    window.rootViewController = rootViewController;
    [window makeKeyWindow];
    self.window = window;
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)initData {
    [self constructOfficialAccounts];
    [self constructRecomments];
}

- (void)constructOfficialAccounts {
    NSString *cachesDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *oaPath = [cachesDir stringByAppendingPathComponent:@"officialaccounts.archiver"];
    NSData *data = [NSData dataWithContentsOfFile:oaPath];
    NSDictionary *officialAccounts = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (officialAccounts) {
        self.officialAccounts = [officialAccounts mutableCopy];
    } else {
        NSMutableArray *items = [NSMutableArray array];
        for (int i=0; i<50; i++) {
            NSString *name = [NSString stringWithFormat:@"公众号%d",i];
            NSDictionary *item = @{@"title":name, @"avatarUrl":@"https://betacs.101.com/v0.1/download?path=/preproduction_content_avatar/agent_user_avatar/281474976720290.jpg&serviceName=preproduction_content_avatar&version=1487297983784&ext=jpg",@"OAID":[NSString stringWithFormat:@"%d",i]};
            [items addObject:item];
        }
        self.officialAccounts = [NSMutableDictionary dictionary];
        [self.officialAccounts setObject:items forKey:@"items"];
    }
}

- (void)constructRecomments {
    NSString *cachesDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *oaPath = [cachesDir stringByAppendingPathComponent:@"recomments.archiver"];
    NSData *data = [NSData dataWithContentsOfFile:oaPath];
    NSDictionary *recomments = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (recomments) {
        self.recomments = [recomments mutableCopy];
    } else {
        NSMutableArray *items = [NSMutableArray array];
        for (int i=0; i<50; i++) {
            NSString *name = [NSString stringWithFormat:@"推荐号%d",i];
            NSDictionary *item = @{@"title":name, @"avatarUrl":@"https://betacs.101.com/v0.1/download?path=/preproduction_content_avatar/agent_user_avatar/281474976720290.jpg&serviceName=preproduction_content_avatar&version=1487297983784&ext=jpg",@"OAID":[NSString stringWithFormat:@"%d",i+100]};
            [items addObject:item];
        }
        self.recomments = [NSMutableDictionary dictionary];
        [self.recomments setObject:items forKey:@"items"];
    }
}

- (NSDictionary *)removeRecommentsWithOAID:(NSString *)oaid {
    __block NSDictionary *removeObj;
    NSMutableArray *items = self.recomments[@"items"];
    [items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([oaid isEqualToString:obj[@"OAID"]]) {
            [items removeObject:obj];
            *stop = YES;
            removeObj = obj;
        }
    }];
    
    return removeObj;
}

- (void)saveToDisk {
    NSString *cachesDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *oaPath = [cachesDir stringByAppendingPathComponent:@"officialaccounts.archiver"];
    if (self.officialAccounts) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.officialAccounts requiringSecureCoding:NO error:nil];
        [data writeToFile:oaPath atomically:YES];
    }
    NSString *rtPath = [cachesDir stringByAppendingPathComponent:@"recomments.archiver"];
    if (self.recomments) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.recomments requiringSecureCoding:NO error:nil];
        [data writeToFile:rtPath atomically:YES];
    }
}

- (void)addGetOfficialAccountsStub {
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
        BOOL pass = NO;
        if ([kOfficialAccount_Base_Url containsString:request.URL.host] &&
            [request.URL.path isEqualToString:kOfficialAccount_List]) {
            pass = YES;
        }
        return pass;
    } withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
        int statusCode = 200;
        if (![request.HTTPMethod isEqualToString:@"GET"]) {
            statusCode = 405;
        }
        NSDictionary *jsonString;
        if (statusCode == 200) {
            jsonString = self.officialAccounts;
        } else {
            jsonString = @{@"code":@"METHOD_NOT_ALLOWED"};
        }
        
        OHHTTPStubsResponse * response = [OHHTTPStubsResponse responseWithJSONObject:jsonString statusCode:statusCode headers:@{@"Content-Type":@"application/json"}];
        response.requestTime = 2;
        return response;
    }];
}

- (void)addGetRecommentsStub {
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
        BOOL pass = NO;
        if ([kOfficialAccount_Base_Url containsString:request.URL.host] &&
            [request.URL.path isEqualToString:kOfficialAccount_Recommend]) {
            pass = YES;
        }
        return pass;
    } withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
        int statusCode = 200;
        if (![request.HTTPMethod isEqualToString:@"GET"]) {
            statusCode = 405;
        }
        NSDictionary *jsonString;
        if (statusCode == 200) {
            jsonString = self.recomments;
        } else {
            jsonString = @{@"code":@"METHOD_NOT_ALLOWED"};
        }
        OHHTTPStubsResponse * response = [OHHTTPStubsResponse responseWithJSONObject:jsonString statusCode:statusCode headers:@{@"Content-Type":@"application/json"}];
        response.requestTime = 2;
        return response;
    }];
}

- (void)addPostFollowStub {
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
        BOOL pass = NO;
        if ([kOfficialAccount_Base_Url containsString:request.URL.host] &&
            [request.URL.path containsString:@"follow"]) {
            pass = YES;
        }
        return pass;
    } withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
        int statusCode = 200;
        NSDictionary *jsonString;
        if ([request.HTTPMethod isEqualToString:@"POST"]) {
            NSArray *urlArray = [request.URL.absoluteString componentsSeparatedByString:@"/"];
            NSString *followID = urlArray.lastObject;
            NSDictionary *removeObj = [self removeRecommentsWithOAID:followID];
            if (removeObj) {
                [self.officialAccounts[@"items"] addObject:removeObj];
                //缓存数据库
                [self saveToDisk];
                jsonString = @{@"OAID":removeObj[@"OAID"]};
            } else {
                statusCode = 400;
                jsonString = @{@"code":@"INVALID_ARGUMENT"};
            }
        } else {
            statusCode = 405;
            jsonString = @{@"code":@"METHOD_NOT_ALLOWED"};
        }

        OHHTTPStubsResponse * response = [OHHTTPStubsResponse responseWithJSONObject:jsonString statusCode:statusCode headers:@{@"Content-Type":@"application/json"}];
        response.requestTime = 2;
        return response;
    }];
}

- (void)addOtherRequestStub {
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
        return YES;
    } withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
        OHHTTPStubsResponse * response = [OHHTTPStubsResponse responseWithJSONObject:@{} statusCode:404 headers:@{@"Content-Type":@"application/json"}];
        return response;
    }];
}

@end
