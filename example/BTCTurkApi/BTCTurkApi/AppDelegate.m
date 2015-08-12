//
//  AppDelegate.m
//  BTCTurkApi
//
//  Created by Barış Koç on 12/08/15.
//  Copyright (c) 2015 BTCTrader. All rights reserved.
//

#import "AppDelegate.h"

#import "BTCTurkApi.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    BTCTurkApi *api = [BTCTurkApi shared];
    
    [api getTicker:^(BTCTicker *ticker, NSError *error) {
        NSLog(@"Ticker:");
        if (error) {
            NSLog(@"%@", [error description]);
        }
        NSLog(@"%@", ticker);
    }];
    
    
    [api getTradesLast:20 handler:^(NSArray *trades, NSError *error) {
        NSLog(@"Trades:");
        if (error) {
            NSLog(@"%@", [error description]);
        }
        NSLog(@"%@", trades);
    }];
    

    // SET YOUR API KEYS
//    api.apiKey = @"YOUR_API_KEY";
//    api.secret = @"YOUR_SECRET";
    
//    [api getAccountBalance:^(BTCAccountBalance *accountBalance, NSError *error) {
//        NSLog(@"Account Balance:");
//        if (error) {
//            NSLog(@"%@", [error description]);
//        }
//        NSLog(@"%@", accountBalance);
//    }];

//    [api getTransactionsLimit:10 offset:0 sort:BTCTraderApiSortTypeDescending handler:^(NSArray *transactions, NSError *error) {
//        NSLog(@"User Transactions:");
//        if (error) {
//            NSLog(@"%@", [error description]);
//        }
//        NSLog(@"%@", transactions);
//    }];
    
    
    return YES;
}

@end
