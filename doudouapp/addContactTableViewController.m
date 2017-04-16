//
//  addContactTableViewController.m
//  doudouapp
//
//  Created by xiao on 4/16/17.
//  Copyright © 2017 doudouapp llc. All rights reserved.
//

#import "addContactTableViewController.h"
#import "guessYouLikeElement.h"
#import "FAKFontAwesome.h"

@interface addContactTableViewController ()
@property (nonatomic, retain, readwrite) NSMutableArray *guessYouLike;
@end

@implementation addContactTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.guessYouLike = [[NSMutableArray alloc] init];
    guessYouLikeElement *firstGuess = [[guessYouLikeElement alloc]  init];
    guessYouLikeElement *secondGuess = [[guessYouLikeElement alloc] init];
    
    firstGuess.userID = @"111";
    firstGuess.userName = @"DrDre";
    firstGuess.followed = true;
    
    secondGuess.userID = @"222";
    secondGuess.userName = @"Jay-Z";
    secondGuess.followed = true;
    
    [self.guessYouLike addObject:firstGuess];
    [self.guessYouLike addObject:secondGuess];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"邀请朋友一起玩";
    }
    if (section == 1) {
        return @"推荐你关注";
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section  == 0){
        return 3;
    }
    if(section == 1){
        return self.guessYouLike.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]  init];
    
    if(indexPath.section == 0){
        if (indexPath.row == 0) {
            FAKFontAwesome *wechatIcon = [FAKFontAwesome wechatIconWithSize:20];
            [wechatIcon addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor]];

            NSAttributedString * weChatIconString = [wechatIcon attributedString];
            NSMutableAttributedString *wechatTitle = [[NSMutableAttributedString alloc] initWithAttributedString:weChatIconString];
            NSAttributedString *addFrom = [[NSMutableAttributedString alloc] initWithString:@" 从微信添加"];
            [wechatTitle appendAttributedString:addFrom];
            [cell.textLabel setAttributedText:wechatTitle];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.row == 1) {
            FAKFontAwesome *weiboIcon = [FAKFontAwesome weiboIconWithSize:20];
            [weiboIcon addAttribute:NSForegroundColorAttributeName value:[UIColor redColor]];
            
            NSAttributedString * weiboIconString = [weiboIcon attributedString];
            NSMutableAttributedString *weiboTitle = [[NSMutableAttributedString alloc] initWithAttributedString:weiboIconString];
            NSAttributedString *addFrom = [[NSMutableAttributedString alloc] initWithString:@" 从微博添加"];
            [weiboTitle appendAttributedString:addFrom];
            [cell.textLabel setAttributedText:weiboTitle];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.row == 2) {
            FAKFontAwesome *qqIcon = [FAKFontAwesome qqIconWithSize:20];
            [qqIcon addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor]];
            
            NSAttributedString * qqIconString = [qqIcon attributedString];
            NSMutableAttributedString *qqTitle = [[NSMutableAttributedString alloc] initWithAttributedString:qqIconString];
            NSAttributedString *addFrom = [[NSMutableAttributedString alloc] initWithString:@" 从QQ添加"];
            [qqTitle appendAttributedString:addFrom];
            [cell.textLabel setAttributedText:qqTitle];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    if(indexPath.section == 1){
        guessYouLikeElement *thisElement = [self.guessYouLike objectAtIndex:indexPath.row];
        [cell.textLabel setText: thisElement.userName];
        if (thisElement.followed) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    // Configure the cell...
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NSLog(@"wechat");
        }
        if (indexPath.row == 1) {
            NSLog(@"wechat");
        }
        if (indexPath.row == 2) {
            NSLog(@"wechat");
        }
    }
    if (indexPath.section == 1) {
        guessYouLikeElement *thisElement = [self.guessYouLike objectAtIndex:indexPath.row];
        thisElement.followed = !thisElement.followed;
        [self.tableView beginUpdates];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView endUpdates];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
