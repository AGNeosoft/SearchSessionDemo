//
//  ViewController.m
//  SearchSessionDemo
//
//  Created by webwerks on 12/26/16.
//  Copyright © 2016 webwerks. All rights reserved.
//

#import "ViewController.h"

#define IS_IPHONE4 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)480) < DBL_EPSILON)
#define IS_IPHONE5 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)568) < DBL_EPSILON)
#define IS_IPHONE6 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)667) < DBL_EPSILON)
#define IS_IPHONE6PLUS (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)736) < DBL_EPSILON)


@interface ViewController ()
{
    int selectedIndex,selected_section;
    BOOL isShowPrice;
}
@end

@implementation ViewController
@synthesize tableView,movieSearch_section,morning, afternoon,evening ,movieSearch;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    selectedIndex = selected_section = -1;
    
   // movieSearch_section = @[@{}];
    
    self.title = @"Search Session Demo";
    [self registerCellsforObjcet:tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDelegate/Datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return movieSearch.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (movieSearch_section.count == 0) {
        return 1;
    }
    else
    return movieSearch_section.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (movieSearch_section.count == 0) {
        return 0;
    }else
    return 80;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (movieSearch_section.count == 0) {
        return [UIView new];
    }
    else
    {
        UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80)];
        sectionView.backgroundColor = [UIColor colorWithRed:0.2902 green:0.2902 blue:0.2902 alpha:1.0];
        
        UIImageView *arrow = [[UIImageView alloc]initWithFrame:CGRectMake(20,30 , 30, 30)];
        arrow.image = [UIImage imageNamed:@"arrow1.png"];
        [arrow.layer setCornerRadius:15];
        [arrow.layer setBorderWidth:2.0];
        [arrow.layer setBorderColor:[UIColor whiteColor].CGColor];
        arrow.contentMode = UIViewContentModeScaleAspectFit;
        
        if (selected_section != -1) {
            arrow.transform = CGAffineTransformMakeRotation(M_PI);
        }
        
        UILabel *lblTitle = [[UILabel alloc]initWithFrame:CGRectMake(70, 20, sectionView.frame.size.width - 60, 30)];
        lblTitle.textColor = [UIColor whiteColor];
        lblTitle.textAlignment = NSTextAlignmentLeft;
        lblTitle.font = [UIFont fontWithName:@"Menlo-Bold" size:15];
        lblTitle.numberOfLines = 0;
        
        lblTitle.text = @"Hoyts Cinema Central";
        
        UILabel *lblSubTitle = [[UILabel alloc]initWithFrame:CGRectMake(70, 40, sectionView.frame.size.width - 60, 30)];
        lblSubTitle.textColor = [UIColor whiteColor];
        lblSubTitle.textAlignment = NSTextAlignmentLeft;
        lblSubTitle.font = [UIFont fontWithName:@"Menlo-Bold" size:10];
        lblSubTitle.numberOfLines = 0;
        lblSubTitle.text = @"100 Street Number, at a place";
        
        
        UIButton *btn = [[UIButton alloc]initWithFrame:sectionView.frame];
        btn.tag = section;
        [btn addTarget:self action:@selector(onClickSection:) forControlEvents:UIControlEventTouchUpInside];
        
        [sectionView addSubview:arrow];
        [sectionView addSubview:lblTitle];
        [sectionView addSubview:lblSubTitle];
        [sectionView addSubview:btn];
        
        
        return sectionView;

    }
}

