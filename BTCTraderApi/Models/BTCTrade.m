#import "BTCTrade.h"

NSString *const tradeIdKey = @"tid";
NSString *const tradePriceKey = @"price";
NSString *const tradeAmountKey = @"amount";
NSString *const tradeDateKey = @"date";

@implementation BTCTrade

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (!self)
        return nil;
    
    _tradeId = dictionary[tradeIdKey];
    _price = [NSDecimalNumber decimalNumberWithDecimal:[dictionary[tradePriceKey] decimalValue]];
    _amount = [NSDecimalNumber decimalNumberWithDecimal:[dictionary[tradeAmountKey] decimalValue]];
    _date = [dictionary[tradeDateKey] stringValue];
    
    return self;
}


- (NSString*)description{
    return [NSString stringWithFormat:@"TradeId: %@, Price: %@, Amount: %@, Date: %@", self.tradeId, [self.price stringValue], [self.amount stringValue], self.date];
}

@end
