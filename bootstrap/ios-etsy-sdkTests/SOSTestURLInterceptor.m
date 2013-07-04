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

#import "SOSTestURLInterceptor.h"

NSString *shopKeyConstant = @"shopKeyConstant";
NSString *listingsKeyConstant = @"listingsKeyConstant";
NSString *shopResponse = @"{\"count\":1,\"results\":[{\"shop_id\":5547117,\"shop_name\":\"Uniquelywashers\",\"user_id\":7387574,\"creation_tsz\":1242422529,\"title\":\"Unique Washers\",\"policy_refunds\":\"I will be happy to exchange, fix, or refund any item that you are not happy with, shipping will not be refunded.  No refunds for items lost or damaged in shipping.\",\"policy_additional\":\"I am happy to take custom orders just contact me at dradar0669@comcast.net and lets talk about it.\",\"policy_seller_info\":\"\",\"policy_updated_tsz\":1364678451,\"vacation_autoreply\":\"I&#39;m on vacation but will get your questions answered as soon as I get back.  Thanks You\",\"url\":\"a\",\"image_url_760x100\":\"s\",\"num_favorers\":307,\"has_tax_preferences\":false,\"languages\":[\"en-US\"],\"error_messages\":[\"Access denied on association Images\"]}],\"params\":{\"shop_id\":\"5547117\"},\"type\":\"Shop\",\"pagination\":{}}";
NSString *listingsResponse = @"{\"count\": 24,\"results\": [{\"listing_id\": 127985847,\"state\": \"active\",\"user_id\": 7387574,\"category_id\": 68898588,\"title\": \"Alittle nutty earrings\",\"description\": \"Starburst washers, or lock washers, enhance to the look of a basic nut. The washer surrounds the nut giving it a special look. These are fun everyday earrings. 1.5 inches of dangle and bling.\",\"creation_tsz\": 1364679197,\"ending_tsz\": 1375156800,\"original_creation_tsz\": 1364679197,\"last_modified_tsz\": 1364679197,\"price\": \"5.00\",\"currency_code\": \"USD\",\"quantity\": 1,\"tags\": [\"steampunk\",\"repurposed\",\"hippy\"],\"category_path\": [\"Jewelry\",\"Earrings\",\"Metal\"],\"category_path_ids\": [68887482,69151501,68898588],\"materials\": [\"nickel\",\"metal\",\"silver plated jump rings\"],\"shop_section_id\": 6699266,\"featured_rank\": 0,\"state_tsz\": 1364679197,\"url\": \"k\",\"views\": 10,\"num_favorers\": 0,\"processing_min\": 3,\"processing_max\": 5,\"who_made\": \"i_did\",\"is_supply\": \"false\",\"when_made\": \"2010_2013\",\"is_private\": false,\"recipient\": null,\"occasion\": null,\"style\": [\"Industrial\",\"Steampunk\"],\"non_taxable\": false,\"is_digital\": false,\"file_data\": \"\",\"has_variations\": false,\"Images\": [{\"listing_image_id\": 443739416,\"hex_code\": \"86714F\",\"red\": 134,\"green\": 113,\"blue\": 79,\"hue\": 37,\"saturation\": 41,\"brightness\": 52,\"is_black_and_white\": false,\"creation_tsz\": 1364679197,\"listing_id\": 127985847,\"rank\": 1,\"url_75x75\": \"e\",\"url_170x135\": \"d\",\"url_570xN\": \"a\",\"url_fullxfull\": \"s\",\"full_height\": 1500,\"full_width\": 1209}]}]}";

@interface SOSTestURLInterceptor()

@property (nonatomic, copy) NSMutableDictionary *responses;
@property (nonatomic, copy) NSString *key;

@end

@implementation SOSTestURLInterceptor

+ (SOSTestURLInterceptor*)sharedInterceptor
{
    static dispatch_once_t onceToken;
    static SOSTestURLInterceptor *interceptor;
    dispatch_once(&onceToken, ^{
        interceptor = [[self alloc] init];
        interceptor.responses = [[NSMutableDictionary alloc] init];
        interceptor.responseKey = @"";
    });
    return interceptor;
}

+ (BOOL)canInitWithRequest:(NSURLRequest *)request
{
    return YES;
}

+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)aRequest toRequest:(NSURLRequest *)bRequest
{    
    return NO;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request
{
    return request;
}

- (void)startLoading
{
    SOSTestURLInterceptor *interceptor = [SOSTestURLInterceptor sharedInterceptor];
    NSData *responseData = [interceptor.responses[interceptor.key] dataUsingEncoding:NSUTF8StringEncoding];
    NSURLResponse *response = [[NSURLResponse alloc] initWithURL:self.request.URL
                                                        MIMEType:@"text/json"
                                           expectedContentLength:0                                                textEncodingName:@"UTF8"];
    [self.client URLProtocol:self
          didReceiveResponse:response
          cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    [self.client URLProtocol:self didLoadData:responseData];
    [self.client URLProtocolDidFinishLoading:self];
}

- (void)stopLoading
{
    [self.client URLProtocolDidFinishLoading:self];
}

- (void)setResponseKey:(NSString*)responseKey
{
    NSParameterAssert(responseKey);

    self.key = responseKey;
}

- (void)addResponse:(NSString*)response forKey:(NSString*)key;
{
    NSParameterAssert(key);
    NSParameterAssert(response);
    
    self.responses[key] = response;
}

@end
