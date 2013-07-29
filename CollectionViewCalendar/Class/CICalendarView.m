//
//  CICalendarView.m
//  CollectionViewCalendar
//
//  Created by shenghua wu on 13/7/10.
//  Copyright (c) 2013年 shenghua wu. All rights reserved.
//

#import "CICalendarView.h"
#import "NSDate+CICVComparison.h"
#import "NSDate+CICVHelper.h"
#import <QuartzCore/QuartzCore.h>

#define DateComponentsUnit NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit

#define AutoResizingMask UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight

#define ReuseCellIdentifier @"DateCell"
#define ReuseHeaderViewIdentifier @"HeaderView"

#define DateFormatterDay @"d"

#define HeaderViewHeight 20.0f

#define NumberOfDaysInAWeek 7
#define NumberOfDaysForSixRows 42

#define AnimationDuration 0.5f

@interface CICalendarView () <UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, weak) id <CICalendarViewDataSource> dataSource;
@property (nonatomic, weak) id <CICalendarViewDelegate> delegate;
@property (nonatomic, strong) NSDictionary *attributes;
@end

@implementation CICalendarView

#pragma mark - Designated intializer
- (id)initWithFrame:(CGRect)frame date:(NSDate *)date attributes:(NSDictionary *)attributes dataSource:(id<CICalendarViewDataSource>)dataSource andDelegate:(id<CICalendarViewDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = AutoResizingMask;
        
        _date = date;
        _attributes = attributes;
        _dataSource = dataSource;
        _delegate = delegate;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        _collectionView.autoresizingMask = AutoResizingMask;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[CICalendarViewDateCell class] forCellWithReuseIdentifier:ReuseCellIdentifier];
        [_collectionView registerClass:[CICalendarViewHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ReuseHeaderViewIdentifier];
        [self addSubview:_collectionView];        
    }
    return self;
}

#pragma mark - Button action
- (void)moreButtonWasPressed:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(calendarView:moreButtonWasPressedForDate:)]) {
        UICollectionViewCell *cell = (UICollectionViewCell *)sender.superview;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
        [self.delegate calendarView:self moreButtonWasPressedForDate:[self dateAtIndexPath:indexPath]];
    }
}

#pragma mark - Private method
- (void)setDate:(NSDate *)date animated:(BOOL)animated
{
    if (!animated) {
        self.date = date; // Without animation.
        [self reloadCalendar];
    } else {
        NSComparisonResult result = [self.date compareMonthOnly:date];
        UIViewAnimationOptions option = UIViewAnimationOptionTransitionNone;
        if (result == NSOrderedAscending) {
            option = UIViewAnimationOptionTransitionCurlUp;
        } else if (result == NSOrderedDescending) {
            option = UIViewAnimationOptionTransitionCurlDown;
        }
        [UIView transitionWithView:self.collectionView duration:AnimationDuration options:option animations:^{
            self.date = date;
            [self reloadCalendar];
        }completion:nil];
    }
}

- (NSDate *)dateAtIndexPath:(NSIndexPath *)indexPath
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:DateComponentsUnit fromDate:[NSDate startDateOfCalendarForDate:self.date]];
    [dateComponents setDay:[dateComponents day] + indexPath.item];
    return [calendar dateFromComponents:dateComponents];
}

#pragma mark - Switch month
- (NSDate *)nextMonth:(BOOL)animated
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:self.date];
    [dateComponents setMonth:[dateComponents month] + 1];
    [self setDate:[calendar dateFromComponents:dateComponents] animated:animated];
    return self.date;
}

- (NSDate *)prevoiusMonth:(BOOL)animated
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:self.date];
    [dateComponents setMonth:[dateComponents month] - 1];
    [self setDate:[calendar dateFromComponents:dateComponents] animated:animated];
    return self.date;
}

#pragma mark - Back today
- (NSDate *)today:(BOOL)animated
{
    [self setDate:[NSDate date] animated:animated];
    return self.date;
}

#pragma mark - Reload data
- (void)reloadCalendar
{
    [self.collectionView reloadData];
}

#pragma mark - Collection view data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:NSDayCalendarUnit fromDate:[NSDate startDateOfCalendarForDate:self.date] toDate:[NSDate endDateOfCalendarForDate:self.date] options:0];
    return [dateComponents day] + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CICalendarViewDateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ReuseCellIdentifier forIndexPath:indexPath];
    [self configureCell:cell forDate:[self dateAtIndexPath:indexPath]];
    return cell;
}

