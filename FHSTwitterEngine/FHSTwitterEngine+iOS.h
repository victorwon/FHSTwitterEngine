//
//  FHSTwitterEngine+iOS.h
//  FHSTwitterEngine
//
//  Created by Nathaniel Symer on 3/12/14.
//  Copyright (c) 2014 Nathaniel Symer. All rights reserved.
//

#import "FHSTwitterEngine.h"

#import <Social/Social.h>
#import <Accounts/Accounts.h>

typedef ACAccount *(^AccountSelectionBlock)(NSArray *accounts);
typedef void(^ReverseAuthFinishedBlock)(BOOL success);

@interface FHSTwitterEngine (iOS)

- (void)reverseAuthWithAccountSelectionBlock:(AccountSelectionBlock)accSelBlock completion:(ReverseAuthFinishedBlock)completionBlock;

@end
