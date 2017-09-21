//
//  MavviesTools.h
//  Map
//
//  Created by Edwin Groothuis on 25/04/10.
//  Copyright 2010 -. All rights reserved.
//

#import "FreeBSD Community.h"

NSString *dataDir(void);
NSString *workingDir(void);
UIColor *backgroundGrey(NSInteger value);
NSString *getDiffString(NSTimeInterval diff);

#define DEALLOCMSG \
	NSLog(@"dealloc %s", __FILE__);
#define LOADDATAMSG \
	NSLog(@"loaddata %s", __FILE__);
#define PARSEDATAMSG \
	NSLog(@"parsedata %s", __FILE__);

#define ADJUSTLABEL(label, y) { \
	CGRect labelFrame = label.frame; \
	labelFrame.size.width = [sizes screenWidth] - 10; \
	label.frame = labelFrame; \
	[label sizeToFit]; \
	labelFrame = label.frame; \
	y += labelFrame.size.height; \
}

NSInteger networkActivityIndicator;
#define SHOWNETWORK(yesno) \
	@synchronized(freebsdApp) { \
/*		NSLog(@"networkActivityIndicator = %d, change is %d", networkActivityIndicator, yesno); */ \
		if (yesno == NO && networkActivityIndicator == 0) \
			NSLog(@"networkActivityIndicator < 0!"); \
		else \
			[UIApplication sharedApplication].networkActivityIndicatorVisible = ((networkActivityIndicator += (yesno ? +1 : -1)) == 0 ? NO : YES); \
	}

@interface Sizes : NSObject {
	CGSize appSize[2];
	BOOL knowOrientation[2];
	UIViewController *vc;
	UIInterfaceOrientation orientation;
}

- (Sizes *)init:(UIViewController *)_vc;
- (NSInteger) screenWidth;
- (NSInteger) screenHeight;
- (NSInteger) screenWidthL;
- (NSInteger) screenHeightL;
- (NSInteger) screenWidthP;
- (NSInteger) screenHeightP;
- (NSInteger) screenWidthMiddle;
- (NSInteger) screenHeightMiddle;
- (CGSize) screenSize;
- (CGRect)frameSize;
- (void) orientation:(UIInterfaceOrientation)interfaceOrientation;
- (UIInterfaceOrientation) currentOrientation;
- (void)reorientation;
- (void)learnOrientation;

@end

@interface UIProgressHUD : NSObject

- (void)show:(BOOL)yesOrNo;
- (UIProgressHUD *)initWithWindow:(UIView *)window;

@end
