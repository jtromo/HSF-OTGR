//
//  HSFCheckBox.h
//  OnTheGoReg
//
//  Created by James T Romo on 7/19/13.
//  Copyright (c) 2013 Hispanic Scholarship Fund. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSFCheckBox : UIButton

- (void)toggle;

@property (nonatomic, assign, readonly) BOOL isChecked;

@end
