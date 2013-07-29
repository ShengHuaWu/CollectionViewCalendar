//
//  CICalendarViewDateCell.h
//  CollectionViewCalendar
//
//  Created by shenghua wu on 13/7/10.
//  Copyright (c) 2013年 shenghua wu. All rights reserved.
//

#import <UIKit/UIKit.h>

/* --- Custom attributes keys --- */
extern NSString *const CICVNormalDateBackgroundColorKey;
extern NSString *const CICVTodayBackgroundColorKey;
extern NSString *const CICVHolidayBackgroundColorKey;
extern NSString *const CICVDateLabelFontKey;
extern NSString *const CICVTodayLabelFontKey;
extern NSString *const CICVCurrentMonthDateLabelTextColorKey;
extern NSString *const CICVNoncurentMonthDateLabelTextColorKey;
extern NSString *const CICVTodayLabelTextColorKey;

@interface CICalendarViewDateCell : UICollectionViewCell
@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) UILabel *todayLabel;
@property (strong, nonatomic) UIButton *moreButton;
/* --- This is the custom content view --- */
@property (strong, nonatomic) UIView *content;
@end
