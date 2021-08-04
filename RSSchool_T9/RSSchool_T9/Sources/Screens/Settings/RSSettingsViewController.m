//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: rasul
// On: 8/1/21
// 
// Copyright © 2021 RSSchool. All rights reserved.

#import "RSSettingsViewController.h"
#import "RSSubtitleTableViewCell.h"
#import "UIColor+HEX.h"
#import "RSSettingsColorViewController.h"
#import "RSSchool_T9-Swift.h"

@interface RSSettingsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UISwitch *drawSwitch;
@end

@implementation RSSettingsViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupTableView];
}

- (void) setupTableView {
  self.tableView = [[UITableView alloc]
                    initWithFrame:self.view.bounds
                    style:UITableViewStyleInsetGrouped];
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
  [self.tableView registerClass:[RSSubtitleTableViewCell class] forCellReuseIdentifier:@"cell2"];
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.view addSubview:self.tableView];
}

#pragma mark Action
- (void) drawValueChanged {
  if (self.drawSwitch.isOn) {
    [NSUserDefaults.standardUserDefaults setBool:YES forKey:@"isDraw"];
    [NSUserDefaults.standardUserDefaults synchronize];
  } else {
    [NSUserDefaults.standardUserDefaults setBool:NO forKey:@"isDraw"];
    [NSUserDefaults.standardUserDefaults synchronize];
  }
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return 2;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  if (indexPath.row == 0) {
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = @"Draw stories";
    
    self.drawSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
    [self.drawSwitch setOn:[NSUserDefaults.standardUserDefaults boolForKey:@"isDraw"]];
    [self.drawSwitch setOnTintColor:UIColor.redColor];
    [self.drawSwitch addTarget:self action:@selector(drawValueChanged) forControlEvents:UIControlEventValueChanged];
    cell.accessoryView = self.drawSwitch;
    return cell;
  } else {
    RSSubtitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
    cell.textLabel.text = @"Stroke color";
    cell.detailTextLabel.text = self.colorText;
    cell.detailTextLabel.textColor = [UIColor colorWithHexString:self.colorText];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
  }
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:false];
  RSSettingsColorViewController *controller = [[RSSettingsColorViewController alloc] init];
  controller.colorText = self.colorText;
  __weak typeof(self) weakSelf = self;
  [controller setDidSelect:^(NSString * _Nonnull string) {
    weakSelf.colorText = string;
    
    dispatch_async(dispatch_get_main_queue(), ^{
      [weakSelf.tableView reloadData];
    });
  }];
  
  [self.navigationController pushViewController:controller animated:true];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 50;
}

@end
