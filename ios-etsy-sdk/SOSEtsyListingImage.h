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

#import <Foundation/Foundation.h>

#import "SOSEtsyBaseModel.h"

/**
 `SOSEtsyListingImage` defines an image which is typically associated with
 an 'SOSEtsyListing'
 */
@interface SOSEtsyListingImage : SOSEtsyBaseModel

@property (nonatomic, copy) NSString *url_170x135;
@property (nonatomic, copy) NSString *url_570xN;
@property (nonatomic, copy) NSString *url_75x75;
@property (nonatomic, copy) NSString *url_fullxfull;
@property (nonatomic) NSInteger full_height;
@property (nonatomic) NSInteger full_width;
@property (nonatomic, copy) NSString *listing_id;
@property (nonatomic, copy) NSString *listing_image_id;

@end