-(UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SearchSessionTableViewCell *searchSessionCell = [_tableView dequeueReusableCellWithIdentifier:@"SearchSessionTableViewCell" forIndexPath:indexPath];
    
    
    searchSessionCell.btnViewFront.tag = indexPath.row;
    [searchSessionCell.btnViewFront addTarget:self action:@selector(onClickBtnDidSelectCellOnFrontView:) forControlEvents:UIControlEventTouchUpInside];
    
    
    searchSessionCell.btnCross.tag = indexPath.row;
    [searchSessionCell.btnCross addTarget:self action:@selector(onClickBtnCross:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //1. Expandable Table View
    if (selectedIndex == indexPath.row) {
        searchSessionCell.headerView.hidden = NO;
        searchSessionCell.viewMorning.hidden = NO;
        searchSessionCell.viewAfterNoon.hidden = NO;
        searchSessionCell.viewEvening.hidden = NO;
        searchSessionCell.viewFront.hidden = YES;
       
        [self assignDelegatesAndTag:searchSessionCell.collectionViewMorning withIndexPath:(int)indexPath.row*10+1 withHeightConstant:searchSessionCell.constantViewMorningHeight];
        [self assignDelegatesAndTag:searchSessionCell.collectionViewAfternoon withIndexPath:(int)indexPath.row*10+2 withHeightConstant:searchSessionCell.constantViewAfternoonHeight];
        [self assignDelegatesAndTag:searchSessionCell.collectionViewEvening withIndexPath:(int)indexPath.row*10+3 withHeightConstant:searchSessionCell.constantViewEveningHeight];
    }
    else
    {
        searchSessionCell.headerView.hidden = YES;
        searchSessionCell.viewMorning.hidden = YES;
        searchSessionCell.viewAfterNoon.hidden = YES;
        searchSessionCell.viewEvening.hidden = YES;
        searchSessionCell.viewFront.hidden = NO;
        searchSessionCell.collectionViewMorning.delegate = nil;
        searchSessionCell.collectionViewMorning.dataSource = nil;
        searchSessionCell.collectionViewEvening.delegate = nil;
        searchSessionCell.collectionViewEvening.dataSource = nil;
        searchSessionCell.collectionViewAfternoon.delegate = nil;
        searchSessionCell.collectionViewAfternoon.dataSource = nil;
        searchSessionCell.constantViewAfternoonHeight.constant = 104;
        searchSessionCell.constantViewEveningHeight.constant = 104;
        searchSessionCell.constantViewMorningHeight.constant = 104;
        
    }
    
    
    //2. Show Price button
    
    searchSessionCell.btnShowPriceDate.tag = indexPath.row;
    if (isShowPrice  && selectedIndex == indexPath.row) {
        [searchSessionCell.btnShowPriceDate setTitle:@"Show Date" forState:UIControlStateNormal];
    }
    else
        [searchSessionCell.btnShowPriceDate setTitle:@"Show Price" forState:UIControlStateNormal];
    
    
    [searchSessionCell.btnShowPriceDate addTarget:self action:@selector(onClickbtnShowPriceDate:) forControlEvents:UIControlEventTouchUpInside];
    
    return searchSessionCell;
}

-(CGFloat)tableView:(UITableView *)_tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selectedIndex == indexPath.row) {
        
        return [self getHeightForCellFromNumberOfItemsinArray];
    }
    else
        return 140;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"selected index path is  =%lu",indexPath.row);
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - UICollectionViewDelegate/DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (collectionView.tag%10 ==1) {
        return morning.count;
    }
    else if (collectionView.tag%10 ==2) {
        return afternoon.count;
    }
    return evening.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SearchSessionCollectionViewCell *searchSessionCell =[collectionView dequeueReusableCellWithReuseIdentifier:@"SearchSessionCollectionViewCell" forIndexPath:indexPath];
    searchSessionCell.btnDateType.layer.cornerRadius = 4;
    NSDictionary *dict;
    if (collectionView.tag%10 ==1) {
        dict =morning[indexPath.row];
    }
    else if (collectionView.tag%10 ==2)
        dict = afternoon[indexPath.row];
    else
        dict = evening[indexPath.row];
    
    if (IS_IPHONE6) {
        [searchSessionCell.btnDateType.titleLabel setFont:[UIFont fontWithName:@"Menlo-Bold" size:9]];
 
    }
    else if (IS_IPHONE5)
    {
        [searchSessionCell.btnDateType.titleLabel setFont:[UIFont fontWithName:@"Menlo-Bold" size:7]];

    }

    if (dict[@"type"]) {
        if ([dict[@"type"] isEqualToString:@"1"]) {
            searchSessionCell.btnDateType.backgroundColor = [UIColor colorWithRed:119/255.0 green:210/255.0 blue:75/255.0 alpha:1.0];
            [searchSessionCell.btnDateType setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal] ;
            searchSessionCell.btnDateType.layer.borderColor = nil;
            searchSessionCell.btnDateType.layer.borderWidth = 0;
            if (isShowPrice) {
                [searchSessionCell.btnDateType setTitle:[NSString stringWithFormat:@" $7\nHot Price"] forState:UIControlStateNormal];
                
            }
            else
            {
                [searchSessionCell.btnDateType setTitle:[NSString stringWithFormat:@" 9:30 pm \nHot Price"] forState:UIControlStateNormal];
                
            }
        }
        else
        {
            [searchSessionCell.btnDateType.layer setBorderWidth:1.5];
            [searchSessionCell.btnDateType.layer setBorderColor:[UIColor colorWithRed:0.3922 green:0.4235 blue:0.4863 alpha:1.0].CGColor];
            searchSessionCell.btnDateType.backgroundColor = [UIColor whiteColor];
            
            
            [searchSessionCell.btnDateType setTitleColor:[UIColor colorWithRed:0.4745 green:0.5176 blue:0.5725 alpha:1.0] forState:UIControlStateNormal];
            
            if (isShowPrice) {
                [searchSessionCell.btnDateType setTitle:[NSString stringWithFormat:@" $7\nBuy Tickets"] forState:UIControlStateNormal];
                
            }
            else
            {
                [searchSessionCell.btnDateType setTitle:[NSString stringWithFormat:@" 9:30 pm \nBuy Tickets"] forState:UIControlStateNormal];
                
            }
            
        }
    }
    else
    {
        [searchSessionCell.btnDateType.layer setBorderWidth:1.5];
        [searchSessionCell.btnDateType.layer setBorderColor:[UIColor colorWithRed:0.3922 green:0.4235 blue:0.4863 alpha:1.0].CGColor];
        searchSessionCell.btnDateType.backgroundColor = [UIColor whiteColor];
        
        
        [searchSessionCell.btnDateType setTitleColor:[UIColor colorWithRed:0.4745 green:0.5176 blue:0.5725 alpha:1.0] forState:UIControlStateNormal];
        
        if (isShowPrice) {
            [searchSessionCell.btnDateType setTitle:[NSString stringWithFormat:@" $7\nBuy Tickets"] forState:UIControlStateNormal];
            
        }
        else
        {
            [searchSessionCell.btnDateType setTitle:[NSString stringWithFormat:@" 9:30 pm \nBuy Tickets"] forState:UIControlStateNormal];
            
        }

    }
    
    searchSessionCell.btnDateType.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    searchSessionCell.btnDateType.tag = indexPath.row*100+collectionView.tag%10;
    [searchSessionCell.btnDateType addTarget:self action:@selector(onClickCollectionViewCellButtons:) forControlEvents:UIControlEventTouchUpInside];
    
    return searchSessionCell;
}