- (void)configureCell:(CICalendarViewDateCell *)cell forDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:DateComponentsUnit fromDate:date];
    if ([dateComponents weekday] == 1 || [dateComponents weekday] == 7) {
        if (self.attributes[CICVHolidayBackgroundColorKey]) {
            cell.backgroundColor = self.attributes[CICVHolidayBackgroundColorKey];
        } else {
            cell.backgroundColor = [UIColor lightGrayColor];
        }
    } else {
        if (self.attributes[CICVNormalDateBackgroundColorKey]) {
            cell.backgroundColor = self.attributes[CICVNormalDateBackgroundColorKey];
        } else {
            cell.backgroundColor = [UIColor whiteColor];
        }
    }
    // Configure date label
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DateFormatterDay];
    cell.dateLabel.text = [formatter stringFromDate:date];
    if (self.attributes[CICVDateLabelFontKey]) {
        cell.dateLabel.font = self.attributes[CICVDateLabelFontKey];
    } else {
        cell.dateLabel.font = [UIFont systemFontOfSize:17];
    }
    if ([date compareMonthOnly:self.date] != NSOrderedSame) {
        if (self.attributes[CICVNoncurentMonthDateLabelTextColorKey]) {
            cell.dateLabel.textColor = self.attributes[CICVNoncurentMonthDateLabelTextColorKey];
        } else {
            cell.dateLabel.textColor = [UIColor grayColor];
        }
    } else {
        if (self.attributes[CICVCurrentMonthDateLabelTextColorKey]) {
            cell.dateLabel.textColor = self.attributes[CICVCurrentMonthDateLabelTextColorKey];
        } else {
            cell.dateLabel.textColor = [UIColor darkGrayColor];
        }
    }
    // Configure today label
    if (self.attributes[CICVTodayLabelFontKey]) {
        cell.todayLabel.font = self.attributes[CICVTodayLabelFontKey];
    } else {
        cell.todayLabel.font = [UIFont systemFontOfSize:17];
    }
    if ([date compareDateOnly:[NSDate date]] == NSOrderedSame) {
        cell.todayLabel.hidden = NO;
        if (self.attributes[CICVTodayBackgroundColorKey]) {
            cell.backgroundColor = self.attributes[CICVTodayBackgroundColorKey];
        } else {
            cell.backgroundColor = [UIColor cyanColor];
        }
        if (self.attributes[CICVTodayLabelTextColorKey]) {
            cell.todayLabel.textColor = self.attributes[CICVTodayLabelTextColorKey];
        } else {
            cell.todayLabel.textColor = [UIColor darkTextColor];
        }
    } else {
        cell.todayLabel.hidden = YES;
    }
    // Configure frame of more button 
    CGRect frame = cell.moreButton.frame;
    frame.origin.y = cell.bounds.size.height - frame.size.height;
    cell.moreButton.frame = frame;
    // Configure frame of content
    frame = cell.content.frame;
    frame.size.height = cell.bounds.size.height - cell.todayLabel.frame.size.height - cell.moreButton.frame.size.height;
    cell.content.frame = frame;
    // Data source method for cell construction
    if ([self.dataSource respondsToSelector:@selector(calendarView:configureCell:forDate:)]) {
        [self.dataSource calendarView:self configureCell:cell forDate:date];
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CICalendarViewHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:ReuseHeaderViewIdentifier forIndexPath:indexPath];
    [headerView configureLabels:self.attributes];
    if (self.attributes[CICVHeaderViewBackgroundImageKey]) {
        [headerView setBackgroundImage:self.attributes[CICVHeaderViewBackgroundImageKey]];
    }
    return headerView;
}

#pragma mark - Collection view delegate flow layout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.bounds.size.width, HeaderViewHeight);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize itemSizeForSixRows = CGSizeMake(floorf(collectionView.bounds.size.width / NumberOfDaysInAWeek), floorf((collectionView.bounds.size.height - HeaderViewHeight) / 6));
    CGSize itemSizeForFiveRows = CGSizeMake(floorf(collectionView.bounds.size.width / NumberOfDaysInAWeek), floorf((collectionView.bounds.size.height - HeaderViewHeight) / 5));
    return ([collectionView numberOfItemsInSection:0] == NumberOfDaysForSixRows) ? itemSizeForSixRows : itemSizeForFiveRows;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0.0f, 1.0f, 0.0f, 1.0f);
}

@end
