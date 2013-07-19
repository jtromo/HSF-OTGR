//
//  HSFAdditionalInformationViewController_iPhone.m
//  OnTheGoReg
//
//  Created by James T Romo on 7/19/13.
//  Copyright (c) 2013 Hispanic Scholarship Fund. All rights reserved.
//

#import "HSFAdditionalInformationViewController_iPhone.h"
#import "HSFContact.h"
#import "HSFNetManager.h"
#import "HSFCheckBox.h"
#import "HSFAdditionalInfoComponentsView.h"

@interface HSFAdditionalInformationViewController_iPhone ()

@property (nonatomic, strong) IBOutlet HSFAdditionalInfoComponentsView *additionalInfoView;

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
    [_additionalInfoView.infoLabel1 setText:kLabel1];
    [_additionalInfoView.infoLabel2 setText:kLabel2];
    [_additionalInfoView.infoLabel3 setText:kLabel3];
    [_additionalInfoView.infoLabel4 setText:kLabel4];
    [_additionalInfoView.infoLabel5 setText:kLabel5];
    [_additionalInfoView.infoLabel6 setText:kLabel6];
    [_additionalInfoView.infoLabel7 setText:kLabel7];
    [_additionalInfoView.infoLabel8 setText:kLabel8];
    [_additionalInfoView.infoLabel9 setText:kLabel9];
    [_additionalInfoView.infoLabel10 setText:kLabel10];
    [_additionalInfoView.infoLabel11 setText:kLabel11];
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
    [_additionalInfoView populateWithCheckboxes];
    
    HSFContact *contact = [[HSFNetManager sharedInstance] currentContact];
    LogInfo(@"Current: %@", contact);
}

@end
