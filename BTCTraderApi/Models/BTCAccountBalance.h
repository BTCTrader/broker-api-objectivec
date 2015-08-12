#import <Foundation/Foundation.h>

@interface BTCAccountBalance : NSObject

@property (nonatomic, readonly) NSDecimalNumber *moneyBalance;
@property (nonatomic, readonly) NSDecimalNumber *bitcoinBalance;
@property (nonatomic, readonly) NSDecimalNumber *moneyReserved;
@property (nonatomic, readonly) NSDecimalNumber *bitcoinReserved;
@property (nonatomic, readonly) NSDecimalNumber *moneyAvailable;
@property (nonatomic, readonly) NSDecimalNumber *bitcoinAvailable;
@property (nonatomic, readonly) NSDecimalNumber *feePercentage;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
