#import "BTCRequestSerializer.h"

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CocoaSecurity/Base64.h>

NSString *const BTCApiKeyHeaderKey = @"X-PCK";
NSString *const BTCTimestampHeaderKey = @"X-Stamp";
NSString *const BTCSignatureHeaderKey = @"X-Signature";

@implementation BTCRequestSerializer

- (NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request
                               withParameters:(id)parameters
                                        error:(NSError *__autoreleasing *)error{
    
    NSString *apiKey = [self apiKey];
    NSString *secret = [self secret];
    NSString *timestamp = [self timestamp];
    
    NSString *signature = @"";
    if (![secret isEqualToString:@""]) {
        signature = [self signatureWithSecret:secret apiKey:apiKey timestamp:timestamp];
    }
    
    [self setStampHeader:timestamp];
    [self setApiKeyHeader:apiKey];
    [self setSignatureHeader:signature];
    
    return [super requestBySerializingRequest:request withParameters:parameters error:error];
}


- (NSString*)timestamp{
    static double nonce = 0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        nonce = [[NSDate date] timeIntervalSince1970] * 1000;
    });
    NSString *timestamp = [NSString stringWithFormat:@"%.0f", nonce];
    nonce++; // ensure unique nonce for each request
    return timestamp;
}

- (NSString*)apiKey{
    if (_apiKey) {
        return _apiKey;
    }
    return @"";
}


- (NSString*)secret{
    if (_secret) {
        return _secret;
    }
    return @"";
}


- (void)setStampHeader:(NSString*)timestamp{
    [self setValue:timestamp forHTTPHeaderField:BTCTimestampHeaderKey];
}


- (void)setApiKeyHeader:(NSString*)key{
    [self setValue:key forHTTPHeaderField:BTCApiKeyHeaderKey];
}


- (void)setSignatureHeader:(NSString*)signature{
    [self setValue:signature forHTTPHeaderField:BTCSignatureHeaderKey];
}


- (NSString*)signatureWithSecret:(NSString*)secret apiKey:(NSString*)apiKey timestamp:(NSString*)timestamp{
    NSParameterAssert(secret);
    NSParameterAssert(apiKey);
    NSParameterAssert(timestamp);
    NSString *apiSign = [apiKey stringByAppendingString:timestamp];
    NSData *saltData = [secret base64DecodedData];
    NSData *paramData = [apiSign dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData* hash = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, saltData.bytes, saltData.length, paramData.bytes, paramData.length, hash.mutableBytes);
    NSString *signature = [hash base64EncodedString];
    return signature;
}

@end
