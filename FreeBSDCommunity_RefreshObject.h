//
//  FreeBSDCommunity_RefreshObject.h
//  FreeBSD_Community
//
//  Created by Edwin Groothuis on 16/05/10.
//  Copyright 2010 -. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FreeBSDCommunity_RefreshFlag : NSObject {
	BOOL forced;
}

@property (nonatomic) BOOL forced;

@end;

@interface FreeBSDCommunity_RefreshObject : NSObject {
	BOOL forced;
	
	BOOL loadingMapData;
	BOOL loadingNewsflashData;
	BOOL loadingUpcomingEventsData;
	BOOL loadingYoutubeData;
	BOOL loadingPlanetFreeBSDData;

	BOOL failedMapData;
	BOOL failedNewsflashData;
	BOOL failedUpcomingeventsData;
	BOOL failedYoutubeData;
	BOOL failedPlanetFreeBSDData;
	
	UIActivityIndicatorView *progressViewNewsflash;
	UIActivityIndicatorView *progressViewCommittersMap;
	UIActivityIndicatorView *progressViewYoutubeVideos;
	UIActivityIndicatorView *progressViewUpcomingEvents;
	UIActivityIndicatorView *progressViewPlanetFreeBSD;

	UILabel *labelNewsflash;
	UILabel *labelCommittersMap;
	UILabel *labelYoutubeVideos;
	UILabel *labelUpcomingEvents;
	UILabel *labelPlanetFreeBSD;
}

@property (nonatomic) BOOL forced;

@property (nonatomic) BOOL loadingMapData;
@property (nonatomic) BOOL loadingNewsflashData;
@property (nonatomic) BOOL loadingUpcomingEventsData;
@property (nonatomic) BOOL loadingYoutubeData;
@property (nonatomic) BOOL loadingPlanetFreeBSDData;

@property (nonatomic) BOOL failedMapData;
@property (nonatomic) BOOL failedNewsflashData;
@property (nonatomic) BOOL failedUpcomingeventsData;
@property (nonatomic) BOOL failedYoutubeData;
@property (nonatomic) BOOL failedPlanetFreeBSDData;

@property (nonatomic, retain) UIActivityIndicatorView *progressViewNewsflash;
@property (nonatomic, retain) UIActivityIndicatorView *progressViewCommittersMap;
@property (nonatomic, retain) UIActivityIndicatorView *progressViewYoutubeVideos;
@property (nonatomic, retain) UIActivityIndicatorView *progressViewUpcomingEvents;
@property (nonatomic, retain) UIActivityIndicatorView *progressViewPlanetFreeBSD;

@property (nonatomic, retain) UILabel *labelNewsflash;
@property (nonatomic, retain) UILabel *labelCommittersMap;
@property (nonatomic, retain) UILabel *labelYoutubeVideos;
@property (nonatomic, retain) UILabel *labelUpcomingEvents;
@property (nonatomic, retain) UILabel *labelPlanetFreeBSD;

- (void)resetLoading;
- (void)resetFailed;
- (void)startAnimations;
- (void)stopAnimations;
- (void)labelUpdating;
- (BOOL)anythingBeingLoaded;

@end
