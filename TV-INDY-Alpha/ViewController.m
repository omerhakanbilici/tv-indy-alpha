//
//  ViewController.m
//  TV-INDY-Alpha
//
//  Created by Ömer Hakan Bilici on 3.12.2013.
//  Copyright (c) 2013 Ömer Hakan Bilici. All rights reserved.
//

#import "ViewController.h"

@interface NSURLRequest (DummyInterface)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host;
+ (void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString*)host;
@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //todo credentials must be from db or social api
//    credentialsDictionary = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:@"0000", @"", nil] forKeys:[NSArray arrayWithObjects:@"hakan", @"", nil]];
}

//- (IBAction) enterCredentials {
//    
//    if ([[credentialsDictionary objectForKey:usernameField.text]isEqualToString:passwordField.text]) {
//        NSLog(@"Authorization Success!");
////        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Correct Password" message:@"Password is correct." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
////        [alert show];
//        
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        UITableViewController *obj=[storyboard instantiateViewControllerWithIdentifier:@"Timeline"];
//        self.navigationController.navigationBarHidden=YES;
//        [self.navigationController pushViewController:obj animated:YES];
//    }
//    else {
//        NSLog(@"Authorization Failed!");
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect Password" message:@"Please try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//        [alert show];
//    }
//}

- (void) alertStatus:(NSString *)msg :(NSString *) title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

- (IBAction)loginClicked:(id)sender {
    @try {
        
        if([[usernameField text] isEqualToString:@""] || [[passwordField text] isEqualToString:@""] ) {
            [self alertStatus:@"Please enter both Username and Password" :@"Login Failed!"];
        } else {
            NSString *post =[[NSString alloc] initWithFormat:@"username=%@&password=%@",[usernameField text],[passwordField text]];
            NSLog(@"PostData: %@",post);
            
            NSURL *url=[NSURL URLWithString:@"http://www.ibrahimmumcu.com/test/hakan/index.php"];
            
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            
            NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:postData];
            
            [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
            
            NSOperationQueue *queue =[[NSOperationQueue alloc] init];

            
            [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                
                if (connectionError == nil && [data length]>0) {
                    NSLog(@"Response code: %d", [(NSHTTPURLResponse*)response statusCode]);
                    [self performSelectorOnMainThread:@selector(loginResponse:) withObject:data waitUntilDone:YES];
                }
                else{
                    NSLog(@"Error code: %d", [connectionError code]);
                }
            }];
//            
//            NSLog(@"Response code: %d", [response statusCode]);
//            if ([response statusCode] >=200 && [response statusCode] <300)
//            {
//                NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
//                NSLog(@"Response ==> %@", responseData);
//                
//                SBJsonParser *jsonParser = [SBJsonParser new];
//                NSDictionary *jsonData = (NSDictionary *) [jsonParser objectWithString:responseData error:nil];
//                NSLog(@"%@",jsonData);
//                NSInteger success = [(NSNumber *) [jsonData objectForKey:@"success"] integerValue];
//                NSLog(@"%d",success);
//                if(success == 1)
//                {
//                    NSLog(@"Login SUCCESS");
//                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                    UITableViewController *obj=[storyboard instantiateViewControllerWithIdentifier:@"Timeline"];
//                    self.navigationController.navigationBarHidden=YES;
//                    [self.navigationController pushViewController:obj animated:YES];
//                    
//                } else {
//                    
//                    NSString *error_msg = (NSString *) [jsonData objectForKey:@"error_message"];
//                    [self alertStatus:error_msg :@"Login Failed!"];
//                }
//                
//            } else {
//                if (error) NSLog(@"Error: %@", error);
//                [self alertStatus:@"Connection Failed" :@"Login Failed!"];
//            }
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Login Failed." :@"Login Failed!"];
    }
}

-(void) loginResponse:(NSData *) data{
    
    NSError *error;
    NSDictionary *dicResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if (error==nil) {
        NSNumber *success = [dicResponse objectForKey:@"success"];
        if (success == [NSNumber numberWithInt:1]) {
            NSLog(@"Login SUCCESS");
            
            [self performSegueWithIdentifier:@"LoginToMain" sender:self];
            
        }
        else {
            NSString *error_msg = [NSString stringWithFormat:@"%@", [dicResponse objectForKey:@"error_message"]];
            [self alertStatus:error_msg :@"Login Failed!"];
        }
    }
    else{
        NSLog(@"%d", [error code]);
    }
}



@end
