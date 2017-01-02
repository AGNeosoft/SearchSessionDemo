//
//  FirstViewController.m
//  SearchSessionDemo
//
//  Created by webwerks on 12/30/16.
//  Copyright © 2016 webwerks. All rights reserved.
//

#import "FirstViewController.h"
#import "ViewController.h"
@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onClickBtnShowSection:(UIButton *)sender {
    ViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    obj.movieSearch_section = @[@{}];
    [self.navigationController pushViewController:obj animated:YES];

}
- (IBAction)onClickBtnDontShowSection:(UIButton *)sender {
    ViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    obj.morning = @[@{@"type" : @"1"},@{@"type" : @"1"}];
    obj.afternoon = @[@{},@{@"type" : @"1"},@{@"type" : @"1"},@{},@{}];
    obj.evening = @[@{},@{},@{},@{},@{},@{@"type" : @"1"}];
    
    obj.movieSearch = @[@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{},@{}];
    [self.navigationController pushViewController:obj animated:YES];
    
}
@end
