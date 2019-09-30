//
//  NSMutableDictionaryEx.m
//  WHua
//
//  Created by yoky on 14-8-6.
//  Copyright (c) 2014年 User. All rights reserved.
//

#import "NSMutableDictionaryEx.h"

@implementation NSMutableDictionary (NSMutableDictionaryEx)
- (void)setSafeObject:(id)anObject forSafeKey:(id)aKey{
    if (anObject && aKey) {
        [self setObject:anObject forKey:aKey];
    }
}
- (void)removeSafeObjectForKey:(id)aKey{
    if (aKey) {
        [self removeObjectForKey:aKey];
    }
}
@end

@implementation NSMutableArray (NSMutableArrayEx)
- (void)addSafeObject:(id)anObject{
    if (anObject) {
        [self addObject:anObject];
    }
}
- (void)removeSafeObjectAtIndex:(NSUInteger)index{
    if (self.count > index) {
        [self removeObjectAtIndex:index];
    }
}
- (void)insertSafeObject:(id)anObject atIndex:(NSUInteger)index{
    if (anObject) {
        [self insertObject:anObject atIndex:index];
    }
}
@end




@implementation NSArray (NSArrayEx)
- (id)objectAtSafeIndex:(NSUInteger)index{
    if([self isKindOfClass:[NSArray class]])
    {
        if (self.count > index) {
            return [self objectAtIndex:index];
        }
        return nil;
    }
    return  self;
}

/**
 * @brief 判断数组是否包含另一个数组的所有元素
 * @param targetArray 目标数组(大数组)
 */
- (BOOL)judgeArrayContainArray:(NSArray *)targetArray
{
    NSInteger sourceNum = 0;
    for (NSInteger i = 0; i < self.count; i++) {
        for (NSInteger j = 0; j < targetArray.count; j++) {
            if ([[targetArray objectAtSafeIndex:j] isEqualToString:[self objectAtSafeIndex:i]]) {
                sourceNum++;
            }
        }
    }
    if (sourceNum == self.count) {
        return YES;
    }else{
        return NO;
    }
}
@end











