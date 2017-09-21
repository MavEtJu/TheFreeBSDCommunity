//
//  Map_MapData.h
//  FreeBSD_Community
//
//  Created by Edwin Groothuis on 7/05/10.
//  Copyright 2010 -. All rights reserved.
//

#import "FreeBSD Community.h"

@interface MapData : NSObject <NSXMLParserDelegate> {
	NSString *path;
	NSURL *url;
	
	NSMutableArray *items;
	NSString *lastUpdate;
}

@property (nonatomic, retain) NSMutableArray *items;

- (void)loadDataFromSource:(BOOL)force;
- (void)parseData;
- (NSString *)getLastUpdate;

@end
