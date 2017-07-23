//
//  CustomCellTableViewController.m
//  test
//
//  Created by Zaw Ye Naing on 2017/07/08.
//  Copyright © 2017 Zaw Ye Naing. All rights reserved.
//

#import "CustomCellTableViewController.h"
#import "CustomTableViewCell.h"


@interface CustomCellTableViewController ()

@end

@implementation CustomCellTableViewController
{
    NSArray *_userArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Search Bar.
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    searchBar.userInteractionEnabled = false;
    self.tableView.tableHeaderView = searchBar;
    
    // use dictionary
    NSDictionary *user1Dic =@{@"name"   : @"Beauty and The Beast",
                              @"email"  : @"@beautyandthebeast.com",
                              @"upload" : @"http://marry.net.vn/wp-content/uploads/images/1488983489-phai-dep-viet-bat-ngo-xuat-hien-trong-clip-mung-8-3-cua-nguoi-dep-va-quai-vat.jpg",
                              @"avatar" : @"avatar1"};
    
    NSDictionary *user2Dic =@{@"name"   : @"君の名",
                              @"email"  : @"@kimminoname",
                              @"upload" : @"https://images7.alphacoders.com/770/770657.jpg",
                              @"avatar" : @"avatar2"};
    
    NSDictionary *user3Dic =@{@"name"   : @"Garden of Words",
                              @"email"  : @"@gardenofwords",
                              @"upload" : @"https://www.walldevil.com/wallpapers/w09/garden-of-words-anime.jpg",
                              @"avatar" : @"avatar3"};
    
    NSDictionary *user4Dic =@{@"name"   : @"Naruto",
                              @"email"  : @"@naruto",
                              @"upload" : @"https://ibhuluimcom-a.akamaihd.net/ib.huluim.com/show/1304?region=US&size=952x536",
                              @"avatar" : @"avatar4"};
    
    NSDictionary *user5Dic =@{@"name"   : @"四月は君の嘘",
                              @"email"  : @"@yourlieinapril",
                              @"upload" : @"http://pre10.deviantart.net/e7f7/th/pre/f/2016/184/5/6/your_lie_in_april_wallpaper_ten_years_later_by_sylviayau-da8ol5n.jpg",
                              @"avatar" : @"avatar5"};
    
    NSDictionary *user6Dic =@{@"name"   : @"Your Lie in Aprils",
                              @"email"  : @"@yourlieinapril",
                              @"upload" : @"https://s-media-cache-ak0.pinimg.com/originals/67/0b/ff/670bff67b6e4f5a999edd64d2e5e4f0d.jpg",
                              @"avatar" : @"avatar6"};
    
    NSArray *userArray = @[user1Dic, user2Dic, user3Dic, user4Dic, user5Dic, user6Dic];
    
    //save to plist.
    [userArray writeToFile:[self dataFilePath:@"userArray"] atomically:YES];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CustomTableViewCell class])];
}

- (NSString *)uploadTime
{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"JST"];
    
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeZone:timeZone];
    NSLog(@"%@", [dateFormatter stringFromDate:date]);
    
    return [dateFormatter stringFromDate:date];
}

- (NSString *)dataFilePath:(NSString *)saveFileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", saveFileName]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _userArray = [NSArray arrayWithContentsOfFile:[self dataFilePath:@"userArray"]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 335;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_userArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CustomTableViewCell class]) forIndexPath:indexPath];
    
    NSDictionary *userInfo = [_userArray objectAtIndex: indexPath.row];
    
    cell.nameLabel.text = userInfo[@"name"];
    cell.emailLabel.text = userInfo[@"email"];
    cell.avatarImage.image = [UIImage imageNamed: userInfo[@"avatar"]];
    cell.timeLabel.text = [self uploadTime];
    
    [cell.uploadImage setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: userInfo[@"upload"]]] placeholderImage:[UIImage imageNamed: @"placeholder.png"] success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.uploadImage.image = image;
            
            // use cocoapod to show tap image.
            cell.uploadImage.contentMode = UIViewContentModeScaleAspectFill;
            [cell.uploadImage setupImageViewer];
            cell.uploadImage.clipsToBounds = YES;
            
        });
        
        /*
        NSData *cacheImageData = UIImagePNGRepresentation(image);
        NSMutableDictionary *cacheDic = [NSMutableDictionary dictionary];
        NSString *cacheKey = [_upload objectAtIndex: indexPath.row];
        */
        
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        
        NSLog(@"Fail");
    }];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
