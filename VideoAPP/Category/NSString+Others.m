//
//  NSString+Others.m
//  WaterCommunity
//
//  Created by 雷文霄 on 2017/2/6.
//  Copyright © 2017年 hxisWater. All rights reserved.
//

#import "NSString+Others.h"
#import <CommonCrypto/CommonDigest.h>
#import <ifaddrs.h>
#import <arpa/inet.h>

#include <arpa/inet.h>
#include <netdb.h>
#include <net/if.h>
#include <ifaddrs.h>
#import <dlfcn.h>

@implementation NSString (Others)


+(NSString *)ret32bitString

{
    
    char data[32];
    
    for (int x=0;x<32;data[x++] = (char)('A' + (arc4random_uniform(26))));
    
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
    
}


+ (NSString *)md5HexDigest:(NSString*)input
{
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

+(NSString *)getTimeInterval{
    
    
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    return  [NSString stringWithFormat:@"%.0f",interval];
}

+(NSString *)getIpAddresses{
    /*
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
    */
    
    BOOL success;
    struct ifaddrs * addrs;
    const struct ifaddrs * cursor;
    success = getifaddrs(&addrs) == 0;
    if (success) {
        cursor = addrs;
        while (cursor != NULL) {
            // the second test keeps from picking up the loopback address
            if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0)
            {
                NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
                if ([name isEqualToString:@"en0"]) // Wi-Fi adapter
                    NSLog(@"IP:%@",[NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)]);
                return [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    return nil;
    
}

+(NSString *)dictionaryToJson:(NSDictionary *)dic{
    
    
    
    NSString *jsonString = [[NSString alloc]init];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                        
                                                       options:NSJSONWritingPrettyPrinted
                        
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    [mutStr replaceOccurrencesOfString:@" "withString:@""options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    [mutStr replaceOccurrencesOfString:@"\n"withString:@""options:NSLiteralSearch range:range2];
    
    NSRange range3 = {0,mutStr.length};
    
    
    [mutStr replaceOccurrencesOfString:@"\\"withString:@""options:NSLiteralSearch range:range3];
    return mutStr;
    
    
    /*
    NSMutableArray *StringArray=[NSMutableArray array];
    for (NSString *key in dic.allKeys) {
        NSString *String=[NSString stringWithFormat:@"\"%@\":\"%@\"",key,[dic objectForKey:key]];
        [StringArray addObject:String];
        
    }
    
//    NSLog(@"%@",StringArray);
    
    NSArray *Array2=[StringArray sortedArrayUsingComparator:^NSComparisonResult(NSString *  _Nonnull obj1, NSString * _Nonnull obj2) {
       
        NSComparisonResult result = [obj1 compare:obj2];
        return result;
        
    }];
    
    
    
//    NSLog(@"%@",Array2);
    
    NSString *ReslutString=[NSString stringWithFormat:@""];
    for (NSString *Str in Array2) {
        
        ReslutString=[NSString stringWithFormat:@"%@,%@",ReslutString,Str];
    }
    ReslutString=[ReslutString substringFromIndex:1];
    
    ReslutString=[NSString stringWithFormat:@"{%@}",ReslutString];
//    NSLog(@"%@",ReslutString);
    
    
    return ReslutString;
    
 */
    
}

+ (NSString*)dataToJSONString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, jsonString.length)];
    return jsonString;
}
@end
