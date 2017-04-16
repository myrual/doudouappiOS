//
//  guessYouLikeElement.h
//  doudouapp
//
//  Created by xiao on 4/16/17.
//  Copyright © 2017 doudouapp llc. All rights reserved.
//

#ifndef guessYouLikeElement_h
#define guessYouLikeElement_h
@interface guessYouLikeElement: NSObject
@property (nonatomic, strong, readwrite) NSString *userID;
@property (nonatomic, strong, readwrite) NSString *userName;
@property (nonatomic, readwrite) BOOL followed;
@end
#endif /* guessYouLikeElement_h */
