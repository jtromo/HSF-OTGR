//
//  HSFViewController.m
//  OnTheGoReg
//
//  Created by James T Romo on 7/19/13.
//  Copyright (c) 2013 Hispanic Scholarship Fund. All rights reserved.
//

#import "HSFContactViewController.h"
#import "UIViewController+Extensions.h"
#import "HSFNetManager.h"
#import "HSFContact.h"
#import "HSFAdditionalInfoComponentsView.h"
#import "HSFDatabasController.h"

@interface HSFContactViewController ()

@property (strong, nonatomic) NSArray *contactTypes;
@property (strong, nonatomic) UITextField *activeField;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

// Shared Fields
@property (strong, nonatomic) IBOutlet UITextField *firstNameField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameField;
@property (strong, nonatomic) IBOutlet UITextField *contactTypeField;
@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UITextField *phoneField;

// iPad Only
@property (nonatomic, strong) IBOutlet HSFAdditionalInfoComponentsView *additionalInfoView;

@end

@implementation HSFContactViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _contactTypes = kContactTypes;
    
    UIPickerView *contactTypePicker = [[UIPickerView alloc] init];
    contactTypePicker.delegate = self;
    contactTypePicker.dataSource = self;
    contactTypePicker.showsSelectionIndicator = YES;
    
    // Set keyboard to date picker
    [_contactTypeField setInputView:contactTypePicker];
    NSString * defaultContactType = [_contactTypes objectAtIndex:0];
    _contactTypeField.text = defaultContactType;
    
    
    if (!IS_PHONE) {
        [_additionalInfoView populateLabels];
    }
    
    
//    [crimeTypePicker selectRow:crimeTypeId inComponent:0 animated:YES];
    //Check if camera is available. Hide button if not
    if (!([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])) {
//        [self.cameraButton setEnabled:NO];
//        self.cameraButton.alpha = 0.4f;
        
    } else {
//        [self.cameraButton setEnabled:YES];
//        self.cameraButton.alpha = 1.0f;
    }
//    
//    if (self.viewMode == ViewMode_Edit) {
//        // Remove the lower rows and reveal edit buttons
//        [self prepareViewForEditing];
//        
//        // Populate fields
//        [self populateFieldsForEditing];
//        // Set default crime picker text (hover when view opens up)
//        NSInteger *crimeTypeId = self.editCard.crimeTypeId;
//        if (crimeTypeId >= 0) {
//            
//        }
//    }
    
    [self registerForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Camera Button
#pragma mark - Picture Methods

// Buttons should be hidden if unavailable
//
////Camera Button
//- (IBAction)useCamera:(id)sender
//{
//    if ([UIImagePickerController isSourceTypeAvailable:
//         UIImagePickerControllerSourceTypeCamera])
//    {
//        UIImagePickerController *imagePicker =
//        [[UIImagePickerController alloc] init];
//        imagePicker.delegate = self;
//        imagePicker.sourceType =
//        UIImagePickerControllerSourceTypeCamera;
//        imagePicker.mediaTypes = [NSArray arrayWithObjects:
//                                  (NSString *) kUTTypeImage,
//                                  nil];
//        imagePicker.allowsEditing = NO;
//        self.newMedia = YES;
//        [self presentViewController:imagePicker animated:YES completion:nil];
//    }
//}
//
//
////Camera Roll
//- (IBAction)useCameraRoll:(id)sender
//{
//    if ([UIImagePickerController isSourceTypeAvailable:
//         UIImagePickerControllerSourceTypeSavedPhotosAlbum])
//    {
//        UIImagePickerController *imagePicker =
//        [[UIImagePickerController alloc] init];
//        imagePicker.delegate = self;
//        imagePicker.sourceType =
//        UIImagePickerControllerSourceTypePhotoLibrary;
//        
//        if ([UIImagePickerController isSourceTypeAvailable:
//             UIImagePickerControllerSourceTypeCamera])
//        {
//            //Use any applicable media type
//            imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
//        } else {
//            //Use only images
//            imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage,nil];
//        }
//        imagePicker.allowsEditing = NO;
//        self.newMedia = NO;
//        [self presentViewController:imagePicker animated:YES completion:nil];
//    }
//}
//
////Callback after selecting image from camera roll or taking picture
//- (void)imagePickerController:(UIImagePickerController *)picker
//didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    NSString *mediaType = [info
//                           objectForKey:UIImagePickerControllerMediaType];
//    [self dismissViewControllerAnimated:YES completion:nil];
//    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
//        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//        
//        BBDPicture * newPicture = [[BBDPicture alloc] initWithPictureId:-1
//                                                              withImage:image
//                                                       withCreationTime:nil];
//        self.picture = newPicture;
//        
//        self.previewImageView.image = image;
//        
//        // Choose whether to save image to Photos album or not
//        
//        
//        
//        // save to database
//        
//        //use camera image here
//        
//        //(try to sync)
//        
//        //If new, save to photo album
//        //        if (newMedia)
//        //            UIImageWriteToSavedPhotosAlbum(image,
//        //                                           self,
//        //                                           @selector(image:finishedSavingWithError:contextInfo:),
//        //                                           nil);
//    }
//}
//
//- (void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
//{
//    if (error) {
//        UIAlertView *alert = [[UIAlertView alloc]
//                              initWithTitle: @"Save failed"
//                              message: @"Failed to save image"\
//                              delegate: nil
//                              cancelButtonTitle:@"OK"
//                              otherButtonTitles:nil];
//        [alert show];
//    }
//}
//
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
//{
//    [self dismissViewControllerAnimated:YES completion:nil];
//    
//    //    [self dismissModalViewControllerAnimated:YES];
//}
//


#pragma mark - UITextfieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeField = nil;
}

