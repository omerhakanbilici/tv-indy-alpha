//
//  TimelineViewController.m
//  TV-INDY-Alpha
//
//  Created by Ömer Hakan Bilici on 8.12.2013.
//  Copyright (c) 2013 Ömer Hakan Bilici. All rights reserved.
//

#import "TimelineViewController.h"

@interface TimelineViewController ()

@end

@implementation TimelineViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Enabled monitoring of the sensor
    UIDevice *device = [UIDevice currentDevice];
    device.proximityMonitoringEnabled = YES;
    
    if (device.proximityMonitoringEnabled==YES) {
        NSLog(@"Proximity Monitoring Enabled.");
        
        // Proximity Sensor Notification
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(proximityChanged:) name:@"UIDeviceProximityStateDidChangeNotification"
                                                   object:device];
    }
    else NSLog(@"Proximity Monitoring Not-Enabled!");
    
}

//Can't work with simulator. Poor man's developer.
- (void) proximityChanged:(NSNotification *)notification {
	
    UIDevice *currentDevice = [notification object];
	NSLog(@"In proximity: %i", currentDevice.proximityState);
    
    if (currentDevice.proximityState == YES) {
    	// Enabled monitoring of the sensor
    	UIDevice *device = [UIDevice currentDevice];
    	device.proximityMonitoringEnabled = NO;
        NSLog(@"Device is close to user. Starting user favorite show check-in.");
        [self performSegueWithIdentifier:@"CheckInSegue" sender:self];
    }
    else {
        NSLog(@"Device is not close to user.");
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

- (IBAction) performCheckIn:(id)sender {
    
    [self performSegueWithIdentifier:@"CheckInSegue" sender:self];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
