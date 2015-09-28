//
//  HorizontalPickerCell.m
//  HorizontalTableView
//
//  Created by Kurt Heiligmann on 9/26/15.
//  Copyright © 2015 Kurt Heiligmann. All rights reserved.
//

#import "HorizontalPickerCell.h"

@interface HorizontalPickerCell()<UICollectionViewDataSource, UIScrollViewDelegate>
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@end

@implementation HorizontalPickerCell

+ (id)instanceFromXib {
    HorizontalPickerCell *instance = [[NSBundle bundleForClass:[self class]] loadNibNamed:[[self class] description] owner:nil options:nil][0];
    [instance.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:[NSBundle bundleForClass:[self class]]] forCellWithReuseIdentifier:@"cellId"];
    instance.collectionView.backgroundColor = [UIColor orangeColor];
    return instance;
}

- (NSString *)reuseIdentifier {
    return [[self class] description];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.contentSize = CGSizeMake(self.collectionView.contentSize.width + self.bounds.size.width, self.collectionView.contentSize.height);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataSource numberOfItems];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"indexPath: %@", indexPath);
    static NSString *cellId = @"cellId";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    UIView *currentView = [self.delegate viewForItemIndex:indexPath.row];
    NSLog(@"currentView: %@", currentView);
    
    if (cell == nil) {
        cell = [[UICollectionViewCell alloc] initWithFrame:currentView.frame];
    }
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [cell.contentView addSubview:currentView];
    
    return cell;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%@", scrollView);
}

@end
