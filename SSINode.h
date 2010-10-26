//
//  SSINode.h
//  Juju
//
//  Created by Saravudh Sinsomros on 10/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSINode : NSObject {
	NSString *name;
}

@property (nonatomic,retain) NSString *name;

-(SSINode*) appendChild:(SSINode*) aNode;
-(SSINode*) removeChild:(SSINode*) aNode;
-(NSArray*) childNodes;
-(NSArray*) attributes;
-(SSINode*) firstChild;
-(SSINode*) lastChild;
-(BOOL) hasChildNodes;
-(BOOL) hasAttributes;

@end
