//
//  SSINode.h
//  Juju
//
//  Created by Saravudh Sinsomros on 10/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

@interface SSINode : NSObject {

}

@property (weak) SSINode *left;
@property (weak) SSINode *right;
@property (weak) SSINode *parent;
@property (nonatomic,strong) NSString *name;

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
