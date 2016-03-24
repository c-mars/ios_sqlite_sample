//
//  Db.h
//  SQLiteSample
//
//  Created by Constantine Mars on 3/24/16.
//  Copyright © 2016 Constantine Mars. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface Db : NSObject {
    sqlite3* _db;
}

+(Db*)db;
-(NSArray*)failedBankInfos;

@end
