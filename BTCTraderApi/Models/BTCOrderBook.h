#import <Foundation/Foundation.h>

@interface BTCOrderBookRecord : NSObject

@property (nonatomic, readonly) NSDecimalNumber *price;
@property (nonatomic, readonly) NSDecimalNumber *amount;

/// Expects price to be at index 0 and amount at index 1
- (instancetype)initWithArray:(NSArray*)array;

- (instancetype)initWithPrice:(NSDecimalNumber*)price amount:(NSDecimalNumber*)amount;

@end


@interface BTCOrderBook : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, readonly) NSDecimalNumber *timeStamp;
@property (nonatomic, copy, readonly) NSArray *bids;
@property (nonatomic, copy, readonly) NSArray *asks;
@property (nonatomic, readonly) NSUInteger asksCount;
@property (nonatomic, readonly) NSUInteger bidsCount;

@end
