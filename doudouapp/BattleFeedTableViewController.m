//
//  BattleFeedTableViewController.m
//  doudouapp
//
//  Created by xiao on 4/11/17.
//  Copyright © 2017 doudouapp llc. All rights reserved.
//

#import "BattleFeedTableViewController.h"
#import "userButton.h"
#import "userProfileTableViewController.h"
@interface BattleFeedTableViewController ()

@end

@implementation BattleFeedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    return 1;
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"feed" forIndexPath:indexPath];
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    userButton *leftUser = [[userButton alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
    leftUser.userData = @"jiangnan";
    [leftUser setTitle:@"jiangnan" forState:UIControlStateNormal];
    [leftUser setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftUser addTarget:self action:@selector(jumpto:) forControlEvents:UIControlEventTouchUpInside];
    
    userButton *rightUser = [[userButton alloc] initWithFrame:CGRectMake(300, 10, 100, 20)];
    rightUser.userData = @"lilin";
    [rightUser setTitle:@"lilin" forState:UIControlStateNormal];
    [rightUser setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightUser addTarget:self action:@selector(jumpto:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell addSubview:leftUser];
    [cell addSubview:rightUser];
    // Configure the cell...
    cell.textLabel.text = @"Ahoa";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UIScreen.mainScreen.bounds.size.width;
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
