//
//  XPathQuery.h
//  FuelFinder
//
//  Created by Matt Gallagher on 4/08/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//
//  Modified by Saravudh Sinsomros on 25/10/2010.

NSArray *PerformHTMLXPathQuery(NSData *document, NSString *query);
NSArray *PerformXMLXPathQuery(NSData *document, NSString *query);