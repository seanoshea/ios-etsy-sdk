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

/**
 `SOSEtsyResult` contains state and behaviour which is shared across all 'result' classes.
 */

@interface SOSEtsyResult : NSObject

/**
 A collection of domain objects returned from the API server. This is the meat of the response.
 */
@property (nonatomic, copy) NSMutableArray *results;

/**
 Optionally populated with errors returned from the API server.
 */
@property (nonatomic, strong) NSError *error;

/**
 HTTP status code.
 */
@property (nonatomic) NSInteger code;

@end
