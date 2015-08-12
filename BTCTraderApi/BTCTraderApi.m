#import "BTCTraderApi.h"
#import "BTCRequestSerializer.h"



#define REQUEST_LOGGING 0
#define RESPONSE_LOGGING 0
#define MODEL_LOGGING 0
#define ERROR_LOGGING 0

#if ERROR_LOGGING
#define ERROR_LOG(fmt, ...) NSLog((@"BTCTrader ERROR LOG: %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define ERROR_LOG(...)
#endif


#if REQUEST_LOGGING
#define REQUEST_LOG(fmt, ...) NSLog((@"BTCTrader REQUEST LOG: %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define REQUEST_LOG(...)
#endif


#if MODEL_LOGGING
#define MODEL_LOG(fmt, ...) NSLog((@"BTCTrader MODEL LOG: %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define MODEL_LOG(...)
#endif


#if RESPONSE_LOGGING
#define RESPONSE_LOG(fmt, ...) NSLog((@"BTCTrader RESPONSE LOG: %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define RESPONSE_LOG(...)
#endif



@implementation BTCTraderApi

- (instancetype)initWithBaseURL:(NSURL *)url{
    self = [super initWithBaseURL:url];
    if(!self)
        return nil;
    
    BTCRequestSerializer *requestSerializer = [BTCRequestSerializer serializer];
    requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    self.requestSerializer = requestSerializer;
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/plain", @"application/json"]];
    self.securityPolicy.allowInvalidCertificates = YES;
    self.responseSerializer = responseSerializer;
    
    self.operationQueue.maxConcurrentOperationCount = 1;
    return self;
}


#pragma mark -

- (void)setApiKey:(NSString *)apiKey{
    _apiKey = [apiKey copy];
    BTCRequestSerializer *requestSerializer = (BTCRequestSerializer*)self.requestSerializer;
    requestSerializer.apiKey = apiKey;
}

- (void)setSecret:(NSString *)secret{
    _secret = [secret copy];
    BTCRequestSerializer *requestSerializer = (BTCRequestSerializer*)self.requestSerializer;
    requestSerializer.secret = secret;
}

#pragma mark - Requests using models

- (void)getTicker:(void (^)(BTCTicker *, NSError *))block{
    REQUEST_LOG();
    [self getTickerHandler:^(id response, NSError *error) {
        if (error) {
            ERROR_LOG(@"%@", [error description]);
            block(nil, error);
        }
        else{
            BTCTicker *ticker = [[BTCTicker alloc] initWithDictionary:response];
            MODEL_LOG(@"%@", ticker);
            block(ticker, error);
        }
    }];
}

- (void)getOrderBook:(void (^)(BTCOrderBook *orderBook, NSError *error))block{
    REQUEST_LOG();
    [self getOrderBookHandler:^(id response, NSError *error) {
        if (error) {
            ERROR_LOG(@"%@", [error description]);
            block(nil, error);
        }
        else{
            BTCOrderBook *orderBook = [[BTCOrderBook alloc] initWithDictionary:response];
            MODEL_LOG(@"%@", orderBook);
            block(orderBook, error);
        }
    }];
}

- (void)getAccountBalance:(void (^)(BTCAccountBalance *accountBalance, NSError *error))block{
    REQUEST_LOG();
    [self getAccountBalanceHandler:^(id response, NSError *error) {
        if (error) {
            ERROR_LOG(@"%@", [error description]);
            block(nil, error);
        }
        else{
            BTCAccountBalance *accountBalance = [[BTCAccountBalance alloc] initWithDictionary:response];
            MODEL_LOG(@"%@", accountBalance);
            block(accountBalance, error);
        }
    }];
}

