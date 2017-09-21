//
//  FreeBSDCommunity_RefreshObject.m
//  FreeBSD_Community
//
//  Created by Edwin Groothuis on 16/05/10.
//  Copyright 2010 -. All rights reserved.
//

#import "FreeBSDCommunity_RefreshObject.h"

@implementation FreeBSDCommunity_RefreshFlag

@synthesize forced;

@end;

@implementation FreeBSDCommunity_RefreshObject

@synthesize forced;
@synthesize progressViewNewsflash, progressViewUpcomingEvents, progressViewPlanetFreeBSD, progressViewCommittersMap, progressViewYoutubeVideos;
@synthesize labelNewsflash, labelUpcomingEvents, labelPlanetFreeBSD, labelCommittersMap, labelYoutubeVideos;
@synthesize loadingMapData, loadingNewsflashData, loadingUpcomingEventsData, loadingYoutubeData, loadingPlanetFreeBSDData;
@synthesize failedMapData, failedNewsflashData, failedUpcomingeventsData, failedYoutubeData, failedPlanetFreeBSDData;


- (FreeBSDCommunity_RefreshObject *)init
{
	forced = NO;
	[self resetLoading];
	[self resetFailed];
	progressViewNewsflash = nil;
	progressViewUpcomingEvents = nil;
	progressViewPlanetFreeBSD = nil;
	progressViewCommittersMap = nil;
	return(self);
}

- (void)resetLoading
{
	loadingMapData = NO;
	loadingNewsflashData = NO;
	loadingUpcomingEventsData = NO;
	loadingYoutubeData = NO;
	loadingPlanetFreeBSDData = NO;
}

- (void)resetFailed
{
	failedMapData = NO;
	failedNewsflashData = NO;
	failedUpcomingeventsData = NO;
	failedYoutubeData = NO;
	failedPlanetFreeBSDData = NO;
}

- (void)startAnimations
{
	[progressViewNewsflash startAnimating];
	[progressViewUpcomingEvents startAnimating];
	[progressViewPlanetFreeBSD startAnimating];
	[progressViewCommittersMap startAnimating];
	[progressViewYoutubeVideos startAnimating];		
}

- (void)stopAnimations
{
	[progressViewNewsflash stopAnimating];
	[progressViewUpcomingEvents stopAnimating];
	[progressViewPlanetFreeBSD stopAnimating];
	[progressViewCommittersMap stopAnimating];
	[progressViewYoutubeVideos stopAnimating];				
}

- (void)labelUpdating
{
	labelNewsflash.text = @"Updating now";
	labelUpcomingEvents.text = @"Updating now";
	labelPlanetFreeBSD.text = @"Updating now";
	labelCommittersMap.text = @"Updating now";
	labelYoutubeVideos.text = @"Updating now";
}

- (BOOL)anythingBeingLoaded
{
	if (loadingMapData == TRUE) return YES;
	if (loadingNewsflashData == TRUE) return YES;
	if (loadingUpcomingEventsData == TRUE) return YES;
	if (loadingYoutubeData == TRUE) return YES;
	if (loadingPlanetFreeBSDData == TRUE) return YES;
	return NO;
}

@end
