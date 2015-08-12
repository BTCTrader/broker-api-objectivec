#import "BTCTransaction.h"

NSString *const transactionIdKey = @"id";
NSString *const transactionOperationKey = @"operation";
NSString *const transactionCurrencyKey = @"currency";
NSString *const transactionPriceKey = @"price";
NSString *const transactionBtcKey = @"btc";
NSString *const transactionDateKey = @"date";


NSString *const transactionOperationBuyIdentifier = @"buy";
NSString *const transactionOperationSellIdentifier = @"sell";
NSString *const transactionOperationDepositIndetifier = @"deposit";
NSString *const transactionOperationCommissionIdentifier = @"commission";
NSString *const transactionOperationWithdrawalIdentifier = @"withdrawal";

@implementation BTCTransaction

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (!self)
        return nil;
    
    _transactionId = dictionary[transactionIdKey];
    _operation = dictionary[transactionOperationKey];
    _btc = [NSDecimalNumber decimalNumberWithDecimal:[dictionary[transactionBtcKey] decimalValue]];
    _currency = [NSDecimalNumber decimalNumberWithDecimal:[dictionary[transactionCurrencyKey] decimalValue]];
    _price = [NSDecimalNumber decimalNumberWithDecimal:[dictionary[transactionPriceKey] decimalValue]];
    _date = dictionary[transactionDateKey];
    
    _operationType = [self _operationTypeFromString:dictionary[transactionOperationKey]];
    
    return self;
}

- (BTCTransactionOperationType)_operationTypeFromString:(NSString*)identifier{
    
    if ([identifier isEqualToString:transactionOperationBuyIdentifier]) {
        return BTCTransactionOperationTypeBuy;
    }
    
    if ([identifier isEqualToString:transactionOperationSellIdentifier]) {
        return BTCTransactionOperationTypeSell;
    }
    
    if ([identifier isEqualToString:transactionOperationCommissionIdentifier]) {
        return BTCTransactionOperationTypeCommission;
    }
    
    if ([identifier isEqualToString:transactionOperationDepositIndetifier]) {
        return BTCTransactionOperationTypeDeposit;
    }
    
    if ([identifier isEqualToString:transactionOperationWithdrawalIdentifier]) {
        return BTCTransactionOperationTypeWithdrawal;
    }
    
    return BTCTransactionOperationTypeUnknown;
}

- (NSString*)description{
    return [NSString stringWithFormat:@"TransactionId: %@, Operation: %@, Btc: %@, Currency: %@, Price: %@ Date: %@", self.transactionId, self.operation, [self.btc stringValue], [self.currency stringValue], [self.price stringValue], self.date];
}

@end
