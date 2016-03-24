//
//  FailedBankInfo.h
//  SQLiteSample
//
//  Created by Constantine Mars on 3/24/16.
//  Copyright © 2016 Constantine Mars. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FailedBankInfo : NSObject
@property (nonatomic, assign) int uniqueId;
@property (nonatomic, assign) NSString* name;
@property (nonatomic, assign) NSString* city;

-(id)initWithUniqueId:(int)uniqueId name:(NSString*)name city:(NSString*)city;

@end
