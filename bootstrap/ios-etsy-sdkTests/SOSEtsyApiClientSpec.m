/*
 Copyright 2012 - 2014 Sean O' Shea
 
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

#import <Kiwi/Kiwi.h>

#import "SOSEtsyApiClient.h"
#import "SOSTestURLInterceptor.h"

SPEC_BEGIN(SOSEtsyApiClientSpec)

describe(@"A Listings Request", ^{
    it(@"returns a viable response", ^{
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
        
        [[expectFutureValue(returnedResult) shouldEventually] shouldNotBeNil];
    });
});

describe(@"A Listings Request", ^{
    it(@"should be able to parse a viable response", ^{
        
        [NSURLProtocol registerClass:[SOSTestURLInterceptor class]];
        
        [[SOSTestURLInterceptor sharedInterceptor] addResponse:listingsResponse forKey:listingsKeyConstant];
        [[SOSTestURLInterceptor sharedInterceptor] setResponseKey:listingsKeyConstant];
        
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
        
        [[expectFutureValue(returnedResult) shouldEventually] shouldNotBeNil];
    });
});

describe(@"A Shop Request", ^{
    it(@"returns a viable response", ^{
        [[SOSEtsyApiClient sharedInstance] initWithApiKey:@"l5k8bfu3uyvjy80n0o547zlq"];
        SOSEtsyShopRequest *shopRequest = [[SOSEtsyShopRequest alloc] init];
        shopRequest.shopId = @"5547124";
        
        __block SOSEtsyResult *returnedResult;
        __block SOSEtsyResult *returnedError;
        [[SOSEtsyApiClient sharedInstance] getShop:shopRequest successBlock:^(SOSEtsyResult *result) {
            returnedResult = result;
        } failureBlock:^(SOSEtsyResult *error) {
            returnedError = error;
        }];
        
        [[expectFutureValue(returnedResult) shouldEventually] shouldNotBeNil];
    });
});

describe(@"A Shop Request", ^{
    it(@"should be able to parse a viable response", ^{
        
        [NSURLProtocol registerClass:[SOSTestURLInterceptor class]];
        
        [[SOSTestURLInterceptor sharedInterceptor] addResponse:shopResponse forKey:shopKeyConstant];
        [[SOSTestURLInterceptor sharedInterceptor] setResponseKey:shopKeyConstant];
        
        [[SOSEtsyApiClient sharedInstance] initWithApiKey:@"l5k8bfu3uyvjy80n0o547zlq"];
        SOSEtsyShopRequest *shopRequest = [[SOSEtsyShopRequest alloc] init];
        shopRequest.shopId = @"5547124";
        
        __block SOSEtsyResult *returnedResult;
        __block SOSEtsyResult *returnedError;
        [[SOSEtsyApiClient sharedInstance] getShop:shopRequest successBlock:^(SOSEtsyResult *result) {
            returnedResult = result;
        } failureBlock:^(SOSEtsyResult *error) {
            returnedError = error;
        }];
        
        [[expectFutureValue(returnedResult) shouldEventually] shouldNotBeNil];
    });
});

SPEC_END