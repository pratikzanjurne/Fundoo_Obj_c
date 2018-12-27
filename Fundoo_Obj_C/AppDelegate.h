//
//  AppDelegate.h
//  Fundoo_Obj_C
//
//  Created by BridgeLabz Solutions LLP  on 12/10/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CoreDataDBManager.h"
@import UserNotifications;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
+(UNUserNotificationCenter*)center;
@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

