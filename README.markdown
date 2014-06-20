FHSTwitterEngine
================

***Twitter API for Cocoa developers***

Created by [Nathaniel Symer](mailto:nate@natesymer.com), aka [@natesymer](http://twitter.com/natesymer) 

`FHSTwitterEngine` can:

- Authenicate using OAuth, xAuth, and iOS Reverse auth.
- Make a request to just about every API resource.

Why you should use `FHSTwitterEngine`:

- No 3rd party dependencies
- Authentication options
- Shared instance
- Scientific

**Setup**

1. Add the `FHSTwitterEngine` folder to your project.
2. `#import "FHSTwitterEngine.h"` where necessary
3. Link against `SystemConfiguration.framework`
4. Enable ARC for the `FHSTwitterEngine` folder (if necessary)
5. Link against `Social.framework` and `Accounts.framework` if you're using the FHSTwitterEngine+iOS category for reverse auth.

**Usage:**

> Set up `FHSTwitterEngine`

    [[FHSTwitterEngine sharedEngine]permanentlySetConsumerKey:@"<consumer_key>" andSecret:@"<consumer_secret>"];
> Or with a temporary consumer that gets cleared after each request
 
    [[FHSTwitterEngine sharedEngine]temporarilySetConsumerKey:@"<consumer_key>" andSecret:@"<consumer_secret>"];
         
> Set access token loading/storing blocks

	FHSTwitterEngine.sharedEngine.storeAccessTokenBlock = ^(NSString *accessToken) {
    	// save access token  
    };
    
    FHSTwitterEngine.sharedEngine.loadAccessTokenBlock = ^NSString *(void) {
    	return @"<access_token>"; // you can load it from anywhere you want!
    };
    
> Login via OAuth:

	FHSTwitterEngineController *loginController = [FHSTwitterEngineController controllerWithCompletionBlock:^(FHSTwitterEngineControllerResult result) {
        switch (result) {
            case FHSTwitterEngineControllerResultCancelled:
                NSLog(@"Login Controller Cancelled");
                break;
            case FHSTwitterEngineControllerResultFailed:
                NSLog(@"Login Controller Failed");
                break;
            case FHSTwitterEngineControllerResultSucceeded:
                NSLog(@"Login Controller Succeeded");
                break;
            default:
                break;
        }
    }];
    [self presentViewController:loginController animated:YES completion:nil];
    
> Login via XAuth:
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    	@autoreleasepool {
    		NSError *error = [[FHSTwitterEngine sharedEngine]authenticateWithUsername:@"<username>"" password:@"<password>""];
        	// Handle error
        	dispatch_sync(dispatch_get_main_queue(), ^{
    			@autoreleasepool {
        			// Update UI
        		}
       		});
    	}
    });
    
> Clear the current consumer key

	[[FHSTwitterEngine sharedEngine]clearConsumer];
	
> Load a saved access_token (called when API calls are made):

    [[FHSTwitterEngine sharedEngine]loadAccessToken];

> Clear your access token:

    [[FHSTwitterEngine sharedEngine]clearAccessToken];

> Check if a session is valid:

    [[FHSTwitterEngine sharedEngine]isAuthorized];
    
> Do an API call (POST and GET):

    dispatch_async((dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    	@autoreleasepool {
    		id twitterData = [[FHSTwitterEngine sharedEngine]postTweet:@"Hi!"];
    		// Handle twitterData
    		dispatch_sync(dispatch_get_main_queue(), ^{
    			@autoreleasepool {
        			// Update UI
        		}
       		});
    	}
    });

**The "Singleton" Pattern**

The singleton pattern allows the programmer to use the library across scopes without having to manually keep a reference to the FHSTwitterEngine object. When the app is killed, any memory used by FHSTwitterEngine is freed.

**Threading**

While you can use any threading technology for threading, I recommend Grand Central Dispatch (GCD).

**General Comments**

`FHSTwitterEngine` will attempt to preemptively detect errors in your requests, before they are actually sent. This includes missing parameters, and a lack of authorization. If FHSTwitterEngine detects that a user is not logged in, it will attempt to load an access token using its delegate. This process is designed to prevent bad requests from being needlessly sent.

**About requests**

Most methods return `id`. The returned object can be a(n):

- `NSMutableDictionary`
- `NSMutableArray`
- `UIImage`
- `NSString`
- `NSError`
- `nil`

**For the future/To Do**

You can [email](mailto:nate@natesymer.com) me with suggestions or open an [issue](https://github.com/fhsjaagshs/FHSTwitterEngine/issues).

- OS X compatibility
- Tag releases
- Tests
- <strike>Add license</strike>
- <strike>Create a CocoaPod</strike> Add podspec to cocoapods
- <strike>Make demo universal</strike>
- <strike>Split up FHSTwitterEngine.{h,m}</strike>

**Debugging 101 for outsource developers**

Before emailing me, spend an hour trying to fix the problem yourself. Don't go wild and try to change everything, just trace back your steps, and look closely at details. Don't program by permutation.

One common issue appears to be an `#import` loop. This happens when class *a* imports class *b* which, in turn, imports class *a*. Usually, the compiler will give you a warning that should look like: *"multiple declarations of class x"*. However, this warning/error can appear from multiple declarations of class x, so be careful.

If after an hour, you have no solution and your problem is in your code, I don't want to hear it. I'm not getting paid to do your job (that you should be capable of doing yourself). 
