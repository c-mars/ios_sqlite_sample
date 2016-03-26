//
//  Db.m
//  SQLiteSample
//
//  Created by Constantine Mars on 3/24/16.
//  Copyright © 2016 Constantine Mars. All rights reserved.
//

#import "FailedBankInfo.h"
#import "Db.h"

@implementation Db
static Db* _instance;

+(Db*)instance{
    if(_instance==nil){
        _instance=[[Db alloc]init];
    }
    return _instance;
}

-(id)init{
    if((self=[super init])) {
        // Set up a SQLCipher database connection:
        
        if (sqlite3_open([self.databasePath UTF8String], &_db) == SQLITE_OK) {
            
            sqlite3_key(_db, "test123", 7);
            
            if (sqlite3_exec(_db, (const char*) "SELECT count(*) FROM sqlite_master;", NULL, NULL, NULL) == SQLITE_OK) {
                NSLog(@"Password is correct, or a new database has been initialized");
            } else {
                NSLog(@"Incorrect password!");
            }
            
            [self initWithDefaults];
        }
    }
    return self;
}

- (void)dealloc{
    sqlite3_close(_db);
}

-(NSArray *)failedBankInfos{
    NSMutableArray* retval=[[NSMutableArray alloc]init];
    NSString* s=@"SELECT id, name, city FROM failed_banks";
    sqlite3_stmt* st;
    if(sqlite3_prepare_v2(_db, [s UTF8String], -1, &st, nil)==SQLITE_OK){
        while (sqlite3_step(st)==SQLITE_ROW) {
            int id=sqlite3_column_int(st, 0);
            char* nc=(char*)sqlite3_column_text(st, 1);
            char* cc=(char*)sqlite3_column_text(st, 2);
            
            NSString* n=[[NSString alloc] initWithUTF8String:nc];
            NSString* c=[[NSString alloc] initWithUTF8String:cc];
            FailedBankInfo* info=[[FailedBankInfo alloc] initWithUniqueId:id name:n city:c];
                    
            [retval addObject:info];
        };
        sqlite3_finalize(st);
    }
    return retval;
}

-(void)initWithDefaults{
        static sqlite3_stmt *compiledStatement;
        
        sqlite3_exec(_db, "drop table if exists 'failed_banks'", NULL, NULL, NULL);
        sqlite3_exec(_db, "create table if not exists 'failed_banks' ('id' integer primary key, 'name' text, 'city' text);", NULL, NULL, NULL);

        [self insert:@"Mega Bank" city:@"New York"];
        [self insert:@"Fort Knox" city:@"Los Angeles"];
        [self insert:@"MoneyBox" city:@"San Andreas"];
        
        sqlite3_finalize(compiledStatement);
}

-(void)insert:(NSString*)name city:(NSString*)city {
    sqlite3_exec(_db, [[NSString stringWithFormat:@"insert into failed_banks (name, city) values ('%@', '%@')", name, city] UTF8String], NULL, NULL, NULL);
}

- (NSString *)databasePath {
    NSString* databaseName = @"banklist.sqlite3";
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    
    NSString* databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    success = [fileManager fileExistsAtPath:databasePath];
    if(!success) {
        [[NSFileManager defaultManager] createFileAtPath:databasePath
                                                contents:nil
                                              attributes:nil];
    }
    
    return  databasePath;
}

- (NSURL *)databaseURL {
    NSArray *URLs = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *directoryURL = [URLs firstObject];
    NSURL *databaseURL = [directoryURL URLByAppendingPathComponent:@"secure.db"];
    return  databaseURL;
}

- (BOOL)databaseExists {
    BOOL exists = NO;
    NSError *error = nil;
    exists = [[self databaseURL] checkResourceIsReachableAndReturnError:&error];
    if (exists == NO && error != nil) {
        NSLog(@"Error checking availability of database file: %@", error);
    }
    return exists;
}

@end
