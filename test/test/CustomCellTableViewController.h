//
//  CustomCellTableViewController.h
//  test
//
//  Created by Zaw Ye Naing on 2017/07/08.
//  Copyright © 2017 Zaw Ye Naing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
#import "UIImageView+MHFacebookImageViewer.h"


@interface CustomCellTableViewController : UITableViewController <UIGestureRecognizerDelegate>


@property (nonatomic, strong) UIImageView *imageView;
@end
