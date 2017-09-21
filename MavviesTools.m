//
//  MavviesTools.m
//  Map
//
//  Created by Edwin Groothuis on 25/04/10.
//  Copyright 2010 -. All rights reserved.
//

#import "FreeBSD Community.h"

NSString *getDiffString(NSTimeInterval diff)
{
	NSString *lastUpdate;
	if (diff < 0)
		diff = -diff;

	if (diff < 60)
		lastUpdate = [[NSString alloc] initWithFormat:@"%ld seconds ago", lround(floor(diff))];
	else if (diff < 2 * 60)
		lastUpdate = [[NSString alloc] initWithFormat:@"%ld minute ago", lround(floor(diff / 60))];
	else if (diff < 3600)
		lastUpdate = [[NSString alloc] initWithFormat:@"%ld minutes ago", lround(floor(diff / 60))];
	else if (diff < 2 * 3600)
		lastUpdate = [[NSString alloc] initWithFormat:@"%ld hour ago", lround(floor(diff / 3600))];
	else if (diff < 86400)
		lastUpdate = [[NSString alloc] initWithFormat:@"%ld hours ago", lround(floor(diff / 3600))];
	else if (diff < 2 * 86400)
		lastUpdate = [[NSString alloc] initWithFormat:@"%ld day ago", lround(floor(diff / 86400))];
	else 
		lastUpdate = [[NSString alloc] initWithFormat:@"%ld days ago", lround(floor(diff / 86400))];
	return lastUpdate;
}

NSString *dataDir(void)
{
	NSString *s = [[NSString alloc] initWithString:[[NSBundle mainBundle] resourcePath]];
	return(s);
}

NSString *workingDir(void)
{
	NSString *s = [[NSString alloc] initWithFormat:@"%@/%@", NSHomeDirectory(), @"Documents"];
	return(s);
}

UIColor *backgroundGrey(NSInteger value)
{
	CGFloat f;
	if (value %2 == 0)
		f = 0.9;
	else
		f = 0.8;
			
	return [UIColor colorWithRed:f green:f blue:f alpha:1.0];
}

@implementation Sizes

- (Sizes *)init:(UIViewController *)_vc
{
	UIApplication *app = [UIApplication sharedApplication];
	orientation = [app statusBarOrientation];
	vc = _vc;

	knowOrientation[0] = NO;
	knowOrientation[1] = NO;
	[self orientation:orientation];
	
	return(self);
}

- (void)learnOrientation
{
	knowOrientation[UIInterfaceOrientationIsLandscape(orientation)] = YES;
	CGRect appRect = [[UIScreen mainScreen] applicationFrame];
	UINavigationController *p = (UINavigationController *)[vc parentViewController];
	CGRect toolbarRect = [[p toolbar] frame];
	
	if (UIInterfaceOrientationIsLandscape(orientation)) {
		appSize[UIInterfaceOrientationIsLandscape(orientation)] = CGSizeMake(toolbarRect.size.width, appRect.size.width - toolbarRect.size.height);
	} else {
		appSize[UIInterfaceOrientationIsLandscape(orientation)] = CGSizeMake(appRect.size.width, appRect.size.height - toolbarRect.size.height);
	}
}

- (void)orientation:(UIInterfaceOrientation)interfaceOrientation
{
	orientation = interfaceOrientation;
	[self learnOrientation];
}
- (void)reorientation
{
	[self learnOrientation];
}
- (UIInterfaceOrientation)currentOrientation
{
	return(orientation);
}

- (NSInteger)screenWidth
{
	return(appSize[UIInterfaceOrientationIsLandscape(orientation)].width);
}

- (NSInteger)screenHeight
{
	return(appSize[UIInterfaceOrientationIsLandscape(orientation)].height);
}

- (NSInteger)screenWidthL
{
	return(appSize[UIInterfaceOrientationIsLandscape(UIInterfaceOrientationLandscapeLeft)].width);
}

- (NSInteger)screenHeightL
{
	return(appSize[UIInterfaceOrientationIsLandscape(UIInterfaceOrientationLandscapeLeft)].height);
}

- (NSInteger)screenWidthP
{
	return(appSize[UIInterfaceOrientationIsLandscape(UIInterfaceOrientationPortrait)].width);
}

- (NSInteger)screenHeightP
{
	return(appSize[UIInterfaceOrientationIsLandscape(UIInterfaceOrientationPortrait)].height);
}

- (NSInteger)screenWidthMiddle
{
	return(appSize[UIInterfaceOrientationIsLandscape(orientation)].width / 2);
}

- (NSInteger)screenHeightMiddle
{
	return(appSize[UIInterfaceOrientationIsLandscape(orientation)].height / 2);
}

- (CGSize)screenSize
{
	return(appSize[UIInterfaceOrientationIsLandscape(orientation)]);
}
- (CGRect)frameSize
{
	return(CGRectMake(0, 0, [self screenWidth], [self screenHeight]));
}

@end
