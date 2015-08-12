#import "BTCAccountBalance.h"


NSString *const accountMoneyBalanceKey = @"money_balance";
NSString *const accountBitcoinBalanceKey = @"bitcoin_balance";
NSString *const accountMoneyReserverdKey = @"money_reserved";
NSString *const accountBitcoinReservedKey = @"bitcoin_reserved";
NSString *const accountMoneyAvailableKey = @"money_available";
NSString *const accountBitcoinAvailableKey = @"bitcoin_available";
NSString *const accountFeePercentageKey = @"fee_percentage";


@implementation BTCAccountBalance

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (!self)
        return nil;
    
    _moneyBalance = [NSDecimalNumber decimalNumberWithDecimal:[dictionary[accountMoneyBalanceKey] decimalValue]];
    _bitcoinBalance = [NSDecimalNumber decimalNumberWithDecimal:[dictionary[accountBitcoinBalanceKey] decimalValue]];
    _moneyReserved = [NSDecimalNumber decimalNumberWithDecimal:[dictionary[accountMoneyReserverdKey] decimalValue]];
    _bitcoinReserved = [NSDecimalNumber decimalNumberWithDecimal:[dictionary[accountBitcoinReservedKey] decimalValue]];
    _moneyAvailable = [NSDecimalNumber decimalNumberWithDecimal:[dictionary[accountMoneyAvailableKey] decimalValue]];
    _bitcoinAvailable = [NSDecimalNumber decimalNumberWithDecimal:[dictionary[accountBitcoinAvailableKey] decimalValue]];
    _feePercentage = [NSDecimalNumber decimalNumberWithDecimal:[dictionary[accountFeePercentageKey] decimalValue]];
    
    return self;
}

- (NSString*)description{
    return [NSString stringWithFormat:@"Money Balance: %@, Bitcoin Balance: %@, Money Reserved: %@, Bitcoin Reserved: %@, Money Available: %@, Bitcoin Available: %@, Fee Percentage: %@", [self.moneyBalance stringValue], [self.bitcoinBalance stringValue], [self.moneyReserved stringValue], [self.bitcoinReserved stringValue], [self.moneyAvailable stringValue], [self.bitcoinAvailable stringValue], [self.feePercentage stringValue]];
}

@end