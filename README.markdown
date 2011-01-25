# DESCRIPTION

Juju: A nice Objective-C wrapper on the XPathQuery library for parsing HTML with additional nodes extended from Hpple.

Inspired by [Hpple](https://github.com/topfunky/hpple).

# AUTHOR

Saravudh Sinsomros

# FEATURES

* Easy searching by XPath (CSS selectors are planned)
* Parses HTML (XML coming soon)
* Easy access to tag content, name, and attributes.
* Easy access to child node. 

# INSTALLATION

* Open your XCode project.
* Drag the "Juju.xcodeproj" directory to your project.
* Add the libxml2.2.dylib framework to your project and search paths as described at [Cocoa with Love](http://cocoawithlove.com/2008/10/using-libxml2-for-parsing-and-xpath.html)

# USAGE

<pre>
#import "SSJuju.h"
#import "SSNode.h"

SSJuju *doc = [[[SSJuju alloc] initWithHTMLData:aContent] autorelease];
NSArray * data = [doc search:@"//a[@class='awesome']"];
for (SSNode *e in a) {
	SSINode *rowNode = [e firstChild];	// Access to childnode
	while ((rowNode = rowNode.right)) {	// Access to sibling node
		[rowNode attributeByName:@"id"] // Easy access to attribute
		[rowNode name];					//tag name	
	}
}
</pre>
