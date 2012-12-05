//
//  SSJuju.h
//  Juju
//
//  Created by Saravudh Sinsomros on 10/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


@class SSNodeList;

@interface SSJuju : NSObject {
	NSData * data;
	BOOL isXML;
}

@property (strong) NSData * data;

- (id) initWithData:(NSData *)theData isXML:(BOOL)isDataXML;

- (id) initWithHTMLData:(NSData *)theData;
- (id) initWithXMLData:(NSData *)theData;

- (NSArray *) search:(NSString *)xPathOrCSS;


@end
