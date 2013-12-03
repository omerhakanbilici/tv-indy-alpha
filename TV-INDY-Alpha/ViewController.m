//
//  ViewController.m
//  TV-INDY-Alpha
//
//  Created by Ömer Hakan Bilici on 3.12.2013.
//  Copyright (c) 2013 Ömer Hakan Bilici. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //todo credentials must be from db or social api
    credentialsDictionary = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:@"0000", @"", nil] forKeys:[NSArray arrayWithObjects:@"hakan", @"", nil]];
}

- (IBAction) enterCredentials {
    
    if ([[credentialsDictionary objectForKey:usernameField.text]isEqualToString:passwordField.text]) {
        NSLog(@"Authorization Success!");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Correct Password" message:@"Password is correct." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
    }
    else {
        NSLog(@"Authorization Failed!");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect Password" message:@"Password is incorrect." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
    }
    
    
}

@end
