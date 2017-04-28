//
//  RegLoginViewController.m
//  doudouapp
//
//  Created by xiao on 4/16/17.
//  Copyright © 2017 doudouapp llc. All rights reserved.
//

#import "RegLoginViewController.h"
#import "Masonry.h"
#import "FAKFontAwesome.h"
#import "sharedSingleton.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"

@interface RegLoginViewController ()
@property (nonatomic, strong, readwrite) UITextField *emailField;
@property (nonatomic, strong, readwrite) UITextField *passField;

@end

@implementation RegLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    self.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UILabel *mobilePhoneTitle = [[UILabel alloc] init];

    [mobilePhoneTitle setText:@"手机号或者邮箱"];
    UITextField *inputPhoneNumber = [[UITextField alloc] init];
    inputPhoneNumber.autocorrectionType = UITextAutocorrectionTypeNo;
    inputPhoneNumber.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.emailField = inputPhoneNumber;
    [inputPhoneNumber setPlaceholder:@"手机号或者邮箱"];
    [inputPhoneNumber setBackgroundColor:[UIColor lightGrayColor]];
    inputPhoneNumber.layer.cornerRadius = 5.0;
    
    UITextField *inputPassword = [[UITextField alloc] init];
    inputPassword.autocorrectionType = UITextAutocorrectionTypeNo;
    inputPassword.autocapitalizationType = UITextAutocapitalizationTypeNone;
    inputPassword.secureTextEntry = true;
    self.passField = inputPassword;
    [inputPassword setPlaceholder:@"密码"];
    [inputPassword setBackgroundColor:[UIColor lightGrayColor]];
    inputPassword.layer.cornerRadius = 5.0;

    UIButton *continueButton = [[UIButton alloc] init];
    [continueButton setBackgroundColor:[UIColor blueColor]];
    continueButton.layer.cornerRadius = 5.0;
    [continueButton setTitle:@"继续" forState:UIControlStateNormal];
    [continueButton addTarget:self action:@selector(continueWithPhone) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UILabel *orSocialLogin = [[UILabel alloc] init];
    [orSocialLogin setText:@" 或者 "];
    [orSocialLogin setTextAlignment:NSTextAlignmentCenter];
    
    FAKFontAwesome *weiboIcon = [FAKFontAwesome weiboIconWithSize:30];
    [weiboIcon addAttribute:NSForegroundColorAttributeName  value:[UIColor redColor]];
    FAKFontAwesome *wechatIcon = [FAKFontAwesome wechatIconWithSize:30];
    [wechatIcon addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor]];
    FAKFontAwesome *twitterIcon = [FAKFontAwesome twitchIconWithSize:20];
    FAKFontAwesome *facebookIcon = [FAKFontAwesome facebookIconWithSize:20];
    
    UIButton *weiboLoginBtn = [[UIButton alloc] init];
    [weiboLoginBtn setImage:[weiboIcon imageWithSize:CGSizeMake(30, 30)] forState:UIControlStateNormal];
    
    UIButton *wechatLoginBtn = [[UIButton alloc] init];
    [wechatLoginBtn setImage:[wechatIcon imageWithSize:CGSizeMake(30, 30)] forState:UIControlStateNormal];
    
    UIButton *twitterLoginBtn = [[UIButton alloc] init];
    [twitterLoginBtn setImage:[twitterIcon imageWithSize:CGSizeMake(20, 20)] forState:UIControlStateNormal];
    
    UIButton *facebookLoginBtn = [[UIButton alloc] init];
    [facebookLoginBtn setImage:[facebookIcon imageWithSize:CGSizeMake(20, 20)] forState:UIControlStateNormal];
    
    [self.view addSubview:mobilePhoneTitle];
    [self.view addSubview:continueButton];
    [self.view addSubview:inputPhoneNumber];
    [self.view addSubview:inputPassword];
    [self.view addSubview:orSocialLogin];
    [self.view addSubview:weiboLoginBtn];
    [self.view addSubview:wechatLoginBtn];
    //[self.view addSubview:twitterLoginBtn];
    //[self.view addSubview:facebookLoginBtn];
    
    [continueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.mas_centerY);
        make.left.equalTo(self.view.mas_left).offset(40);
        make.right.equalTo(self.view.mas_right).offset(-40);
        make.height.equalTo(@44);
    }];
    [inputPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(continueButton.mas_top).with.offset(-20);
        make.centerX.equalTo(self.view.mas_centerX);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.equalTo(@44);
    }];

    [inputPhoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(inputPassword.mas_top).with.offset(-20);
        make.centerX.equalTo(self.view.mas_centerX);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.equalTo(@44);
    }];
    [mobilePhoneTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(inputPassword.mas_top).with.offset(-20);
        make.centerX.equalTo(self.view.mas_centerX);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.equalTo(@44);
    }];
    

    [orSocialLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(continueButton.mas_bottom).with.offset(20);
        make.left.equalTo(self.view.mas_left).offset(50);
        make.right.equalTo(self.view.mas_right).offset(-50);
        make.height.equalTo(@20);
    }];

    
    [wechatLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(orSocialLogin.mas_bottom).with.offset(20);
        make.left.equalTo(self.view.mas_centerX).offset(20);
        make.width.equalTo(@80);
        make.height.equalTo(@44);
    }];

    [weiboLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wechatLoginBtn.mas_top);
        make.right.equalTo(self.view.mas_centerX).offset(-20);
        make.width.equalTo(@80);
        make.height.equalTo(@44);
    }];

    
    
    // Do any additional setup after loading the view.
}

-(void)continueWithPhone{
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
        sharedSingleton *myshared = [sharedSingleton sharedManager];
        myshared.isLoggedIn = true;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:true];
        hud.mode = MBProgressHUDModeText;
        [hud.label setText:@"登录成功！"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            hud.hidden = true;
            [self.navigationController popViewControllerAnimated:true];
        });
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        userSingle.isLoggedIn = false;
    }];


}

-(void)loginWithWeibo{
    sharedSingleton *myshared = [sharedSingleton sharedManager];
    myshared.isLoggedIn = true;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:true];
    hud.mode = MBProgressHUDModeText;
    [hud.label setText:@"登录成功！"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        hud.hidden = true;
        [self.navigationController popViewControllerAnimated:true];
    });
}

-(void)loginWithWeChat{
    sharedSingleton *myshared = [sharedSingleton sharedManager];
    myshared.isLoggedIn = true;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:true];
    hud.mode = MBProgressHUDModeText;
    [hud.label setText:@"登录成功！"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        hud.hidden = true;
        [self.navigationController popViewControllerAnimated:true];
    });
}
-(void)loginWithTwitter{
    sharedSingleton *myshared = [sharedSingleton sharedManager];
    myshared.isLoggedIn = true;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:true];
    hud.mode = MBProgressHUDModeText;
    [hud.label setText:@"登录成功！"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        hud.hidden = true;
        [self.navigationController popViewControllerAnimated:true];
    });
}
-(void)loginWithFaceBook{
    sharedSingleton *myshared = [sharedSingleton sharedManager];
    myshared.isLoggedIn = true;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:true];
    hud.mode = MBProgressHUDModeText;
    [hud.label setText:@"登录成功！"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        hud.hidden = true;
        [self.navigationController popViewControllerAnimated:true];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
