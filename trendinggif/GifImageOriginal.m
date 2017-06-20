//
//  GifImageOriginal.m
//  trendinggif
//
//  Created by Marc Tamarit Romero on 20/6/17.
//  Copyright © 2017 Marc Tamarit Romero. All rights reserved.
//

#import "GifImageOriginal.h"

@interface GifImageOriginal ()

@property (strong, readwrite, nonatomic) NSURL * url;
@property (readwrite, nonatomic) CGFloat width;
@property (readwrite, nonatomic) CGFloat height;
@property (readwrite, nonatomic) NSUInteger size;
@property (readwrite, nonatomic) NSUInteger frames;
@property (readwrite, nonatomic, strong) NSURL * mp4;
@end

@implementation GifImageOriginal
@synthesize url = _url, width = _width, height = _height;
- (instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (!self) {
        return nil;
    }
    
    self.size = [dictionary[@"size"] integerValue];
    self.frames = [dictionary[@"frames"] integerValue];
    self.mp4 = [NSURL URLWithString:dictionary[@"mp4"]];
    
    return self;
}
@end

