//
//  DDBattleInfo.h
//  doudouapp
//
//  Created by xiao on 4/15/17.
//  Copyright © 2017 doudouapp llc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDBattleInfo : NSObject
@property (nonatomic, strong, readwrite) NSString *leftUser;
@property (nonatomic, strong, readwrite) NSString *rightUser;
@property (nonatomic, strong, readwrite) NSString *battleTitle;
@property (nonatomic, strong, readwrite) NSString *battleID;
@property (nonatomic, readwrite) NSTimeInterval battleTimeStamp;
@property (nonatomic, readwrite) NSInteger leftVotes;
@property (nonatomic, readwrite) NSInteger rightVotes;
@property (nonatomic, readwrite) NSInteger myVote;
@end