- (void)getOpenOrders:(void (^)(NSArray *, NSError *))block{
    REQUEST_LOG();
    [self getOpenOrdersHandler:^(id response, NSError *error) {
        if (error) {
            ERROR_LOG(@"%@", [error description]);
            block(nil, error);
        }
        else{
            NSMutableArray *tempOrders = [[NSMutableArray alloc] initWithCapacity:[response count]];
            for (NSDictionary *orderDic in response) {
                BTCOrder *newOrder = [[BTCOrder alloc] initWithDictionary:orderDic];
                [tempOrders addObject:newOrder];
            }
            MODEL_LOG(@"%@", tempOrders);
            block([NSArray arrayWithArray:tempOrders], error);
        }
    }];
}

- (void)getTransactionsLimit:(NSUInteger)limit offset:(NSUInteger)offset sort:(BTCTraderApiSortType)sort handler:(void (^)(NSArray *, NSError *))block{
    REQUEST_LOG();
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:[NSNumber numberWithInteger:offset] forKey:@"offset"];
    [params setObject:[NSNumber numberWithInteger:limit] forKey:@"limit"];
    if (sort == BTCTraderApiSortTypeAscending) {
        [params setObject:@"asc" forKey:@"sort"];
    }
    else{
        [params setObject:@"desc" forKey:@"sort"];
    }

    
    [self getUserTransactions:params handler:^(id response, NSError *error) {
        if (error) {
            ERROR_LOG(@"%@", [error description]);
            block(nil, error);
        }
        else{
            NSMutableArray *tempTransactions = [[NSMutableArray alloc] initWithCapacity:[response count]];
            for (NSDictionary *orderDic in response) {
                BTCTransaction *newTransaction = [[BTCTransaction alloc] initWithDictionary:orderDic];
                [tempTransactions addObject:newTransaction];
            }
            MODEL_LOG(@"%@", tempTransactions);
            block([NSArray arrayWithArray:tempTransactions], error);
        }
    }];
}

- (void)getTrades:(void (^)(NSArray *trades, NSError *error))block{
    REQUEST_LOG();
    [self getTrades:nil handler:^(id response, NSError *error) {
        if (error) {
            ERROR_LOG(@"%@", [error description]);
            block(nil, error);
        }
        else{
            NSMutableArray *tempTrades = [[NSMutableArray alloc] initWithCapacity:[response count]];
            for (NSDictionary *tradeDic in response) {
                BTCTrade *newTrade = [[BTCTrade alloc] initWithDictionary:tradeDic];
                [tempTrades addObject:newTrade];
            }
            MODEL_LOG(@"%@", tempTrades);
            block([NSArray arrayWithArray:tempTrades], error);
        }
    }];
}

- (void)getTradesLast:(NSUInteger)last handler:(void (^)(NSArray *trades, NSError *error))block{
    REQUEST_LOG();
    NSDictionary *params = @{@"last": [NSNumber numberWithUnsignedInteger:last] };
    [self getTrades:params handler:^(id response, NSError *error) {
        if (error) {
            ERROR_LOG(@"%@", [error description]);
            block(nil, error);
        }
        else{
            NSMutableArray *tempTrades = [[NSMutableArray alloc] initWithCapacity:[response count]];
            for (NSDictionary *tradeDic in response) {
                BTCTrade *newTrade = [[BTCTrade alloc] initWithDictionary:tradeDic];
                [tempTrades addObject:newTrade];
            }
            MODEL_LOG(@"%@", tempTrades);
            block([NSArray arrayWithArray:tempTrades], error);
        }
    }];
}


- (void)cancelOrder:(BTCOrder*)order handler:(void (^)(id response, NSError *error))handler{
    REQUEST_LOG();
    NSParameterAssert(order.orderId != nil && ![order.orderId isEqualToString:@""]);
    [self cancelOrderWithOrderId:order.orderId handler:^(id response, NSError *error) {
        if (error) {
            ERROR_LOG(@"%@", [error description]);
        }
        handler(response, error);
    }];
}

- (void)buyOrder:(BTCOrder*)order handler:(void (^)(id response, NSError *error))handler{
    if (![order isBuyOrder]) {
        [NSException raise:@"InvalidOrderRequestException" format:@"Order type mismatch. %@", order];
    }
    else{
        [self postOrder:order handler:handler];
    }
}

