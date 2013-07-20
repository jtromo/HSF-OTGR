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
    [[HSFDatabasController sharedController] pendingUploads];
    
    NSString *cvsPath = [[HSFDatabasController sharedController] pendingUploadsToCVS];
    NSString *textToShare = @"Exported contacts from HSF";
    NSArray *activityItems = @[textToShare, [NSURL fileURLWithPath:cvsPath]];
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    [vc presentViewController:activityViewController animated:TRUE completion:^{
        // Delete old ones
//        [[HSFDatabasController sharedController] deleteAllContacts];
    }];
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
