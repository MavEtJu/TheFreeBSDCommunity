//
//  PlanetFreeBSD_PlanetFreeBSDData.h
//  FreeBSD_Community
//
//  Created by Edwin Groothuis on 7/05/10.
//  Copyright 2010 -. All rights reserved.
//

#import "FreeBSD Community.h"

@interface PlanetFreeBSDData : NSObject <NSXMLParserDelegate> {
	NSString *path;
	NSURL *url;

	NSInteger index;
	NSMutableArray *items;
	NSString *lastUpdate;
	
	PFBObject *currentItem;
	NSMutableString *currentText;
	NSString *currentElement;
	NSInteger inItem;
}

@property (nonatomic, retain) NSMutableArray *items;

- (void)loadDataFromSource:(BOOL)force;
- (void)parseData;
- (NSString *)getLastUpdate;

@end
