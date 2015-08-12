#import <Foundation/Foundation.h>

#import <AFNetworking/AFNetworking.h>

#import "BTCApiConstants.h"
#import "BTCModels.h"

static NSString * const kBTCNotificationDidReceive401error = @"kNotificationDidReceive401error";
static NSString * const kBTCNotificationInternetConnectionError = @"kNotificationInternetConnectionError";


@interface BTCTraderApi : AFHTTPRequestOperationManager

@property (copy, nonatomic) NSString *apiKey;
@property (copy, nonatomic) NSString *secret;


#pragma mark - Using models
- (void)getTicker:(void (^)(BTCTicker *ticker, NSError *error))block;
- (void)getOrderBook:(void (^)(BTCOrderBook *orderBook, NSError *error))block;
/// Fills array with BTCTrade instances
- (void)getTrades:(void (^)(NSArray *trades, NSError *error))block;
- (void)getTradesLast:(NSUInteger)last handler:(void (^)(NSArray *trades, NSError *error))block;

- (void)getAccountBalance:(void (^)(BTCAccountBalance *accountBalance, NSError *error))block;
/// Fills array with BTCOrder instances
- (void)getOpenOrders:(void (^)(NSArray *openOrders, NSError *error))block;
/// Fills array with BTCTransaction instances
- (void)getTransactionsLimit:(NSUInteger)limit offset:(NSUInteger)offset sort:(BTCTraderApiSortType)sort handler:(void (^)(NSArray *transactions, NSError *error))block;

- (void)buyOrder:(BTCOrder*)order handler:(void (^)(id response, NSError *error))handler;
- (void)sellOrder:(BTCOrder*)order handler:(void (^)(id response, NSError *error))handler;
- (void)cancelOrder:(BTCOrder*)order handler:(void (^)(id response, NSError *error))handler;


#pragma mark - Using raw responses
- (void)getTickerHandler:(void (^)(id response, NSError *error))handler;
- (void)getOrderBookHandler:(void (^)(id response, NSError *error))handler;
- (void)getTrades:(NSDictionary*)params handler:(void (^)(id response, NSError *error))handler;


- (void)getAccountBalanceHandler:(void (^)(id response, NSError *error))handler;
- (void)getUserTransactions:(NSDictionary*)params handler:(void (^)(id response, NSError *error))handler;
- (void)getOpenOrdersHandler:(void (^)(id response, NSError *error))handler;
- (void)cancelOrderWithOrderId:(NSString *)orderId handler:(void (^)(id response, NSError *error))handler;

@end
