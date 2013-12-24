//
//  AppDelegate.h
//  TV-INDY-Alpha
//
//  Created by Ömer Hakan Bilici on 3.12.2013.
//  Copyright (c) 2013 Ömer Hakan Bilici. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

-(NSArray*)getCheckInPageResource;

@end
