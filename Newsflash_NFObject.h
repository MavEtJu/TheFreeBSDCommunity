//
//  Newsflash_NFObject.h
//  FreeBSD_Community
//
//  Created by Edwin Groothuis on 5/05/10.
//  Copyright 2010 -. All rights reserved.
//

#import "FreeBSD Community.h"

@interface NFObject : NSObject {
	NSString *title;
	NSString *description;
	NSString *pubdate;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *pubdate;

- (void) fillup;

@end
