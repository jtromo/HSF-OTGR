//
//  HSFDatabasController.m
//  OnTheGoReg
//
//  Created by James T Romo on 7/19/13.
//  Copyright (c) 2013 Hispanic Scholarship Fund. All rights reserved.
//

#import "HSFDatabasController.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "FMResultSet.h"
//#import "NSFileManager+NSFileManagerExtensions.h"
//#import "NSString+NSStringExtensions.h"
#import "HSFContact.h"
#import "NSDate+Extensions.h"
#import "CHCSVParser.h"

static HSFDatabasController * _sharedInstance;

@interface HSFDatabasController()
@property (nonatomic, strong) FMDatabaseQueue * contactDBQueue;
@end

@implementation HSFDatabasController

+ (void) initialize
{
    _sharedInstance = [[self alloc] init];
}

+ (HSFDatabasController *) sharedController;
{
    return _sharedInstance;
}


- (id) init
{
    if (!(self = [super init])) {
        return nil;
    }
    
    [self setupDB];
    
    return self;
}

+ (NSString *) defaultDatabaseName;
{
    return @"contactDB.sqlite3";
}

+ (NSString *) databaseName;
{
    return [self defaultDatabaseName];
}

- (void) setupDB;
{
    NSString * dbName = [HSFDatabasController databaseName];
    
    [self createEditableCopyOfResourceIfNeeded: dbName
                                 alwaysReset: NO];
    
    _contactDBQueue = [FMDatabaseQueue databaseQueueWithPath: [self writablePathForDocumentNamed: dbName]];
    if (!_contactDBQueue) {
        LogError(@"Failed to create contact DB queue");
        exit(1);
    }
    
    [_contactDBQueue inDatabase: ^(FMDatabase *db) {
        if (![db executeUpdate: @"PRAGMA foreign_keys = ON"]) {
            LogError(@"Database Error; error = %@", [db lastErrorMessage]);
            exit(1);
        }
    }];
}

- (void)createEditableCopyOfResourceIfNeeded: (NSString *) myResourceName alwaysReset: (BOOL) yn
{
    NSParameterAssert([myResourceName length]);
    
    BOOL success = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = NULL;
    NSString *defaultDBPath = nil;
    NSString *writablePath = nil;
    
    writablePath = [self writablePathForDocumentNamed: myResourceName];
    success = [fileManager fileExistsAtPath:writablePath];
    if (success) {
        if (yn) {
            [fileManager removeItemAtPath: writablePath error: &error];
        } else {
            LogInfo(@"Pre-existing resource found at: %@", writablePath);
            return;
        }
    }
    
    // The writable resource does not exist (or is being reset), so copy the default to the appropriate location.
    defaultDBPath = [self pathForResourceNamed: myResourceName];
    LogInfo(@"Preparing to copy default resource from: %@ to: %@", defaultDBPath, writablePath);
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writablePath error:&error];
    if (!success) {
        LogError(@"Failed to copy default resource from: %@ to: %@. Error = %@", defaultDBPath, writablePath, [error localizedDescription]);
        NSAssert1(0, @"Failed to create writable resource file with message '%@'.", [error localizedDescription]);
    }
}

- (NSString *) pathForResourceNamed: (NSString *) myDocumentName
{
    NSParameterAssert([myDocumentName length]);
    
	NSString * result = nil;
	result = [[NSBundle mainBundle] pathForResource: myDocumentName ofType: nil];
    
	return result;
}

- (NSString *) writablePathForDocumentNamed: (NSString *) myDocumentName;
{
    NSParameterAssert([myDocumentName length]);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString * result = nil;
    
    result = [documentsDirectory stringByAppendingFormat: @"/%@", myDocumentName];
	
    return result;
}

#pragma mark Insert

