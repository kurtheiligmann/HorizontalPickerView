//
//  HorizontalPickerCell.m
//  HorizontalTableView
//
//  Created by Kurt Heiligmann on 9/26/15.
//  Copyright © 2015 Kurt Heiligmann. All rights reserved.
//

#import "HorizontalPickerCell.h"

@interface HorizontalPickerCell()<UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@end

@implementation HorizontalPickerCell

+ (id)instanceFromXib {
    HorizontalPickerCell *instance = [[NSBundle bundleForClass:[self class]] loadNibNamed:[[self class] description] owner:nil options:nil][0];
    return instance;
}

- (NSString *)reuseIdentifier {
    return [[self class] description];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.contentSize = CGSizeMake(self.collectionView.contentSize.width + self.bounds.size.width, self.collectionView.contentSize.height);
}

- (NSInteger)selectedItemIndex {
    CGFloat itemWidth = [self.dataSource itemWidth];
    CGFloat collectionViewOffset = self.scrollView.contentOffset.x;
    
    CGFloat numberOfItemsScrolled = collectionViewOffset / itemWidth;
    
    return (int)round(numberOfItemsScrolled);
}

- (void)setDataSource:(id<HorizontalPickerCellDataSource>)dataSource {
    _dataSource = dataSource;
    CGFloat itemWidth = [self.dataSource itemWidth];
    CGRect collectionViewFrame = CGRectMake(self.bounds.size.width / 2 - (itemWidth / 2), 0, [self.dataSource numberOfItems] * itemWidth, self.bounds.size.height);

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:[NSBundle bundleForClass:[self class]]] forCellWithReuseIdentifier:@"cellId"];
    self.collectionView.backgroundColor = [UIColor orangeColor];
    self.collectionView.scrollEnabled = NO;
    
    [self.scrollView addSubview:self.collectionView];
    self.scrollView.contentSize = CGSizeMake(self.collectionView.frame.size.width + self.scrollView.frame.size.width - itemWidth, self.scrollView.frame.size.height);
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