-(void)onClickCollectionViewCellButtons :(UIButton *)btn
{
    //NSLog(@"cell  = %d",(int)btn.tag%100);
    //NSLog(@"indepath = %d",(int)btn.tag/100);
    
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (IS_IPHONE5) {
        return CGSizeMake(56, 30);
    }
    else if (IS_IPHONE6)
    {
        return CGSizeMake(70, 40);
    }
    else if (IS_IPHONE6PLUS)
    {
        return CGSizeMake(85, 45);
        
    }
    else
        return CGSizeMake(60, 30);
}

-(void)assignDelegatesAndTag:(UICollectionView *)collectionView withIndexPath:(int)indexPath withHeightConstant:(NSLayoutConstraint *)height
{
    @try {
        [collectionView performBatchUpdates:^{
            collectionView.delegate = self;
            collectionView.dataSource = self;
            collectionView.tag = indexPath;
            
        }completion:^(BOOL finished) {
            height.constant = collectionView.contentSize.height;
        }];
    }
    @catch (NSException *exception) {
        tableView.hidden = YES;
        //NSLog(@"exception = %@",exception);
    }
    
    
}



#pragma mark - Register Cells
-(void)registerCellsforObjcet:(id)Object
{
    if ([Object isKindOfClass:[UITableView class]]) {
        [Object registerNib:[UINib nibWithNibName:@"SearchSessionTableViewCell" bundle:nil] forCellReuseIdentifier:@"SearchSessionTableViewCell"];
        
    }
    else if ([Object isKindOfClass:[UICollectionView class]])
    {
        [Object registerNib:[UINib nibWithNibName:@"SearchSessionCollectionViewCell" bundle:nil] forCellReuseIdentifier:@"SearchSessionCollectionViewCell"];
    }
    
}

