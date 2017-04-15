//
//  sharedSingleton.m
//  
//
//  Created by xiao on 4/15/17.
//
//

#import <Foundation/Foundation.h>

+ (instancetype)sharedInstance
{
    static sharedSingleton *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[sharedSingleton alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}
