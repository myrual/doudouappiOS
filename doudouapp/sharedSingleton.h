//
//  sharedSingleton.h
//  
//
//  Created by xiao on 4/15/17.
//
//

#import <foundation/Foundation.h>

@interface sharedSingleton : NSObject {
    NSString *someProperty;
}

@property (nonatomic, retain) NSString *someProperty;
@property (nonatomic, retain, readwrite) NSURL *redURL;
@property (nonatomic, retain, readwrite) NSURL *blueURL;

+ (id)sharedManager;

@end
