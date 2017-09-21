//
//  Youtube_YTObject.m
//  FreeBSD_Community
//
//  Created by Edwin Groothuis on 5/05/10.
//  Copyright 2010 -. All rights reserved.
//

#import "FreeBSD Community.h"

@implementation YTObject

@synthesize title, description, pubdate, link, state, button, seen;

- (YTObject *)init
{
	title = nil;
	description = nil;
	pubdate = nil;
	link = nil;
	seen = NO;
	state = nil;
	button = nil;
	return(self);
}

- (void)setTitle:(NSString *)_title
{
    title = [[NSString alloc] initWithString:_title];
}

- (void)setDescription:(NSString *)_description
{

    description = nil;
    if (_description != nil)
        description = [[NSString alloc] initWithString:_description];
}

- (void)setPubdate:(NSString *)_pubdate
{
    pubdate = nil;
    if (_pubdate != nil)
        pubdate = [[NSString alloc] initWithString:_pubdate];
}

- (void)setLink:(NSString *)_link
{
    link = nil;
    if (_link != nil)
        link = [[NSString alloc] initWithString:_link];
}

- (void)setButton:(UIButton *)_button
{
    button = nil;
    if (_button != nil)
        button = _button;
}

- (void)setSeen:(BOOL)_yesno
{
	seen = _yesno;
}

- (void)fillup
{
	if (title == nil)
		title = @"";
	if (link == nil)
		link= @"";
	if (description == nil)
		description = @"";
	if (pubdate == nil)
		pubdate = @"";
	if (state == nil)
		state = @"";
}

@end
