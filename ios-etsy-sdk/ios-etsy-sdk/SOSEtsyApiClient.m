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

#import "SOSEtsyApiClient.h"

#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"
#import "SOSEtsyListingsResult.h"
#import "SOSEtsyListing.h"
#import "SOSEtsyListingImage.h"
#import "SOSEtsyShop.h"
#import "SOSEtsyShopResult.h"

@interface SOSEtsyApiClient (Private)

- (void)basicSanityChecks:(SOSEtsyBaseRequest*)request;
- (SOSEtsyResult*)handleError:(NSError*)error withRequest:(NSURLRequest*)request andResponse:(NSHTTPURLResponse*)response responseJSON:(id)JSON;
@end

@implementation SOSEtsyApiClient

+ (SOSEtsyApiClient*)sharedInstance
{
    static SOSEtsyApiClient *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)initWithApiKey:(NSString*)apiKey
{
    [SOSEtsyApiClient sharedInstance].apiKey = apiKey;
}

- (NSOperation*)getListings:(SOSEtsyListingsRequest*)listingsRequest
               successBlock:(SOSEtsySuccessBlock)successBlock
               failureBlock:(SOSEtsyFailureBlock)failureBlock
{
    [self basicSanityChecks:listingsRequest];

    // generate the url
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", kApiBaseUrl]];
    NSString *path = [NSString stringWithFormat:@"shops/%@/listings/active", listingsRequest.shopId];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[SOSEtsyApiClient sharedInstance].apiKey, @"Images", nil] forKeys:[NSArray arrayWithObjects:@"api_key", @"includes", nil]];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:path parameters:parameters];

    // execute the request
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        id jsonResponse = [JSON objectForKey:@"results"];
        if (jsonResponse) {
            SOSEtsyListingsResult *result = [[SOSEtsyListingsResult alloc] init];
            result.code = 200;
            // great - got something usable back from the server. Time to parse out the listings.
            if ([jsonResponse isKindOfClass:[NSArray class]]) {
                for (id listing in jsonResponse) {
                    [result.results addObject:[SOSEtsyApiClient digestListingFromJSON:listing]];
                }
            } else {
                // must be just one active listing
                [result.results addObject:[SOSEtsyApiClient digestListingFromJSON:jsonResponse]];
            }
            if (successBlock) {
                successBlock(result);
            } else {
                NSLog(@"Could not communicate API success to client due to no success parameter being passed");
            }
        } else {
            // couldn't parse the json.
            if (failureBlock) {
                SOSEtsyResult *etsyListingError = [SOSEtsyApiClient handleError:nil withRequest:request andResponse:response responseJSON:JSON];
                failureBlock(etsyListingError);
            } else {
                NSLog(@"Could not communicate API failure to client due to no failure block being present");
            }
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        SOSEtsyResult *etsyListingError = [SOSEtsyApiClient handleError:error withRequest:request andResponse:response responseJSON:JSON];
        if (failureBlock) {
            failureBlock(etsyListingError);
        } else {
            NSLog(@"Could not communicate API failure to client due to no failure block being present");
        }
    }];
    [operation start];
    return operation;
}

- (NSOperation*)getShop:(SOSEtsyShopRequest*)shopRequest
           successBlock:(SOSEtsySuccessBlock)successBlock
           failureBlock:(SOSEtsyFailureBlock)failureBlock
{
    [self basicSanityChecks:shopRequest];
    
    // generate the url
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", kApiBaseUrl]];
    NSString *path = [NSString stringWithFormat:@"shops/%@", shopRequest.shopId];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[SOSEtsyApiClient sharedInstance].apiKey, nil] forKeys:[NSArray arrayWithObjects:@"api_key", nil]];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:path parameters:parameters];
    
    // execute the request
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        id jsonResponse = [JSON objectForKey:@"results"];
        if (jsonResponse) {
            SOSEtsyShopResult *result = [[SOSEtsyShopResult alloc] init];
            result.code = 200;
            // great - got something usable back from the server. Time to parse out the shop.
            if ([jsonResponse isKindOfClass:[NSArray class]]) {
                for (id shop in jsonResponse) {
                    [result.results addObject:[SOSEtsyApiClient digestShopFromJSON:shop]];
                }
            }
            if (successBlock) {
                successBlock(result);
            } else {
                NSLog(@"Could not communicate API success to client due to no success parameter being passed");
            }
        } else {
            // couldn't parse the json.
            if (failureBlock) {
                SOSEtsyResult *etsyListingError = [SOSEtsyApiClient handleError:nil withRequest:request andResponse:response responseJSON:JSON];
                failureBlock(etsyListingError);
            } else {
                NSLog(@"Could not communicate API failure to client due to no failure block being present");
            }
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        SOSEtsyResult *etsyListingError = [SOSEtsyApiClient handleError:error withRequest:request andResponse:response responseJSON:JSON];
        if (failureBlock) {
            failureBlock(etsyListingError);
        } else {
            NSLog(@"Could not communicate API failure to client due to no failure block being present");
        }
    }];
    [operation start];
    return operation;
}

