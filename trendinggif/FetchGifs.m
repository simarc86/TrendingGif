//
//  FetchGifs.m
//  trendinggif
//
//  Created by Marc Tamarit Romero on 20/6/17.
//  Copyright © 2017 Marc Tamarit Romero. All rights reserved.
//

#import "FetchGifs.h"
#import <AFNetworking/AFURLRequestSerialization.h>

@implementation FetchGifs

static NSString * kGiphyAPIKey;

@synthesize url,originalImage;

- (instancetype) initWithDictionary: (NSDictionary *) dictionary
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.url = [NSURL URLWithString:dictionary[@"url"]];
    
    NSDictionary * images = dictionary[@"images"];
    self.originalImage = [[GifImageOriginal alloc] initWithDictionary:images[@"original"]];

   
    return self;
}

+ (NSURLRequest *) requestForEndPoint:(NSString *) endpoint params:(NSDictionary *) params
{
    NSString * base = @"http://api.giphy.com/v1/gifs";
    NSString * withEndPoint = [NSString stringWithFormat:@"%@%@", base, endpoint];
    NSError * error;
    
    NSMutableDictionary * paramsWithAPIKey = [NSMutableDictionary dictionaryWithDictionary:params];
    [paramsWithAPIKey setObject:kGiphyAPIKey forKey:@"api_key"];
    NSURLRequest * request =  [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:withEndPoint parameters:paramsWithAPIKey error:&error];
    return request;
}

+ (NSURLRequest *) giphyTrendingRequestWithLimit:(NSUInteger) limit offset:(NSUInteger) offset
{
    return [self requestForEndPoint:@"/trending" params:@{@"limit": @(limit), @"offset": @(offset)}];
}
+ (NSURLSessionDataTask *) trendingGIFsWithlimit:(NSUInteger) limit offset:(NSInteger) offset completion:(void (^) (NSArray * results, NSError * error)) block
{
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLRequest * request = [self giphyTrendingRequestWithLimit:limit offset:offset];
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // network error
        if (error) {
            block(nil, error);
        } else {
            // json serialize error
            NSError * error;
            NSDictionary * results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            error = error ?: [self customErrorFromResults:results];
            if (error) {
                block(nil, error);
            } else {
                NSArray * gifArray = [FetchGifs AXCGiphyArrayFromDictArray:results[@"data"]];
                block(gifArray, nil);
            }
        }
    }];
    [task resume];
    return task;
}
+ (NSError *)customErrorFromResults:(NSDictionary *)results
{
    NSArray * resultsData = results[@"data"];
    if ([resultsData count] == 0) {
        return [[NSError alloc] initWithDomain:@"com.giphy.ios" code:-1 userInfo:@{@"error_message" : @"No results were found"}];
    }
    return nil;
}
+ (NSArray *) AXCGiphyArrayFromDictArray:(NSArray *) array
{
    NSMutableArray * gifArray = [NSMutableArray new];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary * dict = obj;
        FetchGifs * gif = [[FetchGifs alloc] initWithDictionary:dict];
        [gifArray addObject:gif];
    }];
    return gifArray;
}
+ (void) setGiphyAPIKey:(NSString *) APIKey
{
    kGiphyAPIKey = APIKey;
}
+ (NSString *) giphyAPIKey
{
    return kGiphyAPIKey;
}

@end
