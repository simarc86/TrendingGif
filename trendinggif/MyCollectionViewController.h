//
//  MyCollectionViewController.h
//  trendinggif
//
//  Created by Marc Tamarit Romero on 20/6/17.
//  Copyright © 2017 Marc Tamarit Romero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionViewController : UICollectionViewController<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic,strong) NSArray *gifs;

@end
