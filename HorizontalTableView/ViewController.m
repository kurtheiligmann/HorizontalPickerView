//
//  ViewController.m
//  HorizontalTableView
//
//  Created by Kurt Heiligmann on 9/26/15.
//  Copyright © 2015 Kurt Heiligmann. All rights reserved.
//

#import "HorizontalPickerCell.h"
#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, HorizontalPickerCellDelegate, HorizontalPickerCellDataSource>
@end

@implementation ViewController

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CellId";
    
    HorizontalPickerCell *cell = (HorizontalPickerCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [HorizontalPickerCell instanceFromXib];
        cell.delegate = self;
        cell.dataSource = self;
    }
    
//    NSMutableArray *views = [NSMutableArray array];
//    for (NSInteger i = 0; i < 15; i++) {
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
//        label.text = [NSString stringWithFormat:@"%li", (long)i];
//        label.textAlignment = NSTextAlignmentCenter;
//        [views addObject:label];
//    }
    
    return cell;
}

#pragma mark - HorizontalPickerCellDataSource

- (NSInteger)numberOfItems {
    return 15;
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
