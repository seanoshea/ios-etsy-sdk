/*
 Copyright 2012 - 2013 Sean O' Shea
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "SOSEtsyListing.h"

@implementation SOSEtsyListing

@synthesize listingImages = _listingImages;
@synthesize creationTimestamp = _creationTimestamp;
@synthesize currencyCode = _currencyCode;
@synthesize description = _description;
@synthesize listingId = _listingId;
@synthesize price = _price;
@synthesize quantity = _quantity;
@synthesize title = _title;
@synthesize url = _url;
@synthesize whenMade = _whenMade;

- (id)init
{
	self = [super init];
	
	if (!self) {
		return nil;
	}
	
	// initialization
	_listingImages = [NSMutableArray array];

    return self;
}

@end