-(void)onClickBtnDidSelectCellOnFrontView:(UIButton *)btn
{
    selectedIndex = (int)btn.tag;
    
    if (btn.tag != movieSearch.count-1 && btn.tag != 0) {
       [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:btn.tag - 1 inSection:0],[NSIndexPath indexPathForRow:btn.tag inSection:0],[NSIndexPath indexPathForRow:btn.tag+1 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    }
    else if (btn.tag == 0)
    {
        [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:btn.tag inSection:0],[NSIndexPath indexPathForRow:btn.tag + 1 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    }
    else if (btn.tag == movieSearch.count-1)
    {
        [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:btn.tag inSection:0],[NSIndexPath indexPathForRow:btn.tag - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];

    }
   
    
}

-(void)onClickBtnCross:(UIButton *)btn
{
    selectedIndex = -1;
    isShowPrice = NO;
    
    // [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:btn.tag inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
    [tableView reloadData];
}


-(void)onClickbtnShowPriceDate:(UIButton *)btn
{
    
    SearchSessionTableViewCell *searchSessionCell = (SearchSessionTableViewCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:btn.tag inSection:0]];
    
    //NSLog(@"selected table view cell = %@",[tableView indexPathsForSelectedRows]);
    if (!isShowPrice) {
        isShowPrice = YES;
        [searchSessionCell.btnShowPriceDate setTitle:@"Show Date" forState:UIControlStateNormal];
        
    }
    else
    {
        isShowPrice = NO;
        [searchSessionCell.btnShowPriceDate setTitle:@"Show Price" forState:UIControlStateNormal];
    }
    
    [searchSessionCell.collectionViewMorning reloadData];
    [searchSessionCell.collectionViewAfternoon reloadData];
    [searchSessionCell.collectionViewEvening reloadData];
    
}


-(NSInteger)getHeightForCellFromNumberOfItemsinArray
{
    float numberOfMorningRows = 0.0, numberOfEveningRows = 0.0 , numberOfAfternoonRows = 0.0;
    for (int i =0 ; i< 3; i++) {
        if (i==0) {
            if (morning.count>0) {
                numberOfMorningRows = (float)morning.count/3;
                if((int)numberOfMorningRows < numberOfMorningRows) {
                    numberOfMorningRows = (int)numberOfMorningRows + 1;
                }
            }
        } else if (i==1)
        {
            if (afternoon.count>0) {
                numberOfAfternoonRows = (float)afternoon.count/3;
                if((int)numberOfAfternoonRows < numberOfAfternoonRows) {
                    numberOfAfternoonRows = (int)numberOfAfternoonRows + 1;
                }
            }
        }
        else
        {
            if (evening.count>0) {
                numberOfEveningRows = (float)evening.count/3;
                if((int)numberOfEveningRows < numberOfEveningRows) {
                    numberOfEveningRows = (int)(numberOfEveningRows + 1);
                }
            }
        }
    }
    
    int itemHeight ;
    if (IS_IPHONE5) {
        itemHeight  = 30;
    }
    else if (IS_IPHONE6)
    {
        itemHeight = 40;
    }
    else if (IS_IPHONE6PLUS)
    {
        itemHeight = 45;
    }
    else
        itemHeight = 30;
    
    //NSLog(@"height = %f", 140+ (numberOfMorningRows + 10 * (numberOfMorningRows +1) + itemHeight*numberOfMorningRows + numberOfAfternoonRows + 10 * (numberOfAfternoonRows +1)+itemHeight*numberOfAfternoonRows + numberOfEveningRows + 10 * (numberOfEveningRows +1) + itemHeight*numberOfEveningRows));
    
    return 140+ (numberOfMorningRows + 10 * (numberOfMorningRows +1) + itemHeight*numberOfMorningRows + numberOfAfternoonRows + 10 * (numberOfAfternoonRows +1)+itemHeight*numberOfAfternoonRows + numberOfEveningRows + 10 * (numberOfEveningRows +1) + itemHeight*numberOfEveningRows);
}


-(void)onClickSection:(UIButton *)btn
{
    if (selected_section != btn.tag) {
       selected_section = (int)btn.tag;
        
        morning = @[@{@"type" : @"1"},@{@"type" : @"1"}];
        afternoon = @[@{},@{@"type" : @"1"},@{@"type" :
                                                  @"1"},@{},@{}];
        evening = @[@{},@{},@{},@{},@{},@{@"type" : @"1"}];
        movieSearch = @[@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{}];
        
    }
    else{
        selected_section = -1;
        morning = @[];
        afternoon = @[];
        evening = @[];
        movieSearch = @[];
    }
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:btn.tag] withRowAnimation:UITableViewRowAnimationBottom];
}
@end
