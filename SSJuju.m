//
//  SSJuju.m
//  Juju
//
//  Created by Saravudh Sinsomros on 10/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SSJuju.h"
#import "XPathQuery.h"

@implementation SSJuju
@synthesize data;

- (void) dealloc
{
	[data release];
	[super dealloc];
}

- (id) initWithData:(NSData *)theData isXML:(BOOL)isDataXML
{
	if (!(self = [super init]))
		return nil;
	
	self.data = theData;
	isXML = isDataXML;
	
	return self;
}

- (id) initWithXMLData:(NSData *)theData
{
	return [self initWithData:theData isXML:YES];
}

- (id) initWithHTMLData:(NSData *)theData
{
	return [self initWithData:theData isXML:NO];
}

// Returns all elements at xPath.
- (NSArray *) search:(NSString *)xPathOrCSS
{
	NSArray * detailNodes;
	if (isXML) {
		detailNodes = PerformXMLXPathQuery(data, xPathOrCSS);
	} else {
		detailNodes = PerformHTMLXPathQuery(data, xPathOrCSS);
	}
	
	return detailNodes;
}

@end
