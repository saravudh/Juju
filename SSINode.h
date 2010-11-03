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
	SSINode *parent;
	SSINode *left;
	SSINode *right;
}
@property (nonatomic,retain) SSINode *left;
@property (nonatomic,retain) SSINode *right;
@property (nonatomic,retain) SSINode *parent;
@property (nonatomic,retain) NSString *name;

-(id) initWithParent:(SSINode*) parent;
-(SSINode*) appendChild:(SSINode*) aNode;
-(SSINode*) removeChild:(SSINode*) aNode;
-(NSArray*) childNodes;
-(NSArray*) attributes;
-(NSString*) attributeByName:(NSString*) aName;
-(SSINode*) firstChild;
-(SSINode*) lastChild;
-(BOOL) hasChildNodes;
-(BOOL) hasAttributes;

@end
