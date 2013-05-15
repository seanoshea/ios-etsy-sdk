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

NSString const *shopKeyConstant = @"";
NSString const *listingsKeyConstant = @"";
NSString const *shopResponse = @"";
NSString const *listingsResponse = @"";

@interface SOSTestURLInterceptor()

@property (nonatomic, strong) NSMutableDictionary *responses;
@property (nonatomic, strong) NSString *responseKey;

@end

@implementation SOSTestURLInterceptor

+ (SOSTestURLInterceptor*)sharedInterceptor
{
    static dispatch_once_t onceToken;
    static SOSTestURLInterceptor *interceptor;
    dispatch_once(&onceToken, ^{
        interceptor = [[self alloc] init];
        interceptor.responses = [[NSMutableDictionary alloc] init];
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
    NSData *responseData = [self.responses[self.responseKey] dataUsingEncoding:NSUTF8StringEncoding];
    NSURLResponse *response = [[NSURLResponse alloc] initWithURL:self.request.URL
                                                        MIMEType:@"text/plain"
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

- (void)setResponseKey:(NSString*)key
{
    self.responseKey = key;
}

- (void)addResponse:(NSString*)response forKey:(NSString*)key;
{
    self.responses[key] = response;
}

@end
