//
//  FetchGifs.h
//  trendinggif
//
//  Created by Marc Tamarit Romero on 20/6/17.
//  Copyright © 2017 Marc Tamarit Romero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GifImageOriginal.h"

@interface FetchGifs : NSObject

@property (readwrite, strong, nonatomic) NSURL * url;
@property (readwrite, strong, nonatomic) GifImageOriginal * originalImage;

+ (void) setGiphyAPIKey:(NSString *) APIKey;
+ (NSString *) giphyAPIKey;
+ (NSURLSessionDataTask *) trendingGIFsWithlimit:(NSUInteger) limit offset:(NSInteger) offset completion:(void (^) (NSArray * results, NSError * error)) block;
@end
