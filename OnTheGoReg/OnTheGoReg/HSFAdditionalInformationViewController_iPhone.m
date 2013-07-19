//
//  HSFAdditionalInformationViewController_iPhone.m
//  OnTheGoReg
//
//  Created by James T Romo on 7/19/13.
//  Copyright (c) 2013 Hispanic Scholarship Fund. All rights reserved.
//

#import "HSFAdditionalInformationViewController_iPhone.h"

@interface HSFAdditionalInformationViewController_iPhone ()

// Info Labels
@property (strong, nonatomic) IBOutlet UILabel *infoLabel1;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel2;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel3;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel4;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel5;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel6;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel7;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel8;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel9;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel10;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel11;

@end

@implementation HSFAdditionalInformationViewController_iPhone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [_infoLabel1 setText:kLabel1];
    [_infoLabel2 setText:kLabel2];
    [_infoLabel3 setText:kLabel3];
    [_infoLabel4 setText:kLabel4];
    [_infoLabel5 setText:kLabel5];
    [_infoLabel6 setText:kLabel6];
    [_infoLabel7 setText:kLabel7];
    [_infoLabel8 setText:kLabel8];
    [_infoLabel9 setText:kLabel9];
    [_infoLabel10 setText:kLabel10];
    [_infoLabel11 setText:kLabel11];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submitBtnPressed:(id)sender
{
}

@end
