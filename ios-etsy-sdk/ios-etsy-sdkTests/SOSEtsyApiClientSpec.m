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

#import "Kiwi.h"

#import "SOSEtsyApiClient.h"

SPEC_BEGIN(SOSEtsyApiClientSpec)

describe(@"A Listings Request", ^{
    it(@"returns a viable response when presented with a viable API key", ^{
        [[SOSEtsyApiClient sharedInstance] initWithApiKey:@"l5k8bfu3uyvjy80n0o547zlq"];
        SOSEtsyListingsRequest *listingsRequest = [[SOSEtsyListingsRequest alloc] init];
        listingsRequest.shopId = @"5547100";
        
        __block SOSEtsyResult *returnedResult;
        __block SOSEtsyResult *returnedError;
        [[SOSEtsyApiClient sharedInstance] getListings:listingsRequest successBlock:^(SOSEtsyResult *result) {
            returnedResult = result;
        } failureBlock:^(SOSEtsyResult *error) {
            returnedError = error;
        }];

        [[expectFutureValue(returnedResult) shouldEventually] beNonNil];
        [[expectFutureValue(returnedError) shouldEventually] beNil];
    });
});

SPEC_END