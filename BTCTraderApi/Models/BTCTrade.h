#import <Foundation/Foundation.h>

@interface BTCTrade : NSObject

@property (nonatomic, copy, readonly) NSString *tradeId;
@property (nonatomic, readonly) NSDecimalNumber *price;
@property (nonatomic, readonly) NSDecimalNumber *amount;
@property (nonatomic, copy, readonly) NSString* date;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
