//
//  SearchSessionTableViewCell.h
//  SearchSessionDemo
//
//  Created by webwerks on 12/26/16.
//  Copyright © 2016 webwerks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchSessionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnCross;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblDay;
@property (weak, nonatomic) IBOutlet UIView *viewShowPriceDate;
@property (weak, nonatomic) IBOutlet UIButton *btnShowPriceDate;

@property (weak, nonatomic) IBOutlet UIView *viewNextDate;
@property (weak, nonatomic) IBOutlet UIButton *btnNextDay;

@property (weak, nonatomic) IBOutlet UIView *viewPreviousDay;
@property (weak, nonatomic) IBOutlet UIButton *btnPreviousDay;

@property (weak, nonatomic) IBOutlet UIView *viewMorning;
@property (weak, nonatomic) IBOutlet UILabel *lblMorning;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewMorning;

@property (weak, nonatomic) IBOutlet UIView *viewAfterNoon;
@property (weak, nonatomic) IBOutlet UILabel *lblAfternoon;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewAfternoon;

@property (weak, nonatomic) IBOutlet UIView *viewEvening;
@property (weak, nonatomic) IBOutlet UILabel *lblEvening;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewEvening;


//Front View
@property (weak, nonatomic) IBOutlet UIView *viewFront;
@property (weak, nonatomic) IBOutlet UILabel *lblTicketFrom;
@property (weak, nonatomic) IBOutlet UILabel *lblTicketPrice;

@property (weak, nonatomic) IBOutlet UILabel *lblSwipeLeftForSessionTimes;
@property (weak, nonatomic) IBOutlet UILabel *lblMovieCinemaName;
@property (weak, nonatomic) IBOutlet UILabel *lblDurationRating;
@property (weak, nonatomic) IBOutlet UIButton *btnViewFront;


    //Layout Constraint
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constantViewMorningHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constantViewAfternoonHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constantViewEveningHeight;


@end
