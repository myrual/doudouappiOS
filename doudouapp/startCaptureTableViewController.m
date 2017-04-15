//
//  startCaptureTableViewController.m
//  doudouapp
//
//  Created by xiao on 4/15/17.
//  Copyright © 2017 doudouapp llc. All rights reserved.
//

#import "startCaptureTableViewController.h"
#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h> // needed for video types

@interface startCaptureTableViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, readwrite) NSInteger selectedCell;
@property (nonatomic, readwrite, retain) NSMutableArray *fileURL;
@end

@implementation startCaptureTableViewController
@synthesize selectedCell;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fileURL = [[NSMutableArray alloc] initWithCapacity:2];
    self.fileURL[0] = @"选择红队视频";
    self.fileURL[1] = @"选择蓝队视频";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(captureDone)];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

-(void) captureDone{
    [self.navigationController popViewControllerAnimated:true];
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
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]  init];
    if(indexPath.row == 0){
        [cell.textLabel setText:[self.fileURL objectAtIndex:0]];
        [cell setBackgroundColor:[UIColor redColor]];
    }
    if(indexPath.row == 1){
        [cell.textLabel setText:[self.fileURL objectAtIndex:indexPath.row]];
        [cell setBackgroundColor:[UIColor blueColor]];
    }
    // Configure the cell...
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedCell = indexPath.row;
    [self addLibrary];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
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
    self.fileURL[self.selectedCell] = [NSString stringWithFormat:@"%@", videoURL];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [self.tableView reloadData];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
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
