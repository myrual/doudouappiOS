//
//  AppDelegate.m
//  doudouapp
//
//  Created by xiao on 4/11/17.
//  Copyright © 2017 doudouapp llc. All rights reserved.
//

#import "AppDelegate.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    BattleFeedTableViewController *feedvc = [[BattleFeedTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    feedvc.title = @"Feed";
    FAKFontAwesome  *feedIcon = [FAKFontAwesome feedIconWithSize:20];
    UIImage *feedImage = [feedIcon imageWithSize:CGSizeMake(20, 20)];
    feedvc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Feed" image:feedImage tag:0];
    profileTableViewController *profilevc = [[profileTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    profilevc.title = @"Profile";
    FAKFontAwesome *userIcon = [FAKFontAwesome userOIconWithSize:20];
    UIImage *userImage = [userIcon imageWithSize:CGSizeMake(20, 20)];
    profilevc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Profile" image:userImage tag:1];
    maiTabViewController * rootvc = [[maiTabViewController alloc] init];
    NSArray *childvc = @[feedvc, profilevc];
    [rootvc setViewControllers:childvc];
    self.window.rootViewController = rootvc;
    //self.window.rootViewController = [[BattleFeedTableViewController alloc] initWithNibName:nil bundle:nil];
    
    
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
