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

#import <Foundation/Foundation.h>

#import "SOSEtsyBaseModel.h"

/**
 `SOSEtsyListing` defines what actually constitutes an Etsy listing.
 */
@interface SOSEtsyListing : SOSEtsyBaseModel

@property (nonatomic, copy) NSMutableArray *listingImages;
@property (nonatomic, copy) NSString *creationTimestamp;
@property (nonatomic, copy) NSString *currencyCode;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *listingId;
@property (nonatomic, strong) NSDecimalNumber *price;
@property (nonatomic) NSInteger quantity;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *whenMade;

@end
