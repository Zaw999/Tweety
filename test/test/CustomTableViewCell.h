//
//  CustomTableViewCell.h
//  test
//
//  Created by Zaw Ye Naing on 2017/07/08.
//  Copyright © 2017 Zaw Ye Naing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *uploadImage;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end
