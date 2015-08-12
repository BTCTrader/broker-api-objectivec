#import "BTCOrderBook.h"

@implementation BTCOrderBookRecord

- (instancetype)initWithArray:(NSArray*)array{
    NSDecimalNumber *price = [NSDecimalNumber decimalNumberWithDecimal:[array[0] decimalValue]];
    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithDecimal:[array[1] decimalValue]];
    return [self initWithPrice:price amount:amount];
}


- (instancetype)initWithPrice:(NSDecimalNumber *)price amount:(NSDecimalNumber *)amount{
    self = [super init];
    if (self) {
        _price = price;
        _amount = amount;
    }
    
    return self;
}


- (NSString*)description{
    return [NSString stringWithFormat:@"Price: %@, Amount: %@", [self.price stringValue], [self.amount stringValue]];
}

@end



@implementation BTCOrderBook

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (!self)
        return nil;
    
    _timeStamp = [NSDecimalNumber decimalNumberWithDecimal:[dictionary[@"timestamp"] decimalValue]];
    _bids = [self createRecordsArrayFromData:dictionary[@"bids"]];
    _asks = [self createRecordsArrayFromData:dictionary[@"asks"]];
    
    return self;
}


- (NSArray*)createRecordsArrayFromData:(NSArray*)data{
    NSMutableArray *tempRecordsArray = [NSMutableArray new];
    for (NSArray *recordData in data) {
        BTCOrderBookRecord *newRecord = [[BTCOrderBookRecord alloc] initWithArray:recordData];
        [tempRecordsArray addObject:newRecord];
    }
    return [NSArray arrayWithArray:tempRecordsArray];
}


- (NSString*)description{
    return [NSString stringWithFormat:@"Timestamp: %@, Asks: %@, Bids: %@", self.timeStamp, self.asks, self.bids];
}

- (NSUInteger)asksCount{
    return [self.asks count];
}

- (NSUInteger)bidsCount{
    return [self.bids count];
}

@end
