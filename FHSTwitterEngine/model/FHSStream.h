//
//  FHSStream.h
//  FHSTwitterEngine
//
//  Created by Nathaniel Symer on 3/9/14.
//  Copyright (c) 2014 Nathaniel Symer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FHSTwitterEngine.h"

@interface FHSStream : NSObject

@property (nonatomic, copy) StreamBlock block;

+ (FHSStream *)streamWithURL:(NSString *)url httpMethod:(NSString *)httpMethod parameters:(NSDictionary *)params timeout:(float)timeout block:(StreamBlock)block;

- (void)stop;
- (void)start;

// check out the streaming parameters here:
// https://dev.twitter.com/docs/streaming-apis/parameters

// This makes sure all track keywords are valid
+ (NSString *)sanitizeTrackParameter:(NSArray *)keywords;

@end
