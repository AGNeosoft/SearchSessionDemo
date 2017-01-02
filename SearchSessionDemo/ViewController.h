//
//  ViewController.h
//  SearchSessionDemo
//
//  Created by webwerks on 12/26/16.
//  Copyright © 2016 webwerks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchSessionTableViewCell.h"
#import "SearchSessionCollectionViewCell.h"
#import "SearchSessionCollectionViewCell.h"
@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UILabel *lblSearchName;
@property (weak, nonatomic) IBOutlet UILabel *lblSearchCriteria;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(assign,nonatomic)BOOL isShowSection;
@property(strong,nonatomic) NSArray *movieSearch_section,*morning, * afternoon, *evening , *movieSearch;
@end

