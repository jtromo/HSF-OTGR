//
//  HSFNetManager.m
//  OnTheGoReg
//
//  Created by James T Romo on 7/19/13.
//  Copyright (c) 2013 Hispanic Scholarship Fund. All rights reserved.
//

#import "HSFNetManager.h"
#import "HSFContact.h"
#import "HSFDatabasController.h"

static HSFNetManager * _sharedInstance;

@interface HSFNetManager ()
@property (nonatomic, strong) UIViewController *currentVC;
@end

@implementation HSFNetManager

+ (HSFNetManager *) sharedInstance
{
    @synchronized(self) {
        if (!_sharedInstance) {
            _sharedInstance = [[self alloc] init];
        }
        
        return _sharedInstance;
    }
}

- (id) init
{
    if (!(self = [super init])) {
        return nil;
    }
    
    _currentContact = [[HSFContact alloc] init];
    
    return self;
}

- (void)syncWithViewController: (UIViewController *)vc
{
    _currentVC = vc;
    
    [[HSFDatabasController sharedController] pendingUploads];
    
    NSString *csvPath = [[HSFDatabasController sharedController] pendingUploadsToCSV];
    [self displayComposerSheetWithPath:csvPath];
//    NSString *textToShare = @"Exported contacts from HSF";
//    NSArray *activityItems = @[textToShare, [NSURL fileURLWithPath:cvsPath]];
//    
//    UIActivityViewController *activityViewController = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
//    [vc presentViewController:activityViewController animated:TRUE completion:^{
        // Delete old ones
//        [[HSFDatabasController sharedController] deleteAllContacts];
//    }];
}

- (void)displayComposerSheetWithPath: (NSString *)myPath
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    [picker setSubject:@"New Contacts"];
    
    // Set up recipients
     NSArray *toRecipients = [NSArray arrayWithObject:@"mbailey@hsf.net"];
    // NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
    // NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"];
    
    [picker setToRecipients:toRecipients];
    // [picker setCcRecipients:ccRecipients];
    // [picker setBccRecipients:bccRecipients];
    
    // Attach
    NSData *myData = [NSData dataWithContentsOfFile:myPath];
    [picker addAttachmentData:myData mimeType:@"text/csv" fileName:kCSVFileName];
    
    // Fill out the email body text
    NSString *emailBody = @"New contacts in csv form";
    [picker setMessageBody:emailBody isHTML:NO];
    [_currentVC presentViewController:picker animated:YES completion:^{
        
    }];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Result: canceled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Result: saved");
            break;
        case MFMailComposeResultSent: {
            NSLog(@"Result: sent");
            // Delete old ones
            [[HSFDatabasController sharedController] deleteAllContacts];
        }
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Result: failed");
            break;
        default:
            NSLog(@"Result: not sent");
            break;
    }
    [_currentVC dismissViewControllerAnimated:YES completion:^{
        
    }];
    _currentVC = nil;
}

//- (void) sendEmailForVerificationWithCVSPath: (NSString *)path
//{
//    LogTrace(@"Sending email verification for path: %@", path);
//    
//    [self sendEmailTo:kVerificationEmail_Recipient
//          withSubject:kVerificationEmail_Subject
//             withBody:[self messageBodyWithUser:unverifiedUser]];
//}
//
//- (void) sendEmailTo:(NSString *)emailAddress
//         withSubject:(NSString *)subject
//            withBody:(NSString *)body {
//    NSString *mailString = [NSString stringWithFormat:@"mailto:?to=%@&subject=%@&body=%@",
//                            [emailAddress stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding],
//                            [subject stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding],
//                            [body stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
//    
//    LogTrace(@"Sending email: %@", mailString);
//    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailString]];
//}


@end
