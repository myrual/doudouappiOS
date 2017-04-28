//
//  profileTableViewController.m
//  doudouapp
//
//  Created by xiao on 4/11/17.
//  Copyright © 2017 doudouapp llc. All rights reserved.
//

#import "profileTableViewController.h"
#import "sharedSingleton.h"
#import "Masonry.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"


@interface profileTableViewController ()
@property (nonatomic, strong, readwrite) UITextField *emailField;
@property (nonatomic, strong, readwrite) UITextField *passField;
@end

@implementation profileTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Profile";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableView setContentInset:UIEdgeInsetsMake(50,0,0,0)];
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
    sharedSingleton *myshared = [sharedSingleton sharedManager];
    if(section == 0){
        if(myshared.isLoggedIn == false){
            return 3;
        }else{
            return 2;
        }
    }
    return 0;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    sharedSingleton *myshared = [sharedSingleton sharedManager];

    if(section == 0){
        return @"Profile";
    }
    if(section == 1){
        return @"Profile";
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    if(indexPath.section == 0){
        sharedSingleton *myshared = [sharedSingleton sharedManager];
        if(myshared.isLoggedIn == false){
            if(indexPath.row == 0){
                [cell.textLabel setText:@"email"];
                UITextField *field = [[UITextField alloc] init];
                [field setPlaceholder:@"email"];
                field.autocorrectionType = FALSE;
                field.autocapitalizationType = FALSE;
                field.keyboardType = UIKeyboardTypeEmailAddress;
                [cell addSubview:field];
                [field mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(cell.mas_top);
                    make.right.equalTo(cell.mas_right).with.offset(-10);
                    make.width.equalTo(cell.mas_width).with.offset(-120);
                    make.bottom.equalTo(cell.mas_bottom);
                }];
                self.emailField = field;
            }
            if(indexPath.row == 1){
                [cell.textLabel setText:@"password"];
                UITextField *field = [[UITextField alloc] init];
                self.passField = field;
                [field setPlaceholder:@"password"];
                field.autocorrectionType = FALSE;
                field.autocapitalizationType = FALSE;
                field.keyboardType = UIKeyboardTypeEmailAddress;
                [cell addSubview:field];
                [field mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(cell.mas_top);
                    make.right.equalTo(cell.mas_right).with.offset(-10);
                    make.width.equalTo(cell.mas_width).with.offset(-120);
                    make.bottom.equalTo(cell.mas_bottom);
                }];
            }
            if(indexPath.row == 2){
                UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                [loginButton setTitle:@"Login" forState:UIControlStateNormal];
                [cell addSubview:loginButton];
                [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(cell.mas_top);
                    make.right.equalTo(cell.mas_right).with.offset(-20);
                    make.left.equalTo(cell.mas_left).with.offset(20);
                    make.bottom.equalTo(cell.mas_bottom);
                }];
                [loginButton addTarget:self action:@selector(addLibrary) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        else{
            if(indexPath.row == 0){
                sharedSingleton *myshared = [sharedSingleton sharedManager];
                [cell.textLabel setText:myshared.userEmail];
                [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
            }
            if(indexPath.row == 1){
                UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                [logoutButton setTitle:@"Logout" forState:UIControlStateNormal];
                [cell addSubview:logoutButton];
                [logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(cell.mas_top);
                    make.right.equalTo(cell.mas_right).with.offset(-20);
                    make.left.equalTo(cell.mas_left).with.offset(20);
                    make.bottom.equalTo(cell.mas_bottom);
                }];
                [logoutButton addTarget:self action:@selector(addLibrary) forControlEvents:UIControlEventTouchUpInside];
            }
        }
    }
    
    // Configure the cell...
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    sharedSingleton *myshared = [sharedSingleton sharedManager];
    if(indexPath.section == 0){
        if(myshared.isLoggedIn == false){
            if(indexPath.row == 2){
                [self addLibrary];
            }
        }else{
            if(indexPath.row == 1){
                sharedSingleton *userSingle = [sharedSingleton sharedManager];
                userSingle.isLoggedIn = false;
                [self.tableView reloadData];
            }
        }
    }
}

-(void)addLibrary{
    sharedSingleton *userSingle = [sharedSingleton sharedManager];
    NSString *loginURLString = [userSingle.rootURL stringByAppendingString:@"users/sign_in.json"];
    userSingle.appID = @"doudouAppiOS";
    userSingle.appSecret = @"doudouAppiOSSecret145";
    userSingle.userEmail = self.emailField.text;
    NSString *inputPassString = self.passField.text;
    NSDictionary *loginparameters = @{@"appid": userSingle.appID, @"appsecret":userSingle.appSecret, @"email": userSingle.userEmail,@"password":inputPassString};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:loginURLString parameters:loginparameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSDictionary *response = responseObject;
        NSString *auth_token = [response objectForKey:@"authentication_token"];
        userSingle.userToken = auth_token;
        NSDictionary *tokenparameters = @{@"appid": userSingle.appID, @"appsecret":userSingle.appSecret, @"user_email": userSingle.userEmail,@"user_token":userSingle.userToken};
        userSingle.isLoggedIn = true;
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        userSingle.isLoggedIn = false;
    }];
}

-(void) logoutAction{
    sharedSingleton *userSingle = [sharedSingleton sharedManager];
    userSingle.isLoggedIn = false;
    [self.tableView reloadData];
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
