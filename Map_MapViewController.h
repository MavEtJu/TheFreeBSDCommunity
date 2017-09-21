//
//  MapViewController.h
//  Map
//
//  Created by Edwin Groothuis on 23/04/10.
//  Copyright - 2010. All rights reserved.
//

#import "FreeBSD Community.h"

@interface MapViewController : UIViewController <MKMapViewDelegate> {
	MKMapView *mapView;
	UIView *contentView;
	MapData *data;
	Sizes *sizes;
	
	NSString *dataFileTime, *dataFileDate, *dataFileRev;
}

@property (nonatomic,strong) MapData *data;

@end
