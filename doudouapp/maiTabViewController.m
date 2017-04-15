//
//  maiTabViewController.m
//  doudouapp
//
//  Created by xiao on 4/11/17.
//  Copyright © 2017 doudouapp llc. All rights reserved.
//

#import "maiTabViewController.h"
#import "startCaptureTableViewController.h"
@interface maiTabViewController ()

@end

@implementation maiTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [addButton addTarget:self action:@selector(addLibrary) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStyleDone target:self action:@selector(addLibrary)];
    self.title = @"斗斗";
    // Do any additional setup after loading the view.
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
