//
//  OACellView.h
//  OfficialAccount
//
//  Created by zhengjf on 2019/7/4.
//  Copyright © 2019 hongyu. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@class OACellViewModel;
@interface OACellView : UITableViewCell

- (void)bindViewModel:(OACellViewModel *)vm;

@end

NS_ASSUME_NONNULL_END
