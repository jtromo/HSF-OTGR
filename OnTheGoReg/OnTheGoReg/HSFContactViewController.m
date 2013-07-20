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
#import "Tesseract.h"

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

@property (nonatomic, strong) Tesseract *tesseract;


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
    
    
    
    
    
    
    [self createAndCopyTessdata];
    
    
    
    _tesseract = [[Tesseract alloc] initWithDataPath:@"tessdata" language:@"eng"];
    
    
//    [_tesseract setImage:[UIImage imageNamed:@"Sample_Business_Card.gif"]];
//    [_tesseract recognize];
//    
//    NSLog(@"%@", [_tesseract recognizedText]);
}


- (void)createAndCopyTessdata
{
    NSString *documentDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    // NSLog(@"%@", documentDirPath);
    NSString *tessdataDirPath = [documentDirPath stringByAppendingPathComponent:@"tessdata"];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if([manager fileExistsAtPath:tessdataDirPath] == NO)
        if([manager fileExistsAtPath:documentDirPath])
            [manager createDirectoryAtPath:tessdataDirPath withIntermediateDirectories:NO attributes:nil error:nil];
    
//    NSArray *langArray = [[NSArray alloc] initWithObjects:@"pol", @"eng", nil];
//    for(NSString *lang in langArray)
//    {
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"eng" ofType:@"traineddata"];
        // NSLog(@"source: %@", sourcePath);
        NSString *destPath = [tessdataDirPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.traineddata", @"eng"]];
        // NSLog(@"dest: %@", destPath);
        
        if([manager fileExistsAtPath:destPath] == NO)
            [manager copyItemAtPath:sourcePath toPath:destPath error:nil];
//    }
}

//- (void)initTesseract
//{
//    _tesseract = [[Tesseract alloc] initWithDataPath:@"" language:@"pol"];
//}


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


// Also verifies
- (BOOL)populateContact
{
    BOOL isVerified = YES;
    
    HSFContact *currentContact = [[HSFNetManager sharedInstance] currentContact];
    currentContact.firstName = _firstNameField.text;
    if (![currentContact.firstName length]) {
        _firstNameField.backgroundColor = [UIColor redColor];
        isVerified = NO;
    } else {
        _firstNameField.backgroundColor = [UIColor whiteColor];
    }
    currentContact.lastName = _lastNameField.text;
    if (![currentContact.lastName length]) {
        _lastNameField.backgroundColor = [UIColor redColor];
        isVerified = NO;
    } else {
        _lastNameField.backgroundColor = [UIColor whiteColor];
    }
    currentContact.email = _emailField.text;
    if (![currentContact.email length]) {
        _emailField.backgroundColor = [UIColor redColor];
        isVerified = NO;
    } else {
        
        
        _emailField.backgroundColor = [UIColor whiteColor];
    }
    currentContact.contactType = _contactTypeField.text;
    if (![currentContact.contactType length]) {
        _contactTypeField.backgroundColor = [UIColor redColor];
        isVerified = NO;
    } else {
        _contactTypeField.backgroundColor = [UIColor whiteColor];
    }
    currentContact.phoneNumber = _phoneField.text;
    if (![currentContact.phoneNumber length]) {
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
        
        [[HSFNetManager sharedInstance] syncWithViewController:self];
    } else {
        // Error message
    }
}

//
//
//
//
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // Show process button
    if (selectedImage) {
        [_tesseract setImage:selectedImage];
        [_tesseract recognize];
        
        NSString *businessCardText = [_tesseract recognizedText];
        [self parseCard:businessCardText];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
//
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [_tesseract setImage:[UIImage imageNamed:@"Sample_Business_Card2.png"]];
    [_tesseract recognize];
    
    NSString *businessCardText = [_tesseract recognizedText];
    [self parseCard:businessCardText];
}
//
//- (void)processWasPressed:(id)sender
//{
//    ResultsViewController *resultsVC = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"Results"];
//    
//    // Create loading view.
//    resultsVC.loadingView = [[UIView alloc] initWithFrame:self.view.bounds];
//    resultsVC.loadingView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
//    [resultsVC.view addSubview:resultsVC.loadingView];
//    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] init];
//    [resultsVC.loadingView addSubview:activityView];
//    activityView.center = resultsVC.loadingView.center;
//    [activityView startAnimating];
//    
//    resultsVC.selectedImage = self.selectedImage;
//    [resultsVC.selectedImageView setImage:self.selectedImage];
//    
//    // Push
//    [self.navigationController pushViewController:resultsVC animated:YES];
//    
//}

- (void)parseCard: (NSString *)myCardString
{
    NSArray *parsed = [myCardString componentsSeparatedByString:@"\n"];
    // Line by line
    int wordCount = 0;
    for (NSString *line in parsed) {
        NSArray *subParsed = [line componentsSeparatedByString:@" "];
        // Word by word
        for (NSString *word in subParsed) {
            wordCount++;
            if (wordCount == 2) {
                _firstNameField.text = word;
            }
            else if (wordCount == 3) {
                _lastNameField.text = word;
            }
            else if (wordCount == 5) {
                _phoneField.text = word;
            }
            else if (wordCount == 7) {
                _emailField.text = word;
            }
        }
    }
    
    
    NSLog(@"%@", [_tesseract recognizedText]);
}

- (IBAction)cameraButtonPressed:(id)sender
{
    if (IS_PHONE) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        }
        else {
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
        
        [self presentViewController:imagePickerController
                           animated:YES
                         completion:nil];
    }
    else {
        [_tesseract setImage:[UIImage imageNamed:@"Sample_Business_Card2.png"]];
        [_tesseract recognize];
        
        NSString *businessCardText = [_tesseract recognizedText];
        [self parseCard:businessCardText];
    }
}



@end
