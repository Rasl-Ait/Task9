//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: rasul
// On: 8/1/21
// 
// Copyright © 2021 RSSchool. All rights reserved.

#import "RSSettingsColorViewController.h"
#import "UIColor+HEX.h"
#import "ColorsModel.h"

@interface RSSettingsColorViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *models;
@end

@implementation RSSettingsColorViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupTableView];
  _models = [[NSMutableArray<ColorsModel *> alloc] init];
  [self fetch];
  
  self.models = [[NSArray alloc] initWithObjects:
                 @"#be2813", @"#3802da", @"#467c24",
                 @"#808080", @"#8e5af7", @"#f07f5a",
                 @"#f3af22", @"#3dacf7", @"#e87aa4",
                 @"#0f2e3f", @"#213711", @"#511307",
                 @"#92003b", nil];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  NSDictionary *dict = [NSDictionary dictionaryWithObject:self.colorText forKey:@"color"];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"kUpdateColor"
                                                      object:nil userInfo: dict];
}

- (void)fetch {
  //  NSString *path = [[NSBundle mainBundle] pathForResource:@"colors" ofType:@"json"];
  //  NSData *data = [NSData dataWithContentsOfFile:path];
  //  NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
  //
  //  for (NSDictionary *dict in array) {
  //    ColorsModel *m =  [[ColorsModel alloc] initWithDictionary:dict];
  //    [_models addObject:m];
  //  }
}

- (void) setupTableView {
  self.tableView = [[UITableView alloc]
                    initWithFrame:self.view.bounds
                    style:UITableViewStyleInsetGrouped];
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  [self.tableView setAlwaysBounceVertical:NO];
  self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.view addSubview:self.tableView];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return self.models.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"cell"];
  NSString *color = self.models[indexPath.row];
  cell.textLabel.text = color;
  
  
  NSUInteger index = [self.models indexOfObject:_colorText];
  
  if ([self.models[index] isEqualToString:self.colorText]) {
    if (indexPath.row == index) {
      cell.accessoryType = UITableViewCellAccessoryCheckmark;
      cell.tintColor = [UIColor colorWithHexString:_colorText];
    } else {
      cell.accessoryType = UITableViewCellAccessoryNone;
    }
  }
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  cell.textLabel.textColor = [UIColor colorWithHexString:color];
  return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:false];
  NSString *color = self.models[indexPath.row];
  self.colorText = color;
  self.didSelect(color);
  [self.navigationController popViewControllerAnimated:YES];
}
@end
