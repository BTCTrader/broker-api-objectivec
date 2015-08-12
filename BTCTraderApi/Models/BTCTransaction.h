#import <Foundation/Foundation.h>

@interface BTCTransaction : NSObject

typedef NS_ENUM(NSUInteger, BTCTransactionOperationType) {
    BTCTransactionOperationTypeSell = 0,
    BTCTransactionOperationTypeBuy = 1,
    BTCTransactionOperationTypeDeposit = 2,
    BTCTransactionOperationTypeCommission = 3,
    BTCTransactionOperationTypeWithdrawal = 4,
    BTCTransactionOperationTypeUnknown = 999
};


@property (copy, nonatomic) NSString *transactionId;
@property (copy, nonatomic) NSString *operation;
@property (nonatomic) BTCTransactionOperationType operationType;
@property (nonatomic) NSDecimalNumber *btc;
@property (nonatomic) NSDecimalNumber *currency;
@property (nonatomic) NSDecimalNumber *price;
@property (copy, nonatomic) NSString* date;


- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
@end
