//
//  HSFDefinitions.h
//  OnTheGoReg
//
//  Created by James T Romo on 7/19/13.
//  Copyright (c) 2013 Hispanic Scholarship Fund. All rights reserved.
//

#ifndef OnTheGoReg_HSFDefinitions_h
#define OnTheGoReg_HSFDefinitions_h

#define IS_PHONE  UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone

#define kCheckedState_Image @"CheckBoxChecked.png"
#define kUncheckedState_Image @"CheckBoxUnchecked.png"

// Label Names
#define kLabel1 @"Scholarships"
#define kLabel2 @"Newsletter"
#define kLabel3 @"Higher Ed Resources"
#define kLabel4 @"Volunteering with HSF"
#define kLabel5 @"Internship Opportunities"
#define kLabel6 @"Speaking Engagements"
#define kLabel7 @"Becoming an Ambassador"
#define kLabel8 @"Donating to HSF"
#define kLabel9 @"Becoming a Mentor"
#define kLabel10 @"Becoming a Mentee"
#define kLabel11 @"Other"

#define kAddtionalInfoDict @{kLabel1: @NO, kLabel2 : @NO, kLabel3 : @NO, kLabel4 : @NO, kLabel5 : @NO, kLabel6 : @NO, kLabel7 : @NO, kLabel8 : @NO, kLabel9 : @NO, kLabel10 : @NO, kLabel11 : @NO };


#define kContactTypes @[@"Student", @"Parent", @"Educator", @"Other"]

// Column Rows
#define kCacheColumn_firstName @"firstName"
#define kCacheColumn_lastName @"lastName"
#define kCacheColumn_emailAddress @"emailAddress"
#define kCacheColumn_cellPhoneNumber @"cellPhoneNumber"
#define kCacheColumn_contactType @"contactType"
#define kCacheColumn_isApplication @"isApplication"
#define kCacheColumn_isNewsletters @"isNewsletters"
#define kCacheColumn_isResources @"isResources"
#define kCacheColumn_isVolunteering @"isVolunteering"
#define kCacheColumn_isInternships @"isInternships"
#define kCacheColumn_isSpeaking @"isSpeaking"
#define kCacheColumn_isAmbassador @"isAmbassador"
#define kCacheColumn_isDonating @"isDonating"
#define kCacheColumn_isMentoring @"isMentoring"
#define kCacheColumn_isBeingMentored @"isBeingMentored"
#define kCacheColumn_other @"other"
#define kCacheColumn_creationDate @"creationDate"
#define kCacheColumn_modifiedDate @"modifiedDate"
#define kCacheColumn_isDeleted @"isDeleted"

#endif
