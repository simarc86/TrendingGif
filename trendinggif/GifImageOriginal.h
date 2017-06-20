//
//  GifImageOriginal.h
//  trendinggif
//
//  Created by Marc Tamarit Romero on 20/6/17.
//  Copyright © 2017 Marc Tamarit Romero. All rights reserved.
//

#import "GifImage.h"

@interface GifImageOriginal : GifImage

/** Size of this GIF */
@property (readonly, nonatomic) NSUInteger size;
/** Number of frames in this GIF */
@property (readonly, nonatomic) NSUInteger frames;
/** URL for mp4 of this GIF */
@property (readonly, nonatomic, strong) NSURL * mp4;
@end
