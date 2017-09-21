//
//  Youtube_YoutubeData.m
//  FreeBSD_Community
//
//  Created by Edwin Groothuis on 7/05/10.
//  Copyright 2010 -. All rights reserved.
//

#import "FreeBSD Community.h"

@implementation YoutubeData

@synthesize items, restricted;

- (YoutubeData *)init
{
	self = [super init];
	items = nil;
	lastUpdate = nil;
	return(self);
}

/*
 * XML Handling of the file books.xml
 */
- (void) parse:(NSData *)data 
{	
    // here, for some reason you have to use NSClassFromString when trying to alloc NSXMLParser, otherwise you will get an object not found error
    // this may be necessary only for the toolchain
	
    NSXMLParser *rssParser = [[NSXMLParser alloc] initWithData:data];
	
    [rssParser setDelegate:self];
    [rssParser setShouldProcessNamespaces:NO];
    [rssParser setShouldReportNamespacePrefixes:NO];
    [rssParser setShouldResolveExternalEntities:NO];

	index = 0;
	inItem = 0;
    [rssParser parse];
}

- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
	NSString * errorString = [NSString stringWithFormat:@"Youtube parser error (Error code %i)", [parseError code]];
	NSLog(@"error parsing XML: %@", errorString);
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
  qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
	currentElement = elementName;
	currentText = nil;
	index++;
	
	if (inItem) {
		if ([elementName compare:@"content"] == NSOrderedSame) {
			[currentItem setLink:[attributeDict objectForKey:@"src"]];
			return;
		}
		if ([elementName compare:@"yt:state"] == NSOrderedSame) {
			[currentItem setState:[attributeDict objectForKey:@"name"]];
			restricted++;
			return;
		}
	}
	
	if ([currentElement compare:@"entry"] == NSOrderedSame) {
		inItem = TRUE;
		currentItem = [[YTObject alloc] init];
		[items addObject:currentItem];
	}
	
	return;
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
  qualifiedName:(NSString *)qName
{
	index--;
	[currentText replaceOccurrencesOfRegex:@"\\s+" withString:@" "];
	
	if (inItem) {
		if ([elementName compare:@"title"] == NSOrderedSame) {
			[currentItem setTitle:currentText];
			return;
		}
		if ([elementName compare:@"media:description"] == NSOrderedSame) {
			[currentItem setDescription:currentText];
			return;
		}
		if ([elementName compare:@"published"] == NSOrderedSame) {
			[currentItem setPubdate:currentText];
			return;
		}
		
		if ([elementName compare:@"entry"] == NSOrderedSame) {
			inItem = FALSE;
			[currentItem fillup];
			return;
		}
		
	}
	
	currentText = nil;
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if (string == nil)
		return;
	if (currentText == nil)
		currentText = [[NSMutableString alloc] initWithString:string];
	else
		[currentText appendString:string];
	return;
}

- (NSString *)getLastUpdate
{
	NSString *path = [[NSString alloc] initWithFormat:@"%@/videos-1.xml", workingDir()];
	NSFileManager *fm = [[NSFileManager alloc] init];
	if ([fm fileExistsAtPath:path] == FALSE)
		return @"No data-file yet";
	return [[NSString alloc] initWithString:getDiffString([[[fm attributesOfItemAtPath:path error:nil] objectForKey:NSFileModificationDate] timeIntervalSinceNow])];
}	

- (void) loadDataFromSource:(BOOL)force
{
	LOADDATAMSG;
	NSInteger videoindex = 0;
	NSInteger maxnum = 0;
	
	if ([internetReach currentReachabilityStatus] == NotReachable)
		return;

	refreshObject.failedYoutubeData = NO;
	
	SHOWNETWORK(YES);
	while (1) {
		NSString *path = [[NSString alloc] initWithFormat:@"%@/videos-%d.xml", workingDir(), videoindex];
		NSString *urlstring = [[NSString alloc] initWithFormat:@"http://gdata.youtube.com/feeds/api/videos?author=bsdconferences&orderby=published&start-index=%d&max-results=50&v=2&prettyprint=true", videoindex * 50 + 1];
		
		NSURL *url = [[NSURL alloc] initWithString:urlstring];
		NSData *data;
		
		NSFileManager *fm = [[NSFileManager alloc] init];
		if (force == TRUE || [fm fileExistsAtPath:path] == FALSE) {
			data = [[NSData alloc] initWithContentsOfURL:url];
			
			if (videoindex == 0) {
				NSString *dataString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
				if (dataString == nil || [dataString length] == 0) {
					refreshObject.failedYoutubeData = YES;
					break;
				}
				NSArray *lineData = [dataString arrayOfCaptureComponentsMatchedByRegex:@".openSearch:totalResults.(\\d+)."];
				NSString *maxnumString = [[lineData objectAtIndex:0] objectAtIndex:1];
				maxnum = [maxnumString integerValue];
			}
			
			if (data == nil) {
				refreshObject.failedYoutubeData = YES;
				SHOWNETWORK(NO);
				return;		
			}			
			
			[data writeToFile:path atomically:YES];
		}

		maxnum -= 50;
		if (maxnum <= 0)
			break;
		videoindex++;
	}
	refreshObject.labelYoutubeVideos.text = @"Fresh data";
	SHOWNETWORK(NO);
}


- (void) parseData
{
	PARSEDATAMSG;
	NSInteger videoindex = 0;
	NSInteger numbefore = 0;
	
	items = [[NSMutableArray alloc] initWithCapacity:20];
	
	restricted = 0;
	
	while (1) {
		NSLog(@"YouTube video %d", videoindex);
		NSString *path = [[NSString alloc] initWithFormat:@"%@/videos-%d.xml", workingDir(), videoindex];
		NSData *data;
		
		NSFileManager *fm = [[NSFileManager alloc] init];
		NSDictionary *d = [fm attributesOfItemAtPath:path error:NULL];
		if (d == nil)
			break;
		NSTimeInterval diff = -[[d objectForKey:NSFileModificationDate] timeIntervalSinceNow];
		data = [[NSData alloc] initWithContentsOfFile:path];
	
		lastUpdate = [[NSString alloc] initWithString:getDiffString(diff)];
		[self parse:data];
		
		if (numbefore == [items count])
			break;
		numbefore = [items count];
		
		videoindex++;
	}
	
	{
		NSString *seenpath = [[NSString alloc] initWithFormat:@"%@/seen.data", workingDir()];
		NSString *fileContents = [[NSString alloc] initWithContentsOfFile:seenpath encoding:NSASCIIStringEncoding error:nil];
		NSArray *lines = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
		for (int idx = 0; idx < lines.count; idx++) {
			NSString *line = [lines objectAtIndex:idx];
			
			NSEnumerator *itemEnum = [items objectEnumerator];
			YTObject *item;
			while ((item = [itemEnum nextObject])) {	
				if ([item.link compare:line] == NSOrderedSame) {
					[item setSeen:YES];
					break;
				}
			}				
		}
	}
}

@end