// When the return button is clicked
- (BOOL) textFieldShouldReturn: (UITextField *)textField
{
    [textField resignFirstResponder];
    
    if (textField.tag == 1) {
//        LogTrace(@"Username return button pressed. Moving to password field");
//        [self.passwordTextField becomeFirstResponder];
    }
    else if (textField.tag == 2){
//        LogTrace(@"Password return button pressed. Logging in...");
//        [self login];
    }
    else{
        LogError(@"Invalid text field");
    }
    
    return YES;
}

// Whether the text field should clear to empty
- (BOOL) textFieldShouldClear: (UITextField *)textField
{
    return NO;
}



#pragma mark - Keyboard Scrolling

// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    if (!self.activeField) {
        LogError(@"ActiveField is nil");
        return;
    }
    
    UIInterfaceOrientation interfaceOrientation = self.interfaceOrientation;
    // Only scroll if in portrait mode
    if (UIDeviceOrientationIsPortrait(interfaceOrientation)) {
        // If active text field is hidden by keyboard, scroll it so it's visible
        CGRect aRect = self.view.frame;
        aRect.size.height -= kbSize.height;
        CGPoint origin = self.activeField.frame.origin;
        origin.y -= self.scrollView.contentOffset.y;
        origin.y += self.activeField.frame.size.height;
        if (!CGRectContainsPoint(aRect, origin) ) {
            CGPoint scrollPoint = CGPointMake(0.0, (self.activeField.frame.origin.y + self.activeField.frame.size.height
                                                    )-(aRect.size.height));
            [self.scrollView setContentOffset:scrollPoint animated:YES];
        }
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}








#pragma mark - UIPickerView delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component
{
    NSString * contactType = [_contactTypes objectAtIndex:row];
    
    self.contactTypeField.text = contactType;
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_contactTypes count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString * contactType = @"Unknown";
    if (row < [_contactTypes count]) {
        
        contactType = [_contactTypes objectAtIndex:row];
    }
    
    return contactType;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    
    return sectionWidth;
}

//- (BOOL)verifyAtLeastOneChecked
//{
//    
//}

// Also verifies
- (BOOL)populateContact
{
    BOOL isVerified = YES;
    
    HSFContact *currentContact = [[HSFNetManager sharedInstance] currentContact];
    currentContact.firstName = _firstNameField.text;
    if (!currentContact.firstName) {
        _firstNameField.backgroundColor = [UIColor redColor];
        isVerified = NO;
    } else {
        _firstNameField.backgroundColor = [UIColor whiteColor];
    }
    currentContact.lastName = _lastNameField.text;
    if (!currentContact.lastName) {
        _lastNameField.backgroundColor = [UIColor redColor];
        isVerified = NO;
    } else {
        _lastNameField.backgroundColor = [UIColor whiteColor];
    }
    currentContact.email = _emailField.text;
    if (!currentContact.email) {
        _emailField.backgroundColor = [UIColor redColor];
        isVerified = NO;
    } else {
        _emailField.backgroundColor = [UIColor whiteColor];
    }
    currentContact.contactType = _contactTypeField.text;
    if (!currentContact.contactType) {
        _contactTypeField.backgroundColor = [UIColor redColor];
        isVerified = NO;
    } else {
        _contactTypeField.backgroundColor = [UIColor whiteColor];
    }
    currentContact.phoneNumber = _phoneField.text;
    if (!currentContact.phoneNumber) {
        _phoneField.backgroundColor = [UIColor redColor];
        isVerified = NO;
    } else {
        _phoneField.backgroundColor = [UIColor whiteColor];
    }
    
    // Only ipad
    if (!IS_PHONE) {
        isVerified = [self.additionalInfoView populateWithCheckboxes];
    }
    
    return isVerified;
}

- (IBAction)nextBtnPressed:(id)sender
{
    if ([self populateContact]) {
        [self performSegueWithIdentifier:@"Next" sender:self];
    } else {
        // Error message
    }
}

- (IBAction)submitBtnPressed:(id)sender
{
    if ([self populateContact]) {
//        [self performSegueWithIdentifier:@"Next" sender:self];
        HSFContact *contact = [[HSFNetManager sharedInstance] currentContact];
        [[HSFDatabasController sharedController] insertContact:contact];
        
        [[HSFDatabasController sharedController] pendingUploads];
        [[HSFDatabasController sharedController] pendingUploadsToCVS];
        
    } else {
        // Error message
    }
}







@end
