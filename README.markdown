# DESCRIPTION

Juju: A nice Objective-C wrapper on the XPathQuery library for parsing HTML with additional nodes extended from [Hpple](https://github.com/topfunky/hpple).

# AUTHOR

Saravudh Sinsomros

# FEATURES

* Easy searching by XPath (CSS selectors are planned)
* Parses HTML (XML coming soon)
* Easy access to tag content, name, and attributes.
* Easy access to child node. 

# INSTALLATION

* Open your XCode project.
* Drag the "Juju.xcodeproj" file to your project.
* Add the libxml2.2.dylib framework to your project and search paths as described at [Cocoa with Love](http://cocoawithlove.com/2008/10/using-libxml2-for-parsing-and-xpath.html)

# USAGE

<pre>
#import "SSJuju.h"
#import "SSNode.h"

NSString *htmlstr = @"<html><a class='awesome'><b id='1'>One</b><b id='2'>Two</b></a></html>";
NSData *htmlData = [htmlstr dataUsingEncoding:NSASCIIStringEncoding];
SSJuju *doc = [[[SSJuju alloc] initWithHTMLData:htmlData] autorelease];
NSArray *elements = [doc search:@"//a[@class='awesome']"];
for (SSNode *e in elements) {
	SSINode *bNode = [e firstChild];						// Node "b"
	do {
		NSString *idValue = [bNode attributeByName:@"id"]; 	// Easy access to attribute
		NSString *nodeName = [bNode name];					//tag name
		NSString *nodeValue = [[bNode firstChild] description];
		NSLog(@"%@ : %@ : %@",idValue,nodeName,nodeValue);
	} while ((bNode = bNode.right));// Access to sibling node
}
</pre>

### Result
<pre>
1 : b : One
2 : b : Two
</pre>