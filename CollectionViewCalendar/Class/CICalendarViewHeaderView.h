//
//  CICalendarViewHeaderView.h
//  CollectionViewCalendar
//
//  Created by shenghua wu on 13/7/17.
//  Copyright (c) 2013年 shenghua wu. All rights reserved.
//

#import <UIKit/UIKit.h>

/* --- Custom atttbutes keys --- */
extern NSString *const CICVHeaderViewLabelTextColorKey;
extern NSString *const CICVHeaderViewLabelFontKey;
extern NSString *const CICVHeaderViewBackgroundImageKey;

@interface CICalendarViewHeaderView : UICollectionReusableView
/* --- Background image --- */
- (void)setBackgroundImage:(UIImage *)image;
/* --- Configuration --- */
- (void)configureLabels:(NSDictionary *)attributes;
@end
