//
//  CICalendarView.h
//  CollectionViewCalendar
//
//  Created by shenghua wu on 13/7/10.
//  Copyright (c) 2013年 shenghua wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CICalendarViewDateCell.h"
#import "CICalendarViewHeaderView.h"

@class CICalendarView;

@protocol CICalendarViewDataSource <NSObject>
@required
/* ---
 This method is called for cell construction.
 
 @param
 calendarView   This calendar view
 @param
 cell           The cell needs to construct.
 @param
 date           The date of this cell
 --- */
- (void)calendarView:(CICalendarView *)calendarView configureCell:(CICalendarViewDateCell *)cell forDate:(NSDate *)date;
@end

@protocol CICalendarViewDelegate <NSObject>
@required
/* ---
 This method is called when the cell's more button was pressed.
 
 @param
 calendarView   This calendar view
 @param
 date           The date of cell
 --- */
- (void)calendarView:(CICalendarView *)calendarView moreButtonWasPressedForDate:(NSDate *)date;
@end

@interface CICalendarView : UIView
/* ---
 This is the designated initializer.
 
 @param
 frame      The frame of calendar view
 @param
 date       The calendar will be the entire month corresponding this date.
 @param
 attributes The custom attributes
 @param
 dataSource The data source of calendar view
 @param
 delegate   The delegate of calendar view
 --- */
- (id)initWithFrame:(CGRect)frame date:(NSDate *)date attributes:(NSDictionary *)attributes dataSource:(id <CICalendarViewDataSource>)dataSource andDelegate:(id <CICalendarViewDelegate>)delegate;

/* --- Switch month --- */
- (NSDate *)nextMonth:(BOOL)animated;
- (NSDate *)prevoiusMonth:(BOOL)animated;

/* --- Back today --- */
- (NSDate *)today:(BOOL)animated;

/* --- Reload data --- */
- (void)reloadCalendar;
@end
