//
//  DetailsViewController.h
//  SQLiteSample
//
//  Created by Constantine Mars on 3/25/16.
//  Copyright © 2016 Constantine Mars. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsViewController : UIViewController
@property NSString* name;
@property (weak) IBOutlet UILabel* label;
@end
