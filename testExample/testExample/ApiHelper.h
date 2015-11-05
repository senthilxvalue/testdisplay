//
//  ApiHelper.h
//  testExample
//
//  Created by mac on 05/11/15.
//  Copyright (c) 2015 senthil. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^listname)(NSData *data, NSURLResponse *response, NSError *error);

@interface ApiHelper : NSObject<NSURLSessionDataDelegate,NSURLSessionDelegate>

+ (void)getlistteams :(NSString *)str Block:(listname)completionBlock;

@end
