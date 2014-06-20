//
//  NSObject+FHSTE.m
//  FHSTwitterEngine
//
//  Created by Nathaniel Symer on 3/10/14.
//  Copyright (c) 2014 Nathaniel Symer. All rights reserved.
//

#import "NSObject+FHSTE.h"

id removeNull(id rootObject) {
    if ([rootObject isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *sanitizedDictionary = [NSMutableDictionary dictionaryWithDictionary:rootObject];
        [rootObject enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            id sanitized = removeNull(obj);
            sanitizedDictionary[key] = sanitized?sanitized:@"";
        }];
        return [NSMutableDictionary dictionaryWithDictionary:sanitizedDictionary];
    }
    
    if ([rootObject isKindOfClass:[NSArray class]]) {
        NSMutableArray *sanitizedArray = [NSMutableArray arrayWithArray:rootObject];
        [rootObject enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            id sanitized = removeNull(obj);
            sanitizedArray[idx] = sanitized?sanitized:@"";
        }];
        return sanitizedArray;
    }
    
    if ([rootObject isKindOfClass:[NSNull class]]) {
        return (id)nil;
    }
    
    return rootObject;
}

@implementation NSObject (RemoveNull)

- (instancetype)removeNull {
    return removeNull(self);
}

@end
