#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import "CustomerPluginRegistrant.h"

#import "SkIntent.h"
#import <Intents/Intents.h>
#import <IntentsUI/IntentsUI.h>

@interface AppDelegate ()
@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 // [GeneratedPluginRegistrant registerWithRegistry:self];
    [CustomerPluginRegistrant registerWithRegistry:self];
    
    return YES;
}




@end
