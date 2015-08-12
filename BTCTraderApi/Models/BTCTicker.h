#import <Foundation/Foundation.h>

@interface BTCTicker : NSObject <NSCoding>

@property (nonatomic, readonly) NSDecimalNumber *last;
@property (nonatomic, readonly) NSDecimalNumber *high;
@property (nonatomic, readonly) NSDecimalNumber *low;
@property (nonatomic, readonly) NSDecimalNumber *volume;
@property (nonatomic, readonly) NSDecimalNumber *bid;
@property (nonatomic, readonly) NSDecimalNumber *ask;
@property (nonatomic, readonly) NSDecimalNumber *open;
@property (nonatomic, readonly) NSDate *receivedAt;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end


@interface BTCTicker (DerivedValues)

/// ask - open
@property (nonatomic, readonly) NSDecimalNumber *diff;
/// diff / open * 100
@property (nonatomic, readonly) NSDecimalNumber *percentage;
/// volume * ask
@property (nonatomic, readonly) NSDecimalNumber *volumetry;

/// ask * totalBtcInMarket
- (NSDecimalNumber*)totalValueForMarket:(NSDecimalNumber*)totalBtcInMarket;

@end