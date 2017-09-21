//
//  Youtube_YoutubeViewController.h
//  FreeBSD_Community
//
//  Created by Edwin Groothuis on 28/04/10.
//  Copyright 2010 -. All rights reserved.
//

#import "FreeBSD Community.h"

@interface YoutubeData : NSObject <NSXMLParserDelegate> {
	NSInteger index;
	NSInteger restricted;
	NSMutableArray *items;
	NSString *lastUpdate;
	
	NSMutableString *currentText;
	NSString *currentElement;
	YTObject *currentItem;
	NSInteger inItem;	
}

@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic) NSInteger restricted;

- (void) loadDataFromSource:(BOOL)force;
- (void) parseData;
- (NSString *)getLastUpdate;

@end