- (void)sellOrder:(BTCOrder*)order handler:(void (^)(id response, NSError *error))handler{
    if (![order isSellOrder]) {
        [NSException raise:@"InvalidOrderRequestException" format:@"Order type mismatch. %@", order];
    }
    else{
        [self postOrder:order handler:handler];
    }
}

- (void)postOrder:(BTCOrder*)order handler:(void (^)(id response, NSError *error))handler{
    REQUEST_LOG();
    NSDictionary *params = [self _paramsForPostRequestWithOrder:order];
    NSLog(@"order: %@, PARAMS: %@", order, params);
    if ([order isSellOrder]) {
        [self performPOSTrequestWithURL:BTCSellOrderURL parameters:params handler:^(id response, NSError *error) {
            if (error) {
                ERROR_LOG(@"%@", [error description]);
            }
            handler(response, error);
        }];
    }
    else if([order isBuyOrder]){
        [self performPOSTrequestWithURL:BTCBuyOrderURL parameters:params handler:^(id response, NSError *error) {
            if (error) {
                ERROR_LOG(@"%@", [error description]);
            }
            handler(response, error);
        }];
    }
    else{
        [NSException raise:@"InvalidOrderRequestException" format:@"You can not post an order with unknown type. %@", order];
    }
}

- (NSDictionary*)_paramsForPostRequestWithOrder:(BTCOrder*)order{
    NSMutableDictionary *params;
    if ([order isBuyOrder]) {
        if ([order isMarketOrder]) {
            params = [self _defaultParamsForBuyMarketOrder];
            params[@"Total"] = [order.total stringValue];
        }
        else if([order isLimitOrder]){
            params = [self _defaultParamsForBuyLimitOrder];
            params[@"Amount"] = [order.amount stringValue];
            params[@"Price"] = [order.price stringValue];
        }
    }
    else if([order isSellOrder]){
        if ([order isMarketOrder]) {
            params = [self _defaultParamsForSellMarketOrder];
            params[@"Amount"] = [order.amount stringValue];
        }
        else if([order isLimitOrder]){
            params = [self _defaultParamsForSellLimitOrder];
            params[@"Amount"] = [order.amount stringValue];
            params[@"Price"] = [order.price stringValue];
        }
    }
    else{
        [NSException raise:@"InvalidOrderRequestException" format:@"You can not post an order with unknown category. %@", order];
    }
    return [NSDictionary dictionaryWithDictionary:params];
}

- (NSMutableDictionary*)_defaultParamsForBuyMarketOrder{
    return [NSMutableDictionary dictionaryWithDictionary: @{ @"IsMarketOrder":[NSNumber numberWithInt:1],
                                                             @"Price":[NSNumber numberWithInt:0],
                                                             @"Amount":[NSNumber numberWithInt:0] }];
}

- (NSMutableDictionary*)_defaultParamsForBuyLimitOrder{
    return [NSMutableDictionary dictionaryWithDictionary: @{ @"IsMarketOrder":[NSNumber numberWithInt:0],
                                                             @"Total":[NSNumber numberWithInt:0] } ];
}

- (NSMutableDictionary*)_defaultParamsForSellMarketOrder{
    return [NSMutableDictionary dictionaryWithDictionary: @{ @"IsMarketOrder":[NSNumber numberWithInt:1],
                                                             @"Price":[NSNumber numberWithInt:0],
                                                             @"Amount":[NSNumber numberWithInt:0] }];
}

- (NSMutableDictionary*)_defaultParamsForSellLimitOrder{
    return [NSMutableDictionary dictionaryWithDictionary: @{ @"IsMarketOrder":[NSNumber numberWithInt:0],
                                                             @"Total":[NSNumber numberWithInt:0] } ];
}

#pragma mark - Requests using raw responses
#pragma mark - GET
- (void)getTickerHandler:(void (^)(id response, NSError *error))handler{
    [self performGETrequestWithURL:BTCTickerURL parameters:nil handler:handler];
}

