//
//  OAUtil.m
//  OfficialAccount
//
//  Created by xueqooy on 2022/8/21.
//

#import "OAUtil.h"
#import <objc/runtime.h>

@interface UIView (Loading)

@property (nonatomic, nullable) UIActivityIndicatorView *loadingIndicatorView;

@end


@implementation UIView (Loading)

static char const kLoadingIndicatorViewKey;

- (UIActivityIndicatorView *)loadingIndicatorView {
   return (UIActivityIndicatorView *)objc_getAssociatedObject(self, &kLoadingIndicatorViewKey);
}

- (void)setLoadingIndicatorView:(UIActivityIndicatorView *)loadingIndicatorView {
    objc_setAssociatedObject(self, &kLoadingIndicatorViewKey, loadingIndicatorView, OBJC_ASSOCIATION_RETAIN);
}

@end


@implementation OAUtil

+ (NSArray<OACellViewModel *> *)cellViewModelsForModels:(NSArray<OfficialAccountModel *> *)models {
    NSMutableArray *result = @[].mutableCopy;
    for (OfficialAccountModel *model in models) {
        [result addObject:[[OACellViewModel alloc] initWithModel:model]];
    }
    return result.copy;
}

+ (void)showComfirmationAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    UIViewController *rootViewController = UIApplication.sharedApplication.windows.firstObject.rootViewController;
    [rootViewController presentViewController:alert animated:YES completion:nil];
}

+ (void)showCenteralLoadingIndicatorInView:(UIView *)view {
    UIActivityIndicatorView *indicatorView = view.loadingIndicatorView;
    if (!indicatorView) {
        indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
        view.loadingIndicatorView = indicatorView;
    }
    
    if (indicatorView.superview != view) {
        [view addSubview:indicatorView];
        indicatorView.translatesAutoresizingMaskIntoConstraints = NO;

        [NSLayoutConstraint activateConstraints:@[
            [indicatorView.centerXAnchor constraintEqualToAnchor:view.centerXAnchor],
            [indicatorView.centerYAnchor constraintEqualToAnchor:view.centerYAnchor]
        ]];
    }
    
    [view bringSubviewToFront:indicatorView];
    [indicatorView startAnimating];
}

+ (void)hideCenteralLoadingIndicatorInView:(UIView *)view {
    [view.loadingIndicatorView removeFromSuperview];
    view.loadingIndicatorView = nil;
}

@end

