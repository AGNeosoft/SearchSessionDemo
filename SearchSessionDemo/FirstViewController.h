//
//  FirstViewController.h
//  SearchSessionDemo
//
//  Created by webwerks on 12/30/16.
//  Copyright © 2016 webwerks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController

@property(weak,nonatomic) IBOutlet UIButton *btnShowSection;
@property(weak,nonatomic) IBOutlet UIButton *btnDontShowSection;
- (IBAction)onClickBtnShowSection:(UIButton *)sender;

- (IBAction)onClickBtnDontShowSection:(UIButton *)sender;

@end
