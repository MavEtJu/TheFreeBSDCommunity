//
//  MapAppDelegate.m
//  Map
//
//  Created by Edwin Groothuis on 23/04/10.
//  Copyright - 2010. All rights reserved.
//

#import "FreeBSD Community.h"

@implementation FreeBSD_CommunityAppDelegate

@synthesize window;
@synthesize mvc, nav;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

	internetReach = [Reachability reachabilityForInternetConnection];
	[internetReach startNotifer];
	refreshObject = [[FreeBSDCommunity_RefreshObject alloc] init];
	
	FreeBSD_CommunityViewController *fpvc = [[FreeBSD_CommunityViewController alloc] init];
	fpvc.title = @"The FreeBSD Community";
	nav = [[UINavigationController alloc] initWithRootViewController:fpvc];

	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	[window addSubview:nav.view];
    [window makeKeyAndVisible];
	freebsdApp = self;
	return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	NSLog(@"applicationWillTerminate");
	[NSString clearStringCache];
	/* This is where it ends... */
}

@end
