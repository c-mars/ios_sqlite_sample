//
//  FailedBankInfo.m
//  SQLiteSample
//
//  Created by Constantine Mars on 3/24/16.
//  Copyright © 2016 Constantine Mars. All rights reserved.
//

#import "FailedBankInfo.h"

@implementation FailedBankInfo

-(id)initWithUniqueId:(int)uniqueId name:(NSString*)name city:(NSString*)city{
    if((self=[super init]) ){
        self.uniqueId=uniqueId;
        self.name=name;
        self.city=city;
    }
    return self;
}

-(void)dealloc{
    self.name=nil;
    self.city=nil;
}


@end
