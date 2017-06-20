//
//  MyCollectionViewController.m
//  trendinggif
//
//  Created by Marc Tamarit Romero on 20/6/17.
//  Copyright © 2017 Marc Tamarit Romero. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "FetchGifs.h"
#import "MyCell.h"
#import <AnimatedGIFImageSerialization/AnimatedGIFImageSerialization.h>

@interface MyCollectionViewController ()

@end

@implementation MyCollectionViewController

@synthesize gifs;

static NSString * const reuseIdentifier = @"Cell";

#ifdef DEBUG
NSString * const kGiphyAPIKey = @"dc6zaTOxFJmzC";
#else
NSString * const kGiphyAPIKey; //Set private key
#endif


- (void)viewDidLoad {
    [super viewDidLoad];
    

    [FetchGifs setGiphyAPIKey:kGiphyAPIKey];

    [self getTrending];
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
}
- (void) getTrending
{
    [FetchGifs trendingGIFsWithlimit:10 offset:0 completion:^(NSArray *results, NSError *error) {
        gifs = results;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.collectionView reloadData];
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [gifs count];
}
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    FetchGifs * gif = gifs[indexPath.item];
    
    
    
    
    NSURLRequest * request = [NSURLRequest requestWithURL:gif.originalImage.url];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        UIImage * image = [UIImage imageWithData:data];

        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            cell.gifImageView.image = image;
        }];
    }] resume];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
