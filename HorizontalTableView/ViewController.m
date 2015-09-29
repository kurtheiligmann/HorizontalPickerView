//
//  ViewController.m
//  HorizontalTableView
//
//  Created by Kurt Heiligmann on 9/26/15.
//  Copyright © 2015 Kurt Heiligmann. All rights reserved.
//

#import "HorizontalPickerCell.h"
#import "ViewController.h"

static NSInteger const kNumberOfRows = 5;

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, HorizontalPickerCellDelegate, HorizontalPickerCellDataSource>
@property (nonatomic, strong) NSMutableArray *cells;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cells = [NSMutableArray array];
    
    for (NSInteger i = 0; i < kNumberOfRows; i++) {
        [self.cells addObject:[NSNull null]];
    }
}

- (IBAction)getButtonPressed {
    for (HorizontalPickerCell *cell in self.cells) {
        if ([cell respondsToSelector:@selector(selectedItemIndex)]) {
            NSLog(@"%s: %li", __PRETTY_FUNCTION__, (long)cell.selectedItemIndex);
        }
    }
}

- (IBAction)setButtonPressed {
    for (HorizontalPickerCell *cell in self.cells) {
        if ([cell respondsToSelector:@selector(setSelectedItemIndex:)]) {
            cell.selectedItemIndex = 50;
            NSLog(@"%s: %li", __PRETTY_FUNCTION__, (long)cell.selectedItemIndex);
        }
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kNumberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CellId";
    
    HorizontalPickerCell *cell = (HorizontalPickerCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [HorizontalPickerCell instanceFromXib];
        cell.delegate = self;
        cell.dataSource = self;
    }
    
    [self.cells insertObject:cell atIndex:indexPath.row];
    
    return cell;
}

#pragma mark - HorizontalPickerCellDataSource

- (NSInteger)numberOfItems {
    return 15;
}

- (CGFloat)itemWidth {
    return 50;
}

#pragma mark - HorizontalPickerCellDelegate

- (UIView *)viewForItemIndex:(NSInteger)itemIndex {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    label.text = [NSString stringWithFormat:@"%li", (long)itemIndex];
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;
}

- (void)horizontalPicker:(HorizontalPickerCell *)horizontalPicker didSelectItemAtIndex:(NSInteger)itemIndex {
    
}

@end
