//
//  userButton.h
//  doudouapp
//
//  Created by xiao on 4/12/17.
//  Copyright © 2017 doudouapp llc. All rights reserved.
//

#ifndef userButton_h
#define userButton_h
#import <UIKit/UIKit.h>

@interface userButton : UIButton {
    id userData;
}

@property (nonatomic, readwrite, retain) NSString* userData;

@end

#endif /* userButton_h */
