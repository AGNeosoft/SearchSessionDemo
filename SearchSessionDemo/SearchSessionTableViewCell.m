//
//  SearchSessionTableViewCell.m
//  SearchSessionDemo
//
//  Created by webwerks on 12/26/16.
//  Copyright © 2016 webwerks. All rights reserved.
//

#import "SearchSessionTableViewCell.h"
#import "SearchSessionCollectionViewCell.h"
@implementation SearchSessionTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [self.collectionViewMorning registerNib:[UINib nibWithNibName:@"SearchSessionCollectionViewCell" bundle:nil]forCellWithReuseIdentifier:@"SearchSessionCollectionViewCell"];
    [self.collectionViewAfternoon registerNib:[UINib nibWithNibName:@"SearchSessionCollectionViewCell" bundle:nil]forCellWithReuseIdentifier:@"SearchSessionCollectionViewCell"];
    [self.collectionViewEvening registerNib:[UINib nibWithNibName:@"SearchSessionCollectionViewCell" bundle:nil]forCellWithReuseIdentifier:@"SearchSessionCollectionViewCell"];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