- (void)getOrderBookHandler:(void (^)(id response, NSError *error))handler{
    [self performGETrequestWithURL:BTCOrderBookURL parameters:nil handler:handler];
};

- (void)getTrades:(NSDictionary*)params handler:(void (^)(id response, NSError *error))handler{
    [self performGETrequestWithURL:BTCTradesURL parameters:params handler:handler];
}

- (void)getAccountBalanceHandler:(void (^)(id response, NSError *error))handler{
    [self performGETrequestWithURL:BTCBalanceURL parameters:nil handler:handler];
}

- (void)getUserTransactions:(NSDictionary*)params handler:(void (^)(id response, NSError *error))handler{
    [self performGETrequestWithURL:BTCUserTransactionsURL parameters:params handler:handler];
}

- (void)getOpenOrdersHandler:(void (^)(id response, NSError *error))handler{
    [self performGETrequestWithURL:BTCOpenOrdersURL parameters:nil handler:handler];
}

#pragma mark - POST

- (void)cancelOrderWithOrderId:(NSString *)orderId handler:(void (^)(id, NSError *))handler{
    NSDictionary *params = @{ @"id":orderId };
    [self performPOSTrequestWithURL:BTCCancelOrderURL parameters:params handler:handler];
}

- (void)buyOrder:(BOOL)isMarketOrder withPrice:(double)price andAmount:(double)amount andTotal:(double)total handler:(void (^)(id, NSError *))handler{
    NSMutableDictionary *params;
    if (isMarketOrder){
        params = [self _defaultParamsForBuyMarketOrder];
        params[@"Total"] = [NSNumber numberWithDouble:total];
    }
    else{
        params = [self _defaultParamsForBuyLimitOrder];
        NSString *amountString = [NSString stringWithFormat:@"%0.8f",amount];
        params[@"Amount"] = amountString;
        params[@"Price"] = [NSNumber numberWithDouble:price];
    }
    [self performPOSTrequestWithURL:BTCBuyOrderURL parameters:params handler:handler];
}

- (void)sellOrder:(BOOL)isMarketOrder withPrice:(double)price andAmount:(double)amount andTotal:(double)total handler:(void (^)(id, NSError *))handler{
    NSString *amountString = [NSString stringWithFormat:@"%0.8f", amount];
    NSDictionary *params;
    if (isMarketOrder){
        params = @{ @"IsMarketOrder":[NSNumber numberWithInt:1],
                    @"Price":[NSNumber numberWithInt:0],
                    @"Amount":amountString,
                    @"Total":[NSNumber numberWithInt:0] };
    }
    else{
        params = @{ @"IsMarketOrder":[NSNumber numberWithInt:0],
                    @"Price":[NSNumber numberWithDouble:price],
                    @"Amount":amountString,
                    @"Total":[NSNumber numberWithInt:0] };
    }
    
    [self performPOSTrequestWithURL:BTCSellOrderURL parameters:params handler:handler];
}

#pragma mark - Requests

- (AFHTTPRequestOperation*)performGETrequestWithURL:(NSString*)url parameters:(NSDictionary*)params handler:(void (^)(id response, NSError *error))handler{
    return [self GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        RESPONSE_LOG(@"%@", responseObject);
        handler(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ERROR_LOG(@"%@", [error description]);
        [self checkErrorCode:operation.response.statusCode];
        handler(nil, error);
    }];
}

- (AFHTTPRequestOperation*)performPOSTrequestWithURL:(NSString*)url parameters:(NSDictionary*)params handler:(void (^)(id response, NSError *error))handler{
    return [self POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        RESPONSE_LOG(@"%@", responseObject);
        handler(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self checkErrorCode:operation.response.statusCode];
        ERROR_LOG(@"%@", [error description]);
        handler(nil, error);
    }];
}


#pragma mark - App specific
- (void)checkErrorCode:(NSInteger)code{
    if (code == 401) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kBTCNotificationDidReceive401error object:nil];
    }
    if (code == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kBTCNotificationInternetConnectionError object:nil];
    }
}

@end
