//
//  Map_MapData.m
//  FreeBSD_Community
//
//  Created by Edwin Groothuis on 7/05/10.
//  Copyright 2010 -. All rights reserved.
//

#import "FreeBSD Community.h"

#define COMMITTERSFILE @"committers.dat"
#define COMMITTERSURL @"http://svnweb.freebsd.org/ports/head/astro/xearth/files/freebsd.committers.markers?view=co"

@implementation MapData

@synthesize items;

- (MapData *)init
{
	NSString *stringCommitters = COMMITTERSURL;
	url = [[NSURL alloc] initWithString:stringCommitters];
	path = [[NSString alloc] initWithFormat:@"%@/%@", workingDir(), COMMITTERSFILE];
	items = nil;
	lastUpdate = nil;
	return(self);
}

- (NSString *)getLastUpdate
{
	NSFileManager *fm = [[NSFileManager alloc] init];
	if ([fm fileExistsAtPath:path] == FALSE)
		return @"No data-file yet";
	return [[NSString alloc] initWithString:getDiffString([[[fm attributesOfItemAtPath:path error:nil] objectForKey:NSFileModificationDate] timeIntervalSinceNow])];
}

- (void)loadDataFromSource:(BOOL)force
{	
	LOADDATAMSG;
	NSFileManager *fm = [[NSFileManager alloc] init];
	if (force == FALSE && [fm fileExistsAtPath:path] == TRUE) {
		lastUpdate = [[NSString alloc] initWithString:getDiffString([[[fm attributesOfItemAtPath:path error:nil] objectForKey:NSFileModificationDate] timeIntervalSinceNow])];
		refreshObject.labelCommittersMap.text = lastUpdate;
		return;
	}
	
	if ([internetReach currentReachabilityStatus] == NotReachable)
		return;
	
	refreshObject.failedMapData = NO;
	
	SHOWNETWORK(YES);
	NSData *data = [[NSData alloc] initWithContentsOfURL:url];
	SHOWNETWORK(NO);
	
	if (data == nil) {
		refreshObject.failedMapData = YES;
		return;		
	}
		
	[data writeToFile:path atomically:YES];
	lastUpdate = [[NSString alloc] initWithString:getDiffString([[[fm attributesOfItemAtPath:path error:nil] objectForKey:NSFileModificationDate] timeIntervalSinceNow])];
	refreshObject.labelCommittersMap.text = @"Fresh data";
}

- (void)parseData
{
	PARSEDATAMSG;
	items = [[NSMutableArray alloc] initWithCapacity:20];

	NSString *contents = [[NSString alloc] initWithContentsOfFile:path encoding:NSASCIIStringEncoding error:nil];
	NSArray *lines = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];

	for (int idx = 1; idx < lines.count; idx++) {
		// break the string down even further to latitude and longitude fields. 
		NSString *line = [lines objectAtIndex:idx];
		
		if ([line length] == 0)
			continue;
		if ([line characterAtIndex:0] == '#')
			continue;
		
		/*  35.55,         139.67,         "   foo,bar" align=left        # Kawasaki, Kanagawa, Japan */
		NSArray *lineData = [line arrayOfCaptureComponentsMatchedByRegex:
							 @"^[ \t]*([\\+\\-\\d\\.]+),[ \t]*([\\+\\-\\d\\.]+),[ \t]*\"[\t ]*([^\"]+)\"[^#]*#(.*)$"];
		
		if ([lineData count] == 0)
			continue;
		if ([[lineData objectAtIndex:0] count] < 5)
			continue;
		
		NSArray *data = [lineData objectAtIndex:0];
		CLLocationDegrees latitude  = [[data objectAtIndex:1] doubleValue];
		CLLocationDegrees longitude = [[data objectAtIndex:2] doubleValue];
		NSMutableString *text = [[NSMutableString alloc] initWithString:[data objectAtIndex:3]];
		NSMutableString *loc = [[NSMutableString alloc] initWithString:[data objectAtIndex:4]];

		[text appendString:@" - "];
		[text appendString:loc];

		MapObject *item = [[MapObject alloc] init:text location:loc lat:latitude lon:longitude];
		[items addObject:item];
	}
}

@end
