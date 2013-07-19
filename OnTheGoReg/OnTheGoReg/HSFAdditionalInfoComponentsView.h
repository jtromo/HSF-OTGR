//
//  HSFAdditionalInfoComponents.h
//  OnTheGoReg
//
//  Created by James T Romo on 7/19/13.
//  Copyright (c) 2013 Hispanic Scholarship Fund. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HSFCheckBox;

@interface HSFAdditionalInfoComponentsView : UIView

- (BOOL)populateWithCheckboxes;

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

@property (strong, nonatomic) NSArray *infoLabels;

// Info Checkboxes
@property (strong, nonatomic) IBOutlet HSFCheckBox *checkbox1;
@property (strong, nonatomic) IBOutlet HSFCheckBox *checkbox2;
@property (strong, nonatomic) IBOutlet HSFCheckBox *checkbox3;
@property (strong, nonatomic) IBOutlet HSFCheckBox *checkbox4;
@property (strong, nonatomic) IBOutlet HSFCheckBox *checkbox5;
@property (strong, nonatomic) IBOutlet HSFCheckBox *checkbox6;
@property (strong, nonatomic) IBOutlet HSFCheckBox *checkbox7;
@property (strong, nonatomic) IBOutlet HSFCheckBox *checkbox8;
@property (strong, nonatomic) IBOutlet HSFCheckBox *checkbox9;
@property (strong, nonatomic) IBOutlet HSFCheckBox *checkbox10;
@property (strong, nonatomic) IBOutlet HSFCheckBox *checkbox11;

@property (strong, nonatomic) NSArray *checkboxes;

@property (strong, nonatomic) IBOutlet UILabel *errorLbl;

@end
