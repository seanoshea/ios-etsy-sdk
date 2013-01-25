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

#import "SOSEtsyApiClientTests.h"

#import "SOSEtsyApiClient.h"

@implementation SOSEtsyApiClientTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testListingsRequest
{
    SOSEtsyApiClient *client = [SOSEtsyApiClient sharedInstance];
    [client initWithApiKey:@"l5k8bfu3uyvjy80n0o547zlq"];
    SOSEtsyListingsRequest *listingsRequest = [[SOSEtsyListingsRequest alloc] init];
    listingsRequest.shopId = @"5547124";
    [client getListings:listingsRequest successBlock:nil failureBlock:nil];
    while (1)
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:5]];
    
}

@end
