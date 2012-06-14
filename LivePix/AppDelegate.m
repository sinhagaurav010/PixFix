//
//  AppDelegate.m
//  LivePix
//
//  Created by preet dhillon on 08/06/12.
//  Copyright (c) 2012 dhillon. All rights reserved.
//

#import "AppDelegate.h"

NSString * const FacebookAppID = @"243160005794808";
NSString * const facebookAccessTokenKey = @"facebookAccessToken";
NSString * const facebookExpirationDateKey = @"facebookExpirationDate";


@implementation AppDelegate

@synthesize window = _window;

@synthesize facebook;
@synthesize apiData;

@synthesize userPermissions,AddEventController;




@synthesize SplashController,navigation;
- (void)dealloc
{
    
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];

    self.SplashController = [[SplashScreenController  alloc] init];
    
    
    if(![ModalController  getContforKey:KsSAVEDLOGGEDIN])
    self.navigation = [[UINavigationController  alloc] initWithRootViewController:self.SplashController];
    else
    {
        self.AddEventController = [[AddEventViewController  alloc] initWithNibName:@"AddEventViewController"
                                                                            bundle:nil];
        self.navigation  = [[UINavigationController  alloc] initWithRootViewController:self.AddEventController];
    }
    
    self.window.rootViewController = self.navigation;
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    facebook = [[Facebook alloc] initWithAppId:FacebookAppID];

    facebook.accessToken = [defs stringForKey:facebookAccessTokenKey];
    facebook.expirationDate = [defs objectForKey:facebookExpirationDateKey];   
    
//    facebook = [[Facebook alloc] initWithAppId:kAppId andDelegate:self.SplashController];
//    
//    // Check and retrieve authorization information
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    if ([defaults objectForKey:@"FBAccessTokenKey"] && [defaults objectForKey:@"FBExpirationDateKey"]) {
//        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
//        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
//    }
//    
//    // Initialize API data (for views, etc.)
//    apiData = [[DataSet alloc] init];
//    if (!kAppId) {
//        UIAlertView *alertView = [[UIAlertView alloc]
//                                  initWithTitle:@"Setup Error"
//                                  message:@"Missing app ID. You cannot run the app until you provide this in the code."
//                                  delegate:self
//                                  cancelButtonTitle:@"OK"
//                                  otherButtonTitles:nil,
//                                  nil];
//        [alertView show];
//        [alertView release];
//    } else {
//        // Now check that the URL scheme fb[app_id]://authorize is in the .plist and can
//        // be opened, doing a simple check without local app id factored in here
//        NSString *url = [NSString stringWithFormat:@"fb%@://authorize",kAppId];
//        BOOL bSchemeInPlist = NO; // find out if the sceme is in the plist file.
//        NSArray* aBundleURLTypes = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleURLTypes"];
//        if ([aBundleURLTypes isKindOfClass:[NSArray class]] &&
//            ([aBundleURLTypes count] > 0)) {
//            NSDictionary* aBundleURLTypes0 = [aBundleURLTypes objectAtIndex:0];
//            if ([aBundleURLTypes0 isKindOfClass:[NSDictionary class]]) {
//                NSArray* aBundleURLSchemes = [aBundleURLTypes0 objectForKey:@"CFBundleURLSchemes"];
//                if ([aBundleURLSchemes isKindOfClass:[NSArray class]] &&
//                    ([aBundleURLSchemes count] > 0)) {
//                    NSString *scheme = [aBundleURLSchemes objectAtIndex:0];
//                    if ([scheme isKindOfClass:[NSString class]] &&
//                        [url hasPrefix:scheme]) {
//                        bSchemeInPlist = YES;
//                    }
//                }
//            }
//        }
//        // Check if the authorization callback will work
//        BOOL bCanOpenUrl = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString: url]];
//        if (!bSchemeInPlist || !bCanOpenUrl) {
//            UIAlertView *alertView = [[UIAlertView alloc]
//                                      initWithTitle:@"Setup Error"
//                                      message:@"Invalid or missing URL scheme. You cannot run the app until you set up a valid URL scheme in your .plist."
//                                      delegate:self
//                                      cancelButtonTitle:@"OK"
//                                      otherButtonTitles:nil,
//                                      nil];
//            [alertView show];
//            [alertView release];
//        }
//    }

    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    BOOL ret = [facebook handleOpenURL:url]; 
    NSLog(@"%d",ret);
	return ret;
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [self.facebook handleOpenURL:url];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
