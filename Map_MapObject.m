//
//  Map_MapObject.m
//  FreeBSD_Community
//
//  Created by Edwin Groothuis on 7/05/10.
//  Copyright 2010 -. All rights reserved.
//

#import "FreeBSD Community.h"

@implementation MapObject

@synthesize name, location, coordinates;

- (MapObject *)init:(NSString *)_name location:(NSString *)_loc lat:(CLLocationDegrees)_lat lon:(CLLocationDegrees)_lon;
{
	self = [super init];
	name = [[NSString alloc] initWithString:_name];
	location = [[NSString alloc] initWithString:_loc];
	coordinates.latitude = _lat;
	coordinates.longitude = _lon;
	return(self);
}

- (void)setName:(NSString *)_name
{
	name = [[NSString alloc] initWithString:_name];
}

- (void)setLocation:(NSString *)_location
{
	location = [[NSString alloc] initWithString:location];
}

- (void)setCoordinate:(CLLocationDegrees)lat longitude:(CLLocationDegrees)lon
{
	coordinates.latitude = lat;
	coordinates.longitude = lon;
}

- (void)fillup
{
	if (name == nil)
		name = @"";
	if (location == nil)
		location = @"";
}

@end
