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
static Db* _db;

+(Db*)db{
    if(_db==nil){
        _db=[[Db alloc]init];
    }
    return _db;
}

-(id)init{
    if((self=[super init])) {
        NSString* s = [[NSBundle mainBundle] pathForResource:@"banklist" ofType:@"sqlite3"];
        if(sqlite3_open([s UTF8String], &_db) != SQLITE_OK){
            NSLog(@"Failed to open database!");
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
            FailedBankInfo* info=[[FailedBankInfo alloc] initWithUniqueId:id
                                                                     name:n
                                                                     city:c];
            
            [retval addObject:info];
        };
        sqlite3_finalize(st);
    }
    return retval;
}
@end
