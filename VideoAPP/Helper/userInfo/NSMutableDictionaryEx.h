//
//  NSMutableDictionaryEx.h
//  WHua
//
//  Created by yoky on 14-8-6.
//  Copyright (c) 2014年 User. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (NSMutableDictionaryEx)
- (void)setSafeObject:(id)anObject forSafeKey:(id)aKey;
- (void)removeSafeObjectForKey:(id)aKey;
@end

@interface NSMutableArray (NSMutableArrayEx)
- (void)addSafeObject:(id)anObject;
- (void)removeSafeObjectAtIndex:(NSUInteger)index;
- (void)insertSafeObject:(id)anObject atIndex:(NSUInteger)index;
@end

@interface NSArray (NSArrayEx)
- (id)objectAtSafeIndex:(NSUInteger)index;
/**
 * @brief 判断数组是否包含另一个数组的所有元素
 * @param targetArray 目标数组(大数组)
 */
- (BOOL)judgeArrayContainArray:(NSArray *)targetArray;
@end