- (void)basicSanityChecks:(SOSEtsyBaseRequest*)request
{
    NSAssert(self.apiKey, @"apiKey MUST be set before making any requests. See initWithApiKey method");
    NSAssert(request, @"The request being executed should not be nil");
}

+ (SOSEtsyResult*)handleError:(NSError*)error withRequest:(NSURLRequest*)request andResponse:(NSHTTPURLResponse*)response responseJSON:(id)JSON
{
    SOSEtsyResult *result = [[SOSEtsyResult alloc] init];
    if (error) {
        result.error = error;
    } else {
        // TODO ...
    }
    return result;
}

#pragma mark JSON parsing

+ (SOSEtsyListing*)digestListingFromJSON:(id)json
{
    SOSEtsyListing *listing = [[SOSEtsyListing alloc] init];
    id jsonImages = [json objectForKey:@"Images"];
    if (jsonImages) {
        if ([jsonImages isKindOfClass:[NSArray class]]) {
            for (id listingImage in jsonImages) {
                [listing.listingImages addObject:[SOSEtsyApiClient digestListingImageFromJSON:listingImage]];
            }
        } else {
            // just one image associated with this listing
            [listing.listingImages addObject:[SOSEtsyApiClient digestListingImageFromJSON:jsonImages]];
        }
    } else {
        // must be zero images associated with this listing?
    }
    id creation_tsz = [json objectForKey:@"creation_tsz"];
    if (creation_tsz) {
        listing.creationTimestamp = creation_tsz;
    }
    id currency_code = [json objectForKey:@"currency_code"];
    if (currency_code) {
        listing.currencyCode = currency_code;
    }
    id description = [json objectForKey:@"description"];
    if (description) {
        listing.description = description;
    }
    id listing_id = [json objectForKey:@"listing_id"];
    if (listing_id) {
        listing.listingId = listing_id;
    }
    id price = [json objectForKey:@"price"];
    if (price) {
        listing.price = [NSDecimalNumber decimalNumberWithString:price];
    }
    id quantity = [json objectForKey:@"quantity"];
    if (quantity) {
        listing.quantity = [quantity integerValue];
    }
    id title = [json objectForKey:@"title"];
    if (title) {
        listing.title = title;
    }
    id url = [json objectForKey:@"url"];
    if (url) {
        listing.url = url;
    }
    id when_made = [json objectForKey:@"when_made"];
    if (when_made) {
        listing.whenMade = when_made;
    }
    return listing;
}

+ (SOSEtsyListingImage*)digestListingImageFromJSON:(id)json
{
    SOSEtsyListingImage *image = [[SOSEtsyListingImage alloc] init];
    id url_170x135 = [json objectForKey:@"url_170x135"];
    if (url_170x135) {
        image.url_170x135 = url_170x135;
    }
    id url_570xN = [json objectForKey:@"url_570xN"];
    if (url_570xN) {
        image.url_570xN = url_570xN;
    }
    id url_75x75 = [json objectForKey:@"url_75x75"];
    if (url_75x75) {
        image.url_75x75 = url_75x75;
    }
    id url_fullxfull = [json objectForKey:@"url_fullxfull"];
    if (url_fullxfull) {
        image.url_fullxfull = url_fullxfull;
    }
    id listing_id = [json objectForKey:@"listing_id"];
    if (listing_id) {
        image.listing_id = listing_id;
    }
    id listing_image_id = [json objectForKey:@"listing_image_id"];
    if (listing_image_id) {
        image.listing_image_id = listing_image_id;
    }
    id full_width = [json objectForKey:@"full_width"];
    if (full_width) {
        image.full_width = [full_width intValue];
    }
    id full_height = [json objectForKey:@"full_height"];
    if (full_height) {
        image.full_height = [full_height intValue];
    }
    return image;
}

+ (SOSEtsyShop*)digestShopFromJSON:(id)json
{
    SOSEtsyShop *shop = [[SOSEtsyShop alloc] init];
    id is_vacation = [json objectForKey:@"is_vacation"];
    if (is_vacation) {
        shop.isOnVacation = [is_vacation boolValue];
    }
    id vacation_message = [json objectForKey:@"vacation_message"];
    if (vacation_message) {
        shop.vacationMessage = vacation_message;
    }
    return shop;
}

@end
