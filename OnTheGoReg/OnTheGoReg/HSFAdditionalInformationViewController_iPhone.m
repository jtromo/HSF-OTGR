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
#import "HSFDatabasController.h"
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
    
	[_additionalInfoView populateLabels];
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
    if (![_additionalInfoView populateWithCheckboxes]) {
        return;
    }
    
    HSFContact *contact = [[HSFNetManager sharedInstance] currentContact];
    [[HSFDatabasController sharedController] insertContact:contact];
    
    LogInfo(@"Current: %@", contact);
    
    [[HSFNetManager sharedInstance] syncWithViewController:self];
}

@end
