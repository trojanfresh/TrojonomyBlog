/

//  ViewController.m

//  blogplayground

//

//  Created by Trojonomy on 6/15/15.

//  Copyright (c) 2015 Trojonomy. All rights reserved.

//


#import "ViewController.h"


@interface ViewController ()

{

    NSMutableArray *resultArray;

    NSMutableData *responseData;

}

@end


@implementation ViewController


- (void)viewDidLoad {

    [super viewDidLoad];

    //Easy and Dirty View Loads Just Call Function

    [self getComputerParts];

}


- (void)getComputerParts{

    responseData = [NSMutableData data];

    NSString *percentEscapedString = @"";

    

    percentEscapedString = [[NSString stringWithFormat:@"whateverisyoururlandconnection"

                             ] stringByAddingPercentEscapesUsingEncoding:

                            NSUTF8StringEncoding];

    

    NSURL *url = [NSURL URLWithString:percentEscapedString];

    

    /*Send The Request To The Url*/

    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {

        

        /*Error Lets Handle That*/

        if (error) {

            if(![NSThread isMainThread])

            {

                dispatch_async(dispatch_get_main_queue(), ^{

                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Error Communicating With Server" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];

                    [alert show];

                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

                });

            }

            

            

        } else {

            /*Got Data Lets Try To Serialize It*/

             NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];

            /*Can't Serialize Throw Error*/

            if (error){

                if(![NSThread isMainThread])

                {

                    dispatch_async(dispatch_get_main_queue(), ^{

                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Error Communicating With Server" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];

                        [alert show];

                        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

                    });

                }

                

            }

            if (!resultArray) {

                resultArray = [[NSMutableArray alloc] init];

            }

            /*Easy simple let example

             we have the array

             We know 0 is Status 1 Is Results 2 Is Recordcount*/

                NSMutableDictionary *status_diction =  [array objectAtIndex:0];

            

                NSMutableArray *status_array = status_diction[@"Status"] ;

                status_diction = [status_array objectAtIndex:0];

                NSLog(@"TESTRESULTSStatus - %@", status_diction[@"Status"]);

                NSLog(@"TESTRESULTSCode - %@", status_diction[@"Code"]);

                NSLog(@"TESTRESULTSReason - %@", status_diction[@"Reason"]);

            

            

            NSLog(@"----------------------------------------------");

            /*Lets Get Results and Loop Over Array */

            NSMutableDictionary *object_array =  [array objectAtIndex:1];

            NSMutableArray *results_array = object_array[@"results"];

            for (NSMutableDictionary *dictionary in results_array)

            {

                NSLog(@"TESTRESULTSNAME - %@", dictionary[@"name"]);

                NSLog(@"TESTRESULTSPRICE - %@", dictionary[@"price"]);

                NSLog(@"TESTRESULTSBRAND - %@", dictionary[@"brand"]);

                NSLog(@"----------------------------------------------");

            }

            /*Row Count*/

            NSMutableDictionary *row_count =  [array objectAtIndex:2];

            NSLog(@"TESTRESULTSRowCount- %@", row_count[@"rowcounts"]);

            

        }

    }];


}


- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.

    

    

    

}


@end