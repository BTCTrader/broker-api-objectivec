//
//  BTCClient.m
//  btcturk
//
//  Created by Barış Koç on 28/04/15.
//  Copyright (c) 2015 BTCTurk. All rights reserved.
//

#import "BTCTurkApi.h"

@implementation BTCTurkApi

+ (BTCTurkApi *)shared {
    static BTCTurkApi *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[BTCTurkApi alloc] initWithBaseURL:[NSURL URLWithString:kBTCBaseURLstring]];
    });
    return _sharedClient;
}

@end
