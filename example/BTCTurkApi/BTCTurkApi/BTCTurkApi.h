//
//  BTCClient.h
//  btcturk
//
//  Created by Barış Koç on 28/04/15.
//  Copyright (c) 2015 BTCTurk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTCTraderApi.h"

static NSString * const kBTCBaseURLstring = @"https://www.btcturk.com";

@interface BTCTurkApi : BTCTraderApi

+(BTCTurkApi*)shared;

@end
