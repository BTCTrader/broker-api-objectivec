#import "BTCOrder.h"

NSString *const buyTypeIdentifier = @"BuyBtc";
NSString *const sellTypeIdentifier = @"SellBtc";

NSString *const orderIdKey = @"id";
NSString *const orderTypeKey = @"type";
NSString *const orderPriceKey = @"price";
NSString *const orderAmountKey = @"amount";
NSString *const orderTotalKey = @"total";
NSString *const orderDatetimeKey = @"datetime";

// BTCOrderCategory const defaultCategory = BTCOrderCategoryUnknown;

@implementation BTCOrder

+ (BTCOrder*)buyOrder{
    BTCOrder *order = [[self alloc] init];
    if (order == nil) {
        return nil;
    }
    order.type = BTCOrderTypeBuy;
    return order;
}

+ (BTCOrder*)sellOrder{
    BTCOrder *order = [[self alloc] init];
    if (order == nil) {
        return nil;
    }
    order.type = BTCOrderTypeSell;
    return order;
}

- (instancetype)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.type = BTCOrderTypeUnknown;
    self.category = BTCOrderCategoryUnknown;
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [self init];
    if (!self)
        return nil;
    
    _orderId = dictionary[orderIdKey];
    _price = [NSDecimalNumber decimalNumberWithDecimal:[dictionary[orderPriceKey] decimalValue]];
    _amount = [NSDecimalNumber decimalNumberWithDecimal:[dictionary[orderAmountKey] decimalValue]];
    _total = [NSDecimalNumber decimalNumberWithDecimal:[dictionary[orderTotalKey] decimalValue]];
    _datetime = dictionary[orderDatetimeKey];
    
    _type = [self _typeFromString:dictionary[orderTypeKey]];
    
    return self;
}

- (BTCOrderType)_typeFromString:(NSString*)identifier{
    if ([identifier isEqualToString:buyTypeIdentifier]) {
        return BTCOrderTypeBuy;
    }
    
    if ([identifier isEqualToString:sellTypeIdentifier]) {
        return BTCOrderTypeSell;
    }
    
    return BTCOrderTypeUnknown;
}


- (BOOL)isMarketOrder{
    return self.category == BTCOrderCategoryMarket;
}


- (BOOL)isLimitOrder{
    return self.category == BTCOrderCategoryLimit;
}


- (BOOL)isSellOrder{
    return self.type == BTCOrderTypeSell;
}


- (BOOL)isBuyOrder{
    return self.type == BTCOrderTypeBuy;
}


- (NSString*)descriptionForType:(BTCOrderType)orderType{
    NSString *orderTypeString;
    switch (orderType) {
        case BTCOrderTypeBuy:
            orderTypeString = @"Buy";
            break;
        case BTCOrderTypeSell:
            orderTypeString = @"Sell";
            break;
        default:
            orderTypeString = @"Unknown type";
            break;
    }
    return orderTypeString;
}


- (NSString*)descriptionForCategory:(BTCOrderCategory)orderCategory{
    NSString *orderCategoryString;
    switch (orderCategory) {
        case BTCOrderCategoryMarket:
            orderCategoryString = @"Market";
            break;
        case BTCOrderCategoryLimit:
            orderCategoryString = @"Limit";
            break;
        default:
            orderCategoryString = @"Unknown category";
            break;
    }
    return orderCategoryString;
}


- (NSString*)description{
    return [NSString stringWithFormat:@"OrderId: %@, Price: %@, Amount: %@, Total: %@, Datetime: %@, Type: %@, Category: %@", self.orderId, [self.price stringValue], [self.amount stringValue], [self.total stringValue], self.datetime, [self descriptionForType:self.type], [self descriptionForCategory:self.category]];
}


@end
