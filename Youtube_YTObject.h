//
//  Youtube_YTObject.h
//  FreeBSD_Community
//
//  Created by Edwin Groothuis on 5/05/10.
//  Copyright 2010 -. All rights reserved.
//

#import "FreeBSD Community.h"

@interface YTObject : NSObject {
	NSString *title;
	NSString *description;
	NSString *pubdate;
	NSString *link;
	BOOL seen;
	NSString *state;
	UIButton *button;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *pubdate;
@property (nonatomic, retain) NSString *link;
@property (nonatomic, retain) NSString *state;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic) BOOL seen;

- (void) fillup;
- (void) setButton:(UIButton *)_button;
- (void) setSeen:(BOOL)_yesno;

@end
