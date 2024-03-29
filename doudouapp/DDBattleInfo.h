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
@property (nonatomic, readwrite) int leftVotes;
@property (nonatomic, readwrite) int rightVotes;
@property (nonatomic, readwrite) NSInteger myVote;
@property (nonatomic, readwrite) NSString *leftImage;
@property (nonatomic, readwrite) NSString *leftVideo;
@property (nonatomic, readwrite) NSString *rightImage;
@property (nonatomic, readwrite) NSString *rightVideo;
@end
