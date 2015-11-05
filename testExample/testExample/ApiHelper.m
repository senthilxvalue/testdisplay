//
//  ApiHelper.m
//  testExample
//
//  Created by mac on 05/11/15.
//  Copyright (c) 2015 senthil. All rights reserved.
//

#import "ApiHelper.h"
@implementation ApiHelper

+ (void)getlistteams :(NSString *)str Block:(listname)completionBlock  {
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:nil delegateQueue: [NSOperationQueue mainQueue]];
    NSURL * url = [NSURL URLWithString:@"http://api.football-data.org/alpha/soccerseasons/398/fixtures"];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];
    [urlRequest setHTTPBody:[str dataUsingEncoding:NSUTF8StringEncoding]];
    [[defaultSession dataTaskWithRequest:urlRequest completionHandler:completionBlock] resume];
}
@end
