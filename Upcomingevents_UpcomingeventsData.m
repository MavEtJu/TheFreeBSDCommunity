//
//  Upcomingevents_UpcomingeventsData.m
//  FreeBSD_Community
//
//  Created by Edwin Groothuis on 7/05/10.
//  Copyright 2010 -. All rights reserved.
//

#import "FreeBSD Community.h"

@implementation UpcomingeventsData

@synthesize items;

- (UpcomingeventsData *)init
{
	self = [super init];
	path = [[NSString alloc] initWithFormat:@"%@/events.xml", workingDir()];
	url = [[NSURL alloc] initWithString:@"http://www.FreeBSD.org/events/rss.xml"];
	lastUpdate = nil;
	items = nil;
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
	NSString * errorString = [NSString stringWithFormat:@"UpcomingEvents parser error (Error code %i)", [parseError code]];
	NSLog(@"error parsing XML: %@", errorString);
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
  qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
	currentElement = elementName;
	currentText = nil;
	index++;
	
	if ([currentElement compare:@"item"] == NSOrderedSame) {
		inItem = TRUE;
		currentItem = [[UEObject alloc] init];
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
		if ([elementName compare:@"description"] == NSOrderedSame) {
			[currentItem setDescription:currentText];
			return;
		}
		if ([elementName compare:@"pubDate"] == NSOrderedSame) {
			[currentItem setPubdate:currentText];
			return;
		}
		if ([elementName compare:@"link"] == NSOrderedSame) {
			[currentItem setLink:currentText];
			
			return;
		}
		
		if ([elementName compare:@"item"] == NSOrderedSame) {
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
	NSFileManager *fm = [[NSFileManager alloc] init];
	if ([fm fileExistsAtPath:path] == FALSE)
		return @"No data-file yet";
	return [[NSString alloc] initWithString:getDiffString([[[fm attributesOfItemAtPath:path error:nil] objectForKey:NSFileModificationDate] timeIntervalSinceNow])];
}

- (void)loadDataFromSource:(BOOL)force
{
	LOADDATAMSG;
	NSFileManager *fm = [[NSFileManager alloc] init];
	if (force == FALSE && [fm fileExistsAtPath:path] == TRUE) {
		lastUpdate = [[NSString alloc] initWithString:getDiffString([[[fm attributesOfItemAtPath:path error:nil] objectForKey:NSFileModificationDate] timeIntervalSinceNow])];
		refreshObject.labelUpcomingEvents.text = lastUpdate;
		return;
	}

	if ([internetReach currentReachabilityStatus] == NotReachable)
		return;
	
	refreshObject.failedUpcomingeventsData = NO;
	
	SHOWNETWORK(YES);
	NSData *data = [[NSData alloc] initWithContentsOfURL:url];
	SHOWNETWORK(NO);
	if (data == nil) {
		refreshObject.failedUpcomingeventsData = YES;
		return;		
	}
	
	[data writeToFile:path atomically:YES];
	lastUpdate = [[NSString alloc] initWithString:getDiffString([[[fm attributesOfItemAtPath:path error:nil] objectForKey:NSFileModificationDate] timeIntervalSinceNow])];
	refreshObject.labelUpcomingEvents.text = @"Fresh data";
}

- (void)parseData
{
	PARSEDATAMSG;
	NSData *data;
	
	items = [[NSMutableArray alloc] initWithCapacity:20];
	
	data = [[NSData alloc] initWithContentsOfFile:path];
	if (data == nil || [data length] == 0)
		return;
	
	[self parse:data];
}


@end
