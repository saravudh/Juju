//
//  SSNode.h
//  Juju
//
//  Created by saravudh.sinsomros on 10/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SSNode : NSObject {
	NSString *name;
	NSString *text;
}
@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *text;

-(SSNode*) appendChild:(SSNode*) aNode;
-(SSNode*) removeChild:(SSNode*) aNode;
-(SSNodeList*) childNodes;
-(NSArray*) attributes;
-(SSNode*) firstChild;
-(SSNode*) lastChild;
-(BOOL) hasChildNodes;
-(BOOL) hasAttributes;

@end
