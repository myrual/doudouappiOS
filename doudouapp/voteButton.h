//
//  voteButton.h
//  doudouapp
//
//  Created by xiao on 4/14/17.
//  Copyright © 2017 doudouapp llc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface voteButton : UIButton
@property (nonatomic, readwrite, retain) NSString *battleID;
@property (nonatomic, readwrite, retain) NSString *userID;
@property (nonatomic, readwrite) BOOL  needMirror;
@end
