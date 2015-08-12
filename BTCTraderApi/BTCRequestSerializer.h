#import "AFURLRequestSerialization.h"

@interface BTCRequestSerializer : AFJSONRequestSerializer

@property (copy, nonatomic) NSString *apiKey;
@property (copy, nonatomic) NSString *secret;

@end
