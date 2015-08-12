extern NSString *const BTCTickerURL;
extern NSString *const BTCOrderBookURL;
extern NSString *const BTCTradesURL;
extern NSString *const BTCBalanceURL;
extern NSString *const BTCUserTransactionsURL;
extern NSString *const BTCOpenOrdersURL;
extern NSString *const BTCCancelOrderURL;
extern NSString *const BTCBuyOrderURL;
extern NSString *const BTCSellOrderURL;


typedef NS_ENUM(NSUInteger, BTCTraderApiSortType) {
    BTCTraderApiSortTypeAscending = 0,
    BTCTraderApiSortTypeDescending = 1
};

typedef NS_ENUM(NSUInteger, BTCTraderErrorCode) {
    BTCTraderErrorCode400 = 400,
    BTCTraderErrorCode500 = 500,
    BTCTraderErrorCode501 = 501,
    BTCTraderErrorCode502 = 502,
    BTCTraderErrorCode503 = 503,
    BTCTraderErrorCode504 = 504,
    BTCTraderErrorCode505 = 505,
    BTCTraderErrorCode506 = 506,
    BTCTraderErrorCode600 = 600,
    BTCTraderErrorCode601 = 601,
    BTCTraderErrorCode602 = 602,
    BTCTraderErrorCode603 = 603,
    BTCTraderErrorCode604 = 604,
    BTCTraderErrorCode605 = 605
};
