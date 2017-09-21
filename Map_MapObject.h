//
//  Map_MapObject.h
//  FreeBSD_Community
//
//  Created by Edwin Groothuis on 7/05/10.
//  Copyright 2010 -. All rights reserved.
//

#import "FreeBSD Community.h"

@interface MapObject : NSObject {
	CLLocationCoordinate2D coordinates;
	NSString *name;
	NSString *location;
}

@property (nonatomic) CLLocationCoordinate2D coordinates;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *location;

- (MapObject *)init:(NSString *)_name location:(NSString *)_loc lat:(CLLocationDegrees)_lat lon:(CLLocationDegrees)_lon;

@end
