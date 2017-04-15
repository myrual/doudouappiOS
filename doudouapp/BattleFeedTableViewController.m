//
//  BattleFeedTableViewController.m
//  doudouapp
//
//  Created by xiao on 4/11/17.
//  Copyright © 2017 doudouapp llc. All rights reserved.
//

#import "BattleFeedTableViewController.h"


@interface BattleFeedTableViewController ()
@property (nonatomic, readwrite, retain) NSArray *battleFeedDataArray;
@end

@implementation BattleFeedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DDBattleInfo *first = [[DDBattleInfo alloc] init];
    first.battleTitle = @"街头霸王";
    first.battleID = @"1111";
    first.leftUser = @"李林";
    first.rightUser = @"江南";
    first.battleTimeStamp = NSTimeIntervalSince1970;
    first.leftVotes = 1;
    first.rightVotes = 10;
    DDBattleInfo *seconds = [[DDBattleInfo alloc] init];
    seconds.battleTitle = @"RapGod";
    seconds.battleID = @"2222";
    seconds.leftUser = @"DrDre";
    seconds.rightUser = @"江南";
    seconds.battleTimeStamp = NSTimeIntervalSince1970;
    seconds.leftVotes = 1;
    seconds.rightVotes = 10;
    self.battleFeedDataArray = [NSArray arrayWithObjects:first, seconds, nil];
    
    self.title = @"Feed";
    
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
    return self.battleFeedDataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(void) jumpto:(userButton *) sender{
    NSLog(@"jumpto");
    userProfileTableViewController *vc = [[userProfileTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    vc.userName = sender.userData;
    [self.navigationController pushViewController:vc animated:true];
}

-(void) voteFor:(voteButton *) sender{
    NSLog(@"jumpto");
    userProfileTableViewController *vc = [[userProfileTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    vc.userName = sender.battleID;

    for(NSInteger i = 0; i < self.battleFeedDataArray.count; i++){
        DDBattleInfo *voteCellBattle = [self.battleFeedDataArray objectAtIndex:i];
        if([voteCellBattle.battleID isEqualToString:sender.battleID]){
            if(sender.needMirror){
                voteCellBattle.rightVotes = voteCellBattle.rightVotes + 1;
                voteCellBattle.myVote = 2;
            }else{
                voteCellBattle.leftVotes = voteCellBattle.leftVotes + 1;
                voteCellBattle.myVote = 1;
            }
            NSIndexSet *toReload = [NSIndexSet indexSetWithIndex:i];
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:true];
            hud.mode = MBProgressHUDModeText;
            [hud.label setText:@"感谢投票"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                hud.hidden = true;
            });
            
            
            [self.tableView reloadSections:toReload withRowAnimation:UITableViewRowAnimationNone];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"feed" forIndexPath:indexPath];
    DDBattleInfo *thisBattleInfo = [self.battleFeedDataArray objectAtIndex:indexPath.section];
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    userButton *leftUser = [[userButton alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
    leftUser.userData = thisBattleInfo.leftUser;
    [leftUser setTitle:thisBattleInfo.leftUser forState:UIControlStateNormal];
    [leftUser setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftUser addTarget:self action:@selector(jumpto:) forControlEvents:UIControlEventTouchUpInside];
    
    userButton *rightUser = [[userButton alloc] initWithFrame:CGRectMake(300, 10, 100, 20)];
    rightUser.userData = thisBattleInfo.rightUser;
    [rightUser setTitle:thisBattleInfo.rightUser forState:UIControlStateNormal];
    [rightUser setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightUser addTarget:self action:@selector(jumpto:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell addSubview:leftUser];
    [cell addSubview:rightUser];
    [leftUser mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.mas_top).with.offset(5);
        make.left.equalTo(cell.mas_left).with.offset(10);
        make.width.greaterThanOrEqualTo(@10);
        make.height.greaterThanOrEqualTo(@20);
    }];
    
    [rightUser mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.mas_top).with.offset(5);
        make.right.equalTo(cell.mas_right).with.offset(-10);
        make.width.greaterThanOrEqualTo(@10);
        make.height.greaterThanOrEqualTo(@20);
    }];
    
    UILabel *VSLabel = [[UILabel alloc] init];
    [VSLabel setText:@"VS"];
    
    [cell addSubview:VSLabel];
    [VSLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(rightUser.mas_centerY);
        make.centerX.equalTo(cell.mas_centerX);
        make.width.greaterThanOrEqualTo(@10);
        make.height.greaterThanOrEqualTo(@20);
    }];
    
    UILabel *battleTitle = [[UILabel alloc] init];
    [battleTitle setText:thisBattleInfo.battleTitle];
    
    [cell addSubview:battleTitle];
    [battleTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(cell.mas_bottom).with.offset(-5);
        make.left.equalTo(cell.mas_left).with.offset(5);
        make.width.greaterThanOrEqualTo(@30);
        make.height.equalTo(@20);
    }];
    
    UILabel *leftVotes = [[UILabel alloc] init];
    UILabel *rightVotes = [[UILabel alloc] init];
    
    [leftVotes setText:[NSString stringWithFormat:@"%d", thisBattleInfo.leftVotes]];
    [rightVotes setText:[NSString stringWithFormat:@"%d", thisBattleInfo.rightVotes]];
    
    
    [cell addSubview:leftVotes];
    [cell addSubview:rightVotes];
    

    
    FAKFontAwesome *whiteThumbsUp_unselect = [FAKFontAwesome thumbsUpIconWithSize:20];
    [whiteThumbsUp_unselect addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
    
    FAKFontAwesome *redThumbsUp = [FAKFontAwesome thumbsUpIconWithSize:20];
    [redThumbsUp addAttribute:NSForegroundColorAttributeName value:[UIColor redColor]];

    FAKFontAwesome *blueThumbsUp = [FAKFontAwesome thumbsUpIconWithSize:20];
    [blueThumbsUp addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor]];
    
    
    voteButton *leftThumbsUp = [[voteButton alloc] init];
    leftThumbsUp.layer.cornerRadius = 15;
    leftThumbsUp.backgroundColor = [UIColor redColor];
    leftThumbsUp.needMirror = false;
    leftThumbsUp.battleID = thisBattleInfo.battleID;
    leftThumbsUp.userID = thisBattleInfo.leftUser;

    
    [cell addSubview:leftThumbsUp];
    [leftThumbsUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(battleTitle.mas_top).with.offset(-5);
        make.left.equalTo(cell.mas_left).with.offset(10);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
    
    
    voteButton *rightThumbsUp = [[voteButton alloc] init];
    rightThumbsUp.layer.cornerRadius = 15;
    rightThumbsUp.backgroundColor = [UIColor blueColor];
    rightThumbsUp.needMirror = true;
    rightThumbsUp.battleID = thisBattleInfo.battleID;
    rightThumbsUp.userID = thisBattleInfo.rightUser;
    UIImage * rightThumb = [UIImage imageWithCGImage:[redThumbsUp imageWithSize:CGSizeMake(20, 20)].CGImage scale:1 orientation:UIImageOrientationUpMirrored];
    UIImage * rightthumb_unselect = [UIImage imageWithCGImage:[whiteThumbsUp_unselect imageWithSize:CGSizeMake(20, 20)].CGImage scale:1 orientation:UIImageOrientationUpMirrored];

    leftThumbsUp.hidden = false;
    rightThumbsUp.hidden = false;

    if(thisBattleInfo.myVote == 0){
        [rightThumbsUp addTarget:self action:@selector(voteFor:) forControlEvents:UIControlEventTouchUpInside];
        [leftThumbsUp addTarget:self action:@selector(voteFor:) forControlEvents:UIControlEventTouchUpInside];
        
        [rightThumbsUp setBackgroundColor:[UIColor redColor]];
        [leftThumbsUp setBackgroundColor:[UIColor blueColor]];
        
        [rightThumbsUp setImage:rightthumb_unselect forState:UIControlStateNormal];
        [leftThumbsUp setImage: [whiteThumbsUp_unselect imageWithSize:CGSizeMake(20, 20)] forState:UIControlStateNormal];
    }
    
    if(thisBattleInfo.myVote == 1){
        [leftThumbsUp setImage:[blueThumbsUp imageWithSize:CGSizeMake(20, 20)] forState:UIControlStateNormal];
        [leftThumbsUp setBackgroundColor:[UIColor whiteColor]];
        rightThumbsUp.hidden = true;
    }
    
    if(thisBattleInfo.myVote == 2){
        leftThumbsUp.hidden = true;
        [rightThumbsUp setImage:rightThumb forState:UIControlStateNormal];
        [rightThumbsUp setBackgroundColor:[UIColor whiteColor]];

    }else{
        [rightThumbsUp setImage:rightthumb_unselect forState:UIControlStateNormal];
        [rightThumbsUp setBackgroundColor:[UIColor redColor]];

    }
    
    [cell addSubview:rightThumbsUp];
    [rightThumbsUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(battleTitle.mas_top).with.offset(-5);
        make.right.equalTo(cell.mas_right).with.offset(-10);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
    

    [leftVotes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(battleTitle.mas_top).with.offset(-5);
        make.left.equalTo(leftThumbsUp.mas_right).with.offset(5);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    
    [rightVotes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(battleTitle.mas_top).with.offset(-5);
        make.right.equalTo(rightThumbsUp.mas_left).with.offset(-5);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    
    UIView *progressRed = [[UIView alloc] init];
    progressRed.backgroundColor = [UIColor redColor];
    UIView *progressBlue = [[UIView alloc] init];
    progressBlue.backgroundColor = [UIColor blueColor];
    
    [cell addSubview:progressRed];
    [cell addSubview:progressBlue];
    
    [progressBlue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(leftVotes.mas_bottom);
        make.left.equalTo(leftVotes.mas_right).with.offset(5);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];

    [progressRed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(rightVotes.mas_bottom);
        make.right.equalTo(rightVotes.mas_left).with.offset(-5);
        make.left.equalTo(leftVotes.mas_right).with.offset(5);
        make.height.equalTo(@20);
    }];
    
    

    
    // Configure the cell...
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UIScreen.mainScreen.bounds.size.width + 40;
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
