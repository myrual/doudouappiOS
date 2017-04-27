//
//  sharedSingleton.h
//  
//
//  Created by xiao on 4/15/17.
//
//

#import <foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface sharedSingleton : NSObject {
    NSString *someProperty;
}

@property (nonatomic, retain) NSString *someProperty;
@property (nonatomic, retain, readwrite) NSURL *redURL;
@property (nonatomic, retain, readwrite) NSURL *blueURL;
@property (nonatomic, retain, readwrite) NSString *rootURL;
@property (nonatomic, retain, readwrite) NSString *apiPath;
@property (nonatomic, retain, readwrite) NSString *finalURL;
@property (nonatomic, retain, readwrite) UIImage *redAvatar;
@property (nonatomic, retain, readwrite) UIImage *blueAvatar;
@property (nonatomic, readwrite) BOOL isLoggedIn;
@property (nonatomic, readwrite, retain) NSString *userEmail;
@property (nonatomic, readwrite, retain) NSString *userToken;
@property (nonatomic, readwrite, retain) NSString *appID;
@property (nonatomic, readwrite, retain) NSString *appSecret;

+ (id)sharedManager;

@end