- (BOOL) insertContact: (HSFContact *)myContact
{
    __block BOOL success = YES;
    
    [_contactDBQueue inDatabase:^(FMDatabase *db) {
        
        LogTrace(@"Inserting contact");
        
        NSDate *currentDate = [NSDate date];
        NSNumber *lbl1Num = [myContact.additionalInfo objectForKey:kLabel1];
        NSNumber *lbl2Num = [myContact.additionalInfo objectForKey:kLabel2];
        NSNumber *lbl3Num = [myContact.additionalInfo objectForKey:kLabel3];
        NSNumber *lbl4Num = [myContact.additionalInfo objectForKey:kLabel4];
        NSNumber *lbl5Num = [myContact.additionalInfo objectForKey:kLabel5];
        NSNumber *lbl6Num = [myContact.additionalInfo objectForKey:kLabel6];
        NSNumber *lbl7Num = [myContact.additionalInfo objectForKey:kLabel7];
        NSNumber *lbl8Num = [myContact.additionalInfo objectForKey:kLabel8];
        NSNumber *lbl9Num = [myContact.additionalInfo objectForKey:kLabel9];
        NSNumber *lbl10Num = [myContact.additionalInfo objectForKey:kLabel10];
        NSNumber *lbl11Num = [myContact.additionalInfo objectForKey:kLabel11];
        
        NSString * sql;
        sql = [NSString stringWithFormat: @"INSERT INTO contact (%@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@) VALUES ('%@', '%@', '%@', '%@', '%@', '%hhd', '%hhd', '%hhd', '%hhd', '%hhd', '%hhd', '%hhd', '%hhd', '%hhd', '%hhd', '%hhd', '%f', '%f', '%d')",
               kCacheColumn_firstName,
               kCacheColumn_lastName,
               kCacheColumn_emailAddress,
               kCacheColumn_cellPhoneNumber,
               kCacheColumn_contactType,
               kCacheColumn_isApplication,
               kCacheColumn_isNewsletters,
               kCacheColumn_isResources,
               kCacheColumn_isVolunteering,
               kCacheColumn_isInternships,
               kCacheColumn_isSpeaking,
               kCacheColumn_isAmbassador,
               kCacheColumn_isDonating,
               kCacheColumn_isMentoring,
               kCacheColumn_isBeingMentored,
               kCacheColumn_other,
               kCacheColumn_creationDate,
               kCacheColumn_modifiedDate,
               kCacheColumn_isDeleted,
               myContact.firstName,
               myContact.lastName,
               myContact.email,
               myContact.phoneNumber,
               myContact.contactType,
               [lbl1Num boolValue],
               [lbl2Num boolValue],
               [lbl3Num boolValue],
               [lbl4Num boolValue],
               [lbl5Num boolValue],
               [lbl6Num boolValue],
               [lbl7Num boolValue],
               [lbl8Num boolValue],
               [lbl9Num boolValue],
               [lbl10Num boolValue],
               [lbl11Num boolValue],
               [currentDate julianDay],
               [currentDate julianDay],
               0];
        
        if(![db executeUpdate:sql]){
            LogError(@"Contact could not be inserted. Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
            success = NO;
            return;
        }
        LogTrace(@"Contact successfully inserted");
        
    }];
    
    return success;
}

#pragma mark Soft Delete
// Soft delete only changes isDeleted to 1

// Soft deleteAllContacts
- (BOOL) deleteAllContacts
{
    __block BOOL success = YES;
    
    [_contactDBQueue inDatabase:^(FMDatabase *db) {
        
        LogTrace(@"Deleting all assets");
        
        if(![db executeUpdate:@"UPDATE contact SET isDeleted = 1"]){
            LogError(@"All contacts could not be deleted. Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
            success = NO;
            return;
        }
        LogTrace(@"All contacts successfully deleted");
        
    }];
    
    return success;
}

// Retrieves contacts from the DB
- (void) pendingUploadsToCVS
{
    [_contactDBQueue inDatabase:^(FMDatabase *db) {
        
        LogTrace(@"Getting pendingUploads");
        
        // Select all assets that were not deleted and not on first run

        NSString *query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = 0", @"contact" ,kCacheColumn_isDeleted];
        
        FMResultSet *rs = [db executeQuery:query];
        if(!rs){
            LogError(@"pendingUploads search failed. Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
            return;
        }
        LogTrace(@"pendingUploads successful");
        
        [self extractContactsFromResultSetToCVS:rs];
        
    }];
}

- (NSArray *) pendingUploads
{
    __block BOOL success = YES;
    __block NSMutableArray *contacts = nil;
    
    [_contactDBQueue inDatabase:^(FMDatabase *db) {
        
        LogTrace(@"Getting pendingUploads");
        
        // Select all assets that were not deleted and not on first run
        
        NSString *query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = 0", @"contact" ,kCacheColumn_isDeleted];
        
        FMResultSet *rs = [db executeQuery:query];
        if(!rs){
            LogError(@"pendingUploads search failed. Error %d: %@", [db lastErrorCode], [db lastErrorMessage]);
            success = NO;
            return;
        }
        LogTrace(@"pendingUploads successful");
        
        contacts = [NSMutableArray arrayWithArray:[self extractContactsFromResultSet:rs]];
        if (!contacts) {
            LogError(@"Could not extract contacts from result set");
            [rs close];
            success = NO;
            return;
        }
    }];
    
    LogTrace(@"pendingUploads: contacts Found: %d",[contacts count]);
    
    return [NSArray arrayWithArray:contacts];
}

#pragma mark - Helpers and Wrappers

- (void) extractContactsFromResultSetToCVS: (FMResultSet *) myResultSet
{
    if (!myResultSet) {
        LogError(@"FMResultSet is null");
        return;
    }
    BOOL success = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *writablePath = nil;
    
    writablePath = [self writablePathForDocumentNamed: @"contacts.cvs"];
    success = [fileManager fileExistsAtPath:writablePath];
    if (success) {
        
    }
    CHCSVWriter *csvWriter = [[CHCSVWriter alloc] initForWritingToCSVFile:writablePath];
    
    while([myResultSet next]){
        
        
        // Gather info from database result
        NSString * firstName = [myResultSet stringForColumn:kCacheColumn_firstName];
        [csvWriter writeField:firstName];
        NSString * lastName = [myResultSet stringForColumn:kCacheColumn_lastName];
        [csvWriter writeField:lastName];
        NSString * emailAddress = [myResultSet stringForColumn:kCacheColumn_emailAddress];
        [csvWriter writeField:emailAddress];
        NSString * cellPhoneNumber = [myResultSet stringForColumn:kCacheColumn_cellPhoneNumber];
        [csvWriter writeField:cellPhoneNumber];
        NSString * contactType = [myResultSet stringForColumn:kCacheColumn_contactType];
        [csvWriter writeField:contactType];
        NSString * isApplication = [myResultSet stringForColumn:kCacheColumn_isApplication];
        [csvWriter writeField:isApplication];
        NSString * isNewsletters = [myResultSet stringForColumn:kCacheColumn_isNewsletters];
        [csvWriter writeField:isNewsletters];
        NSString * isVolunteering = [myResultSet stringForColumn:kCacheColumn_isVolunteering];
        [csvWriter writeField:isVolunteering];
        NSString * isInternships = [myResultSet stringForColumn:kCacheColumn_isInternships];
        [csvWriter writeField:isInternships];
        NSString * isSpeaking = [myResultSet stringForColumn:kCacheColumn_isSpeaking];
        [csvWriter writeField:isSpeaking];
        NSString * isAmbassador = [myResultSet stringForColumn:kCacheColumn_isAmbassador];
        [csvWriter writeField:isAmbassador];
        NSString * isDonating = [myResultSet stringForColumn:kCacheColumn_isDonating];
        [csvWriter writeField:isDonating];
        NSString * isMentoring = [myResultSet stringForColumn:kCacheColumn_isMentoring];
        [csvWriter writeField:isMentoring];
        NSString * isBeingMentored = [myResultSet stringForColumn:kCacheColumn_isBeingMentored];
        [csvWriter writeField:isBeingMentored];
        NSString * other = [myResultSet stringForColumn:kCacheColumn_other];
        [csvWriter writeField:other];
        
        [csvWriter finishLine];
        
    }
    [csvWriter closeStream];
}

// Converts result set to array of Asset Objects
- (NSArray *) extractContactsFromResultSet: (FMResultSet *) myResultSet
{
    if (!myResultSet) {
        LogError(@"FMResultSet is nil");
        return nil;
    }
    
    NSMutableArray * results = [NSMutableArray array];
    
    while([myResultSet next]){
        HSFContact *newContact = [[HSFContact alloc] initWithFMResultSet:myResultSet];
        [results addObject:newContact];
    }
    
    return [NSArray arrayWithArray:results];
}

@end
