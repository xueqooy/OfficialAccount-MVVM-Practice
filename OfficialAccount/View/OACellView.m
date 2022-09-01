//
//  OACellView.m
//  OfficialAccount
//
//  Created by zhengjf on 2019/7/4.
//  Copyright © 2019 hongyu. All rights reserved.
//

#import "OACellView.h"
#import "OACellViewModel.h"
#import <SDWebImage/SDWebImage.h>

static CGFloat const kAvatarImageViewSize = 40.0;
static CGFloat const kPadding = 20.0;

@interface OACellView()

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong,) UIImageView *followedImageView;

@end
@implementation OACellView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _avatarImageView = [UIImageView new];
    _avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
    _avatarImageView.layer.cornerRadius = kAvatarImageViewSize / 2.0;
    _avatarImageView.layer.masksToBounds = YES;
    _avatarImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    _titleLabel.textColor = UIColor.darkTextColor;
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    _followedImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star"]];
    _followedImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addSubview:_avatarImageView];
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_followedImageView];
    
    [NSLayoutConstraint activateConstraints:@[
        [_avatarImageView.widthAnchor constraintEqualToConstant:kAvatarImageViewSize],
        [_avatarImageView.heightAnchor constraintEqualToConstant:kAvatarImageViewSize],
        [_avatarImageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:kPadding],
        [_avatarImageView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
        
        [_titleLabel.leadingAnchor constraintEqualToAnchor:_avatarImageView.trailingAnchor constant:kPadding],
        [_titleLabel.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
        
        [_followedImageView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-kPadding],
        [_followedImageView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor]

    ]];
}

- (void)bindViewModel:(OACellViewModel *)vm {
    _titleLabel.text = vm.model.title;
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:vm.model.avatarUrl ?: @""] placeholderImage:[UIImage imageNamed:@"chat_4in1_icon_friends_normal"] options:SDWebImageRetryFailed];
    _followedImageView.hidden = vm.isFollowedIconHidden;
}

@end
