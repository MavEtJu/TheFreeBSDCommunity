//
//  PlanetFreeBSD_PFBObject.h
//  FreeBSD_Community
//
//  Created by Edwin Groothuis on 4/05/10.
//  Copyright 2010 -. All rights reserved.
//

#import "FreeBSD Community.h"

@interface PFBObject : NSObject {
	NSString *title;
	NSString *name;
	NSString *description;
	NSString *pubdate;
	NSString *link;
	UIButton *button;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *pubdate;
@property (nonatomic, retain) NSString *link;
@property (nonatomic, strong) UIButton *button;

- (void) fillup;

@end
