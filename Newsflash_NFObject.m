//
//  Newsflash_NFObject.m
//  FreeBSD_Community
//
//  Created by Edwin Groothuis on 5/05/10.
//  Copyright 2010 -. All rights reserved.
//

#import "FreeBSD Community.h"

@implementation NFObject

@synthesize title, description, pubdate;

- (NFObject *)init
{
	title = nil;
	description = nil;
	pubdate = nil;
	return(self);
}
 
- (void)setTitle:(NSString *)_title
{
	title = [[NSString alloc] initWithString:_title];
}
 
- (void)setDescription:(NSString *)_description
{
	description = [[NSString alloc] initWithString:_description];
}
 
- (void)setPubdate:(NSString *)_pubdate
{
	pubdate = [[NSString alloc] initWithString:_pubdate];
}
 
- (void)fillup
{
	if (title == nil)
		title = @"";
	if (description == nil)
		description = @"";
	if (pubdate == nil)
		pubdate = @"";
}

@end
