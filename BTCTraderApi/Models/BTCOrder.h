#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BTCOrderType) {
    BTCOrderTypeBuy = 0,
    BTCOrderTypeSell = 1,
    BTCOrderTypeUnknown = 999
};

typedef NS_ENUM(NSUInteger, BTCOrderCategory) {
    BTCOrderCategoryLimit = 0,
    BTCOrderCategoryMarket = 1,
    BTCOrderCategoryUnknown = 999
};


@interface BTCOrder : NSObject

+ (BTCOrder*)buyOrder;
+ (BTCOrder*)sellOrder;

@property (copy, nonatomic) NSString *orderId;
@property (nonatomic) NSDecimalNumber *price;
@property (nonatomic) NSDecimalNumber *amount;
@property (nonatomic) NSDecimalNumber *total;
@property (copy, nonatomic) NSString* datetime;
@property (assign, nonatomic) BTCOrderType type;
@property (assign, nonatomic) BTCOrderCategory category;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (BOOL)isMarketOrder;
- (BOOL)isLimitOrder;
- (BOOL)isSellOrder;
- (BOOL)isBuyOrder;

@end
