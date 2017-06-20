//
//  MyCell.m
//  trendinggif
//
//  Created by Marc Tamarit Romero on 20/6/17.
//  Copyright © 2017 Marc Tamarit Romero. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) prepareForReuse
{
    [super prepareForReuse];
    self.gifImageView.image = nil;
}

@end
