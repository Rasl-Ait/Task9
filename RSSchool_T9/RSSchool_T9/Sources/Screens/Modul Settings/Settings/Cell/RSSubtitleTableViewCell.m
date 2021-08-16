//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: rasul
// On: 8/1/21
// 
// Copyright © 2021 RSSchool. All rights reserved.

#import "RSSubtitleTableViewCell.h"

@implementation RSSubtitleTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
  if (self) {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
  }
  return self;
}

@end
