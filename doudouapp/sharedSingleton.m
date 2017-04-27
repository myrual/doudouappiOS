//
//  sharedSingleton.m
//  
//
//  Created by xiao on 4/15/17.
//
//

#import "sharedSingleton.h"

@implementation sharedSingleton

@synthesize someProperty;
@synthesize redURL;
@synthesize blueURL;
@synthesize userEmail;
@synthesize userToken;
@synthesize appID;
@synthesize appSecret;

#pragma mark Singleton Methods

+ (id)sharedManager {
    static sharedSingleton *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        someProperty = [[NSString alloc] initWithString:@"Default Property Value"];
        redURL = nil;
        blueURL = nil;
        //_rootURL = @"https://dd.doudouapp.com";
        //_rootURL = @"https://dry-fjord-76939.herokuapp.com/";
        _rootURL = @"https://lin-rails-tt-myrual.c9users.io/";
        _apiPath = @"api/v1/";
        _finalURL = [_rootURL stringByAppendingString:_apiPath];
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end
