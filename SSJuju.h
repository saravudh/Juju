//
//  SSJuju.h
//  Juju
//
//  Created by saravudh.sinsomros on 10/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SSJuju : NSObject {
	NSData * data;
	BOOL isXML;
}

@property (retain) NSData * data;

- (id) initWithData:(NSData *)theData isXML:(BOOL)isDataXML;

- (id) initWithHTMLData:(NSData *)theData;
- (id) initWithXMLData:(NSData *)theData;

- (SSNodeList *) search:(NSString *)xPathOrCSS;


@end
