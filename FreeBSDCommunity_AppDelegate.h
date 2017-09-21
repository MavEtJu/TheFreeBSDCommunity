//
//  MapAppDelegate.h
//  Map
//
//  Created by Edwin Groothuis on 23/04/10.
//  Copyright - 2010. All rights reserved.
//

#import "FreeBSD Community.h"

@class MapViewController;

@interface FreeBSD_CommunityAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MapViewController *mvc;
	UINavigationController *nav;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MapViewController *mvc;
@property (nonatomic, retain) IBOutlet UINavigationController *nav;

@end

FreeBSD_CommunityAppDelegate *freebsdApp;
NewsflashData *newsflashData;
UpcomingeventsData *upcomingEventsData;
YoutubeData *youtubeData;
PlanetFreeBSDData *planetFreeBSDData;
MapData *mapData;
Reachability *internetReach;
FreeBSDCommunity_RefreshObject *refreshObject;
