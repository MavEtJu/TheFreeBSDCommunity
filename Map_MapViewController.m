//
//  MapViewController.m
//  Map
//
//  Created by Edwin Groothuis on 23/04/10.
//  Copyright - 2010. All rights reserved.
//

#import "FreeBSD Community.h"

@implementation MapViewController

@synthesize data;

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[sizes orientation:toInterfaceOrientation];
	[super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return(YES);
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	[sizes reorientation];
	if (UIInterfaceOrientationIsPortrait([sizes currentOrientation])) {
		self.view.frame = CGRectMake(0, 0, [sizes screenWidthP], [sizes screenHeightP]);
		mapView.frame = CGRectMake(0, 0, [sizes screenWidthP], [sizes screenHeightP]);
	} else {
		self.view.frame = CGRectMake(0, 0, [sizes screenWidthL], [sizes screenHeightL]);
		mapView.frame = CGRectMake(0, 0, [sizes screenWidthL], [sizes screenHeightL]);
	}
	[super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

- (void)loadView
{
	sizes = [[Sizes alloc] init:self];

	dataFileRev = nil;
	dataFileDate = nil;
	dataFileTime = nil;
	
	contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [sizes screenWidth], [sizes screenHeight])];
	contentView.backgroundColor = [UIColor whiteColor];
	
	mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, [sizes screenWidth], [sizes screenHeight])];
	[contentView addSubview:mapView];
	[mapView setDelegate:self];
	
	
	NSMutableArray *points = [[NSMutableArray alloc] initWithCapacity:20];
	NSEnumerator *itemEnum = [[data items] objectEnumerator];
	MapObject *item;
	while ((item = [itemEnum nextObject])) {
		CLLocation* currentLocation = [[CLLocation alloc] initWithLatitude:item.coordinates.latitude longitude:item.coordinates.longitude];
		[points addObject:currentLocation];
		
		NSString *text = [[NSString alloc] initWithFormat:@"%@ - %@", [item name], [item location]];
		
		// create the start annotation and add it to the array
		CSMapAnnotation* annotation = [[CSMapAnnotation alloc] initWithCoordinate:[currentLocation coordinate]
																	annotationType:CSMapAnnotationTypeStart
																			 title:text];
		[mapView addAnnotation:annotation];
	}

	
	
	self.view = contentView;
}

- (void)viewDidDisappear:(BOOL)animated
{
    mapView = nil;
	contentView = nil;
    sizes = nil;
	dataFileTime = nil;
    dataFileDate = nil;
    dataFileRev = nil;
}

@end
