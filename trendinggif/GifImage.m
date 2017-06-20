//
//  GifImage.m
//  trendinggif
//
//  Created by Marc Tamarit Romero on 20/6/17.
//  Copyright © 2017 Marc Tamarit Romero. All rights reserved.
//

#import "GifImage.h"


@interface GifImage ()
@property (strong, readwrite, nonatomic) NSURL * url;
@property (readwrite, nonatomic) CGFloat width;
@property (readwrite, nonatomic) CGFloat height;
@end

@implementation GifImage

- (instancetype) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.url = [NSURL URLWithString:dictionary[@"url"]];
    self.width = [dictionary[@"width"] floatValue];
    self.height = [dictionary[@"height"] floatValue];
    
    return self;
}


@end
