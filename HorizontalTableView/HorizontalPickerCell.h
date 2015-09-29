//
//  HorizontalPickerCell.h
//  HorizontalTableView
//
//  Created by Kurt Heiligmann on 9/26/15.
//  Copyright © 2015 Kurt Heiligmann. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HorizontalPickerCellDelegate;
@protocol HorizontalPickerCellDataSource;

@interface HorizontalPickerCell : UITableViewCell

@property (nonatomic, weak) id<HorizontalPickerCellDelegate> delegate;
@property (nonatomic, weak) id<HorizontalPickerCellDataSource> dataSource;
@property (nonatomic, readonly) NSInteger selectedItemIndex;

+ (id)instanceFromXib;

@end

@protocol HorizontalPickerCellDelegate <NSObject>

- (UIView *)viewForItemIndex:(NSInteger)itemIndex;
- (void)horizontalPicker:(HorizontalPickerCell *)horizontalPicker didSelectItemAtIndex:(NSInteger)itemIndex;

@end

@protocol HorizontalPickerCellDataSource <NSObject>

- (NSInteger)numberOfItems;
- (CGFloat)itemWidth;

@end
