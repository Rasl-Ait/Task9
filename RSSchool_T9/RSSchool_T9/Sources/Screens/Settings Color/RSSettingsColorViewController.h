//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: rasul
// On: 8/1/21
// 
// Copyright © 2021 RSSchool. All rights reserved.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSSettingsColorViewController : UIViewController
@property (nonatomic, strong) UITableView *tableView;
@property(strong, nonatomic) NSString *colorText;
@property (copy, nonatomic) void (^didSelect)(NSString* string);

@end

NS_ASSUME_NONNULL_END
