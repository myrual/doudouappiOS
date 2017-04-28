//
//  maiTabViewController.m
//  doudouapp
//
//  Created by xiao on 4/11/17.
//  Copyright © 2017 doudouapp llc. All rights reserved.
//

#import "maiTabViewController.h"
#import "startCaptureTableViewController.h"
#import "FAKFontAwesome.h"
#import "Masonry.h"
#import "addContactTableViewController.h"
@interface maiTabViewController ()
@end

@implementation maiTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [addButton addTarget:self action:@selector(addLibrary) forControlEvents:UIControlEventTouchUpInside];
    

    FAKFontAwesome *addFont = [FAKFontAwesome plusIconWithSize:20];
    UIBarButtonItem *plusButton = [[UIBarButtonItem alloc] initWithImage:[addFont imageWithSize:CGSizeMake(20, 20)] style:UIBarButtonItemStyleDone target:self action:@selector(addContact)];
    
    //self.navigationItem.rightBarButtonItem = plusButton;
    
    self.title = @"斗斗";
    
    FAKFontAwesome *cameraIcon = [FAKFontAwesome cameraIconWithSize:40];
    [cameraIcon addAttribute:NSForegroundColorAttributeName value:[UIColor redColor]];
    UIButton *cameraButton = [[UIButton alloc] init];
    [cameraButton setImage:[cameraIcon imageWithSize:CGSizeMake(50, 50)] forState:UIControlStateNormal];
    [cameraButton addTarget:self action:@selector(addLibrary) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:cameraButton];
    [cameraButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.centerX.equalTo(self.tabBar.mas_centerX);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
    // Do any additional setup after loading the view.
}
-(void)addContact{
    addContactTableViewController *vc = [[addContactTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController: vc animated:true];
}

-(void)addLibrary{
    startCaptureTableViewController *vc = [[startCaptureTableViewController alloc] init];
    [self.navigationController pushViewController: vc animated:true];
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
