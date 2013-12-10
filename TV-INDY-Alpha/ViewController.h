//
//  ViewController.h
//  TV-INDY-Alpha
//
//  Created by Ömer Hakan Bilici on 3.12.2013.
//  Copyright (c) 2013 Ömer Hakan Bilici. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    
    IBOutlet UITextField *usernameField;
    IBOutlet UITextField *passwordField;
    
    NSDictionary *credentialsDictionary;
}

//- (IBAction) enterCredentials;
- (IBAction)loginClicked:(id)sender;

@end
