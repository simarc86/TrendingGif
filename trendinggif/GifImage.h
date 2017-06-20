//
//  GifImage.h
//  trendinggif
//
//  Created by Marc Tamarit Romero on 20/6/17.
//  Copyright © 2017 Marc Tamarit Romero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GifImage : NSObject

/** URL for animated GIF*/
@property (readonly, strong, nonatomic) NSURL * url;
/** width for animated GIF*/
@property (readonly, nonatomic) CGFloat width;
/** height for animated GIF*/
@property (readonly, nonatomic) CGFloat height;
- (instancetype) initWithDictionary:(NSDictionary *) dictionary;

@end
