#import "BTCTicker.h"


NSString *const tickerLastKey = @"last";
NSString *const tickerHighKey = @"high";
NSString *const tickerLowKey = @"low";
NSString *const tickerVolumeKey = @"volume";
NSString *const tickerBidKey = @"bid";
NSString *const tickerAskKey = @"ask";
NSString *const tickerOpenKey = @"open";

NSString *const tickerDiffKey = @"diff";
NSString *const tickerPercentageKey = @"percentage";
NSString *const tickerVolumetryKey = @"volumetry";
NSString *const tickerReceivedAtKey = @"received_at";


@interface BTCTicker ()

@property (nonatomic, readwrite) NSDecimalNumber *last;
@property (nonatomic, readwrite) NSDecimalNumber *high;
@property (nonatomic, readwrite) NSDecimalNumber *low;
@property (nonatomic, readwrite) NSDecimalNumber *volume;
@property (nonatomic, readwrite) NSDecimalNumber *bid;
@property (nonatomic, readwrite) NSDecimalNumber *ask;
@property (nonatomic, readwrite) NSDecimalNumber *open;
@property (nonatomic, readwrite) NSDecimalNumber *diff;
@property (nonatomic, readwrite) NSDecimalNumber *percentage;
@property (nonatomic, readwrite) NSDecimalNumber *volumetry;

@end

@implementation BTCTicker

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (!self)
        return nil;
    
    _last   = [NSDecimalNumber decimalNumberWithDecimal:[dictionary[tickerLastKey] decimalValue]];
    _high   = [NSDecimalNumber decimalNumberWithDecimal:[dictionary[tickerHighKey] decimalValue]];
    _low    = [NSDecimalNumber decimalNumberWithDecimal:[dictionary[tickerLowKey] decimalValue]];
    _volume = [NSDecimalNumber decimalNumberWithDecimal:[dictionary[tickerVolumeKey] decimalValue]];
    _bid    = [NSDecimalNumber decimalNumberWithDecimal:[dictionary[tickerBidKey] decimalValue]];
    _ask    = [NSDecimalNumber decimalNumberWithDecimal:[dictionary[tickerAskKey] decimalValue]];
    _open   = [NSDecimalNumber decimalNumberWithDecimal:[dictionary[tickerOpenKey] decimalValue]];

    
    _receivedAt = [NSDate new];
    return self;
}

- (NSDecimalNumber*)volumetry{
    if (_volumetry == nil) {
        _volumetry = [self.volume decimalNumberByMultiplyingBy:self.ask];
    }
    return _volumetry;
}

- (NSDecimalNumber*)diff{
    if (_diff == nil) {
        _diff = [self.ask decimalNumberBySubtracting:self.open];
    }
    return _diff;
}

- (NSDecimalNumber*)percentage{
    if (_percentage == nil) {
        _percentage = [[[self diff] decimalNumberByDividingBy:self.open] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"100"]];
    }
    return _percentage;
}

- (NSDecimalNumber*)totalValueForMarket:(NSDecimalNumber*)totalBtcInMarket{
    return [self.ask decimalNumberByMultiplyingBy:totalBtcInMarket];
}


- (NSString*)description{
    return [NSString stringWithFormat:@"Last: %@, High: %@, Low: %@, Volume: %@, Bid: %@, Ask: %@, Open: %@, Volumetry: %@, Diff: %@, Percentage: %@", [self.last stringValue], [self.high stringValue], [self.low stringValue], [self.volume stringValue], [self.bid stringValue], [self.ask stringValue], [self.open stringValue], [[self volumetry] stringValue], [[self diff] stringValue], [[self percentage] stringValue]];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [self init];
    
    if (self == nil)
        return nil;
    
    _last       = [coder decodeObjectOfClass:[NSDecimalNumber class] forKey:tickerLastKey];
    _high       = [coder decodeObjectOfClass:[NSDecimalNumber class] forKey:tickerHighKey];
    _low        = [coder decodeObjectOfClass:[NSDecimalNumber class] forKey:tickerLowKey];
    _volume     = [coder decodeObjectOfClass:[NSDecimalNumber class] forKey:tickerVolumeKey];
    _bid        = [coder decodeObjectOfClass:[NSDecimalNumber class] forKey:tickerBidKey];
    _ask        = [coder decodeObjectOfClass:[NSDecimalNumber class] forKey:tickerAskKey];
    _open       = [coder decodeObjectOfClass:[NSDecimalNumber class] forKey:tickerOpenKey];
    _diff       = [coder decodeObjectOfClass:[NSDecimalNumber class] forKey:tickerDiffKey];
    _percentage = [coder decodeObjectOfClass:[NSDecimalNumber class] forKey:tickerPercentageKey];
    _volumetry  = [coder decodeObjectOfClass:[NSDecimalNumber class] forKey:tickerVolumetryKey];
    _receivedAt = [coder decodeObjectOfClass:[NSDate class] forKey:tickerReceivedAtKey];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    if (self.last != nil) [coder encodeObject:self.last forKey:tickerLastKey];
    if (self.high != nil) [coder encodeObject:self.high forKey:tickerHighKey];
    if (self.low != nil) [coder encodeObject:self.low forKey:tickerLowKey];
    if (self.volume != nil) [coder encodeObject:self.volume forKey:tickerVolumeKey];
    if (self.bid != nil) [coder encodeObject:self.bid forKey:tickerBidKey];
    if (self.ask != nil) [coder encodeObject:self.ask forKey:tickerAskKey];
    if (self.open != nil) [coder encodeObject:self.open forKey:tickerOpenKey];

    if (self.diff != nil) [coder encodeObject:self.diff forKey:tickerDiffKey];
    if (self.percentage != nil) [coder encodeObject:self.percentage forKey:tickerPercentageKey];
    if (self.volumetry != nil) [coder encodeObject:self.volumetry forKey:tickerVolumetryKey];
    if (self.receivedAt != nil) [coder encodeObject:self.receivedAt forKey:tickerReceivedAtKey];
}

@end
