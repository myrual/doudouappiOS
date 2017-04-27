//
//  BattleFeedTableViewController.m
//  doudouapp
//
//  Created by xiao on 4/11/17.
//  Copyright © 2017 doudouapp llc. All rights reserved.
//

#import "BattleFeedTableViewController.h"
#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h> // needed for video types
#import "sharedSingleton.h"
#import "RegLoginViewController.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
@interface BattleFeedTableViewController ()<UIImagePickerControllerDelegate, AVPlayerViewControllerDelegate>
@property (nonatomic, readwrite, retain) NSMutableArray *battleFeedDataArray;
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
    first.leftVotes = 5;
    first.rightVotes = 5;
    DDBattleInfo *seconds = [[DDBattleInfo alloc] init];
    seconds.battleTitle = @"RapGod";
    seconds.battleID = @"2222";
    seconds.leftUser = @"DrDre";
    seconds.rightUser = @"江南";
    seconds.battleTimeStamp = NSTimeIntervalSince1970;
    seconds.leftVotes = 1;
    seconds.rightVotes = 10;
    self.battleFeedDataArray = [NSMutableArray arrayWithObjects:first, seconds, nil];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [addButton addTarget:self action:@selector(addLibrary) forControlEvents:UIControlEventTouchUpInside];
    
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStyleDone target:self action:@selector(addLibrary)];
    
    self.title = @"Feed";
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
#if 1

    sharedSingleton *userSingle = [sharedSingleton sharedManager];
    NSString *finalURLString = userSingle.rootURL;
    userSingle.appID = @"doudouAppiOS";
    userSingle.appSecret = @"doudouAppiOSSecret145";
    userSingle.userEmail = @"admin@test.com";
    NSString *loginURLString = [finalURLString stringByAppendingString:@"users/sign_in.json"];
    NSString *feedURLString = [userSingle.finalURL stringByAppendingString:@"battles.json"];
    NSDictionary *loginparameters = @{@"appid": userSingle.appID, @"appsecret":userSingle.appSecret, @"email": userSingle.userEmail,@"password":@"123456"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:loginURLString parameters:loginparameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSDictionary *response = responseObject;

        NSString *auth_token = [response objectForKey:@"authentication_token"];
        userSingle.userToken = auth_token;
        NSDictionary *tokenparameters = @{@"appid": userSingle.appID, @"appsecret":userSingle.appSecret, @"user_email": userSingle.userEmail,@"user_token":userSingle.userToken};

        [manager GET:feedURLString parameters:tokenparameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            NSDictionary *battleFeedResponse = responseObject;
            DDBattleInfo *fetched = [[DDBattleInfo alloc] init];
            fetched.battleTitle = [battleFeedResponse objectForKey:@"title"];
            fetched.battleID = [battleFeedResponse objectForKey:@"id"];
            fetched.leftUser = @"李林";
            fetched.rightUser = @"江南";
            fetched.battleTimeStamp = NSTimeIntervalSince1970;
            fetched.leftVotes = [[battleFeedResponse objectForKey:@"leftCount"] integerValue];
            fetched.rightVotes = [[battleFeedResponse objectForKey:@"rightCount"] integerValue];
            fetched.leftImage = [battleFeedResponse objectForKey:@"leftImage"];
            fetched.leftVideo = [battleFeedResponse objectForKey:@"leftVideo"];
            fetched.rightImage = [battleFeedResponse objectForKey:@"rightImage"];
            fetched.rightVideo = [battleFeedResponse objectForKey:@"rightVideo"];

            [self.battleFeedDataArray replaceObjectAtIndex:0 withObject:fetched];
            [self.tableView reloadData];

        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];

    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
#endif
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

-(void)addLibrary{
    // Present videos from which to choose
    UIImagePickerController *videoPicker = [[UIImagePickerController alloc] init];
    videoPicker.delegate = self; // ensure you set the delegate so when a video is chosen the right method can be called
    
    videoPicker.modalPresentationStyle = UIModalPresentationCurrentContext;
    // This code ensures only videos are shown to the end user
    videoPicker.mediaTypes = @[(NSString*)kUTTypeMovie, (NSString*)kUTTypeAVIMovie, (NSString*)kUTTypeVideo, (NSString*)kUTTypeMPEG4];
    
    videoPicker.videoQuality = UIImagePickerControllerQualityTypeHigh;
    [self presentViewController:videoPicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    // This is the NSURL of the video object
    NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
    
    NSLog(@"VideoURL = %@", videoURL);
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
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

    //NSString *finalURLString = @"https://dd.doudouapp.com";
    sharedSingleton *myshared = [sharedSingleton sharedManager];
    NSString *finalURLString = myshared.finalURL;
    if (myshared.isLoggedIn == false) {
        RegLoginViewController *vc = [[RegLoginViewController alloc] init];
        [self.navigationController pushViewController:vc animated:true];
        return;
    }
    
    sharedSingleton *userSingle = [sharedSingleton sharedManager];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *voteWithBattleURL = [NSString stringWithFormat:@"/battles/%@/%@", sender.battleID, sender.voteURL];
    NSString *voteURL = [finalURLString stringByAppendingString:voteWithBattleURL];
    NSDictionary *tokenparameters = @{@"appid": userSingle.appID, @"appsecret":userSingle.appSecret, @"user_email": userSingle.userEmail,@"user_token":userSingle.userToken};
    
    NSLog(@"vote url is %@ with parameter %@", voteURL, tokenparameters);
    [manager POST:voteURL parameters:tokenparameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSDictionary *responseDict = responseObject;
        NSNumber *statusCode = [responseDict objectForKey:@"status"];
        if([statusCode integerValue] == 200){
            NSDictionary *battleFeedResponse = responseObject;
            DDBattleInfo *fetched = [[DDBattleInfo alloc] init];
            fetched.battleTitle = [battleFeedResponse objectForKey:@"title"];
            fetched.battleID = [battleFeedResponse objectForKey:@"id"];
            fetched.leftUser = @"李林";
            fetched.rightUser = @"江南";
            fetched.battleTimeStamp = NSTimeIntervalSince1970;
            fetched.leftVotes = [[battleFeedResponse objectForKey:@"leftCount"] integerValue];
            fetched.rightVotes = [[battleFeedResponse objectForKey:@"rightCount"] integerValue];
            fetched.leftImage = [battleFeedResponse objectForKey:@"leftImage"];
            fetched.leftVideo = [battleFeedResponse objectForKey:@"leftVideo"];
            fetched.rightImage = [battleFeedResponse objectForKey:@"rightImage"];
            fetched.rightVideo = [battleFeedResponse objectForKey:@"rightVideo"];
            
            [self.battleFeedDataArray replaceObjectAtIndex:0 withObject:fetched];
            [self.tableView reloadData];
        }

        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    NSLog(@"jumpto");
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    sharedSingleton *myshared = [sharedSingleton sharedManager];

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
    if(thisBattleInfo.leftImage != nil && thisBattleInfo.rightImage != nil){
        UIImageView *leftUserAvatar = [[UIImageView alloc] init];
        NSURL *leftURL = [NSURL URLWithString:[thisBattleInfo.leftImage stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
    

        
        [leftUserAvatar setImageWithURL:leftURL];
        leftUserAvatar.layer.cornerRadius = 15;
        leftUserAvatar.layer.masksToBounds = YES;
        UIImageView *rightUserAvatar = [[UIImageView alloc] init];
        NSURL *rightURL = [NSURL URLWithString:[thisBattleInfo.rightImage stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];

        [rightUserAvatar setImageWithURL:rightURL];
        rightUserAvatar.layer.cornerRadius = 15;
        rightUserAvatar.layer.masksToBounds = YES;
        [cell addSubview:leftUserAvatar];
        [cell addSubview:rightUserAvatar];
        
        [leftUserAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.mas_top).with.offset(5);
            make.left.equalTo(cell.mas_left).with.offset(10);
            make.width.equalTo(@30);
            make.height.equalTo(@30);
        }];
        
        [rightUserAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.mas_top).with.offset(5);
            make.right.equalTo(cell.mas_right).with.offset(-10);
            make.width.equalTo(@30);
            make.height.equalTo(@30);
        }];
        
        [leftUser mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(leftUserAvatar.mas_top).with.offset(5);
            make.left.equalTo(leftUserAvatar.mas_right).with.offset(10);
            make.width.greaterThanOrEqualTo(@10);
            make.height.equalTo(@30);
        }];
        
        [rightUser mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(rightUserAvatar.mas_top).with.offset(5);
            make.right.equalTo(rightUserAvatar.mas_left).with.offset(-10);
            make.width.greaterThanOrEqualTo(@10);
            make.height.greaterThanOrEqualTo(@30);
        }];
        
    }else{
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
    }
    
    UILabel *VSLabel = [[UILabel alloc] init];
    [VSLabel setText:@"VS"];
    [VSLabel setTextColor:[UIColor redColor]];
    
    [cell addSubview:VSLabel];
    [VSLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(rightUser.mas_centerY);
        make.centerX.equalTo(cell.mas_centerX);
        make.width.greaterThanOrEqualTo(@10);
        make.height.equalTo(@20);
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
    


    if(thisBattleInfo.leftVideo != nil && thisBattleInfo.rightVideo){
        NSURL *leftURL = [NSURL URLWithString:[thisBattleInfo.leftVideo stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
        AVPlayer *redPlayer = [[AVPlayer alloc] initWithURL:leftURL];
        AVPlayerViewController *red_vc = [[AVPlayerViewController alloc] init];
        red_vc.player = redPlayer;

        NSURL *rightURL = [NSURL URLWithString:[thisBattleInfo.rightVideo stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];

        AVPlayer *bluePlayer = [[AVPlayer alloc] initWithURL:rightURL];
        AVPlayerViewController *blue_vc = [[AVPlayerViewController alloc] init];
        blue_vc.player = bluePlayer;
        
        [self addChildViewController:red_vc];
        [self addChildViewController:blue_vc];
        
        [cell addSubview:red_vc.view];
        [cell addSubview:blue_vc.view];
        
        [red_vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(VSLabel.mas_bottom).with.offset(5);
            make.left.equalTo(cell.mas_left);
            make.right.equalTo(cell.mas_centerX);
            make.height.equalTo(@280);
        }];
        [blue_vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(VSLabel.mas_bottom).with.offset(5);
            make.left.equalTo(cell.mas_centerX);
            make.right.equalTo(cell.mas_right);
            make.height.equalTo(@280);
        }];
    }
    
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
    leftThumbsUp.voteURL = @"follow_left_video.json";
    
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
    rightThumbsUp.voteURL = @"follow_right_video.json";
    
    UIImage * rightThumb = [UIImage imageWithCGImage:[redThumbsUp imageWithSize:CGSizeMake(20, 20)].CGImage scale:1.2 orientation:UIImageOrientationUpMirrored];
    UIImage * rightthumb_unselect = [UIImage imageWithCGImage:[whiteThumbsUp_unselect imageWithSize:CGSizeMake(20, 20)].CGImage scale:1.2 orientation:UIImageOrientationUpMirrored];

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
    
    CGFloat totalVotes = 1.0 * thisBattleInfo.leftVotes + thisBattleInfo.rightVotes * 1.0;
    CGFloat percentage = thisBattleInfo.leftVotes * 100.0 /totalVotes;

    CGFloat everySpace = ([UIScreen mainScreen].bounds.size.width - 160)/ 100 *1.0;
    CGFloat totalBlueSpace = percentage * everySpace;
    NSLog(@"totalBlue space is %f", totalBlueSpace);
    [progressBlue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(leftVotes.mas_bottom);
        make.left.equalTo(leftVotes.mas_right).with.offset(5);
        make.width.mas_equalTo(totalBlueSpace);
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
