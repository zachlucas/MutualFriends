//
//  SCLoginViewController.m
//  MutualFG2
//
//  Created by Lab Admin on 5/28/13.
//  Copyright (c) 2013 Lab Admin. All rights reserved.
//

#import "SCLoginViewController.h"

#import <Social/Social.h>
#import <Accounts/Accounts.h>


@interface SCLoginViewController ()

@property (nonatomic, retain) ACAccountStore *accountStore;
@property (nonatomic, retain) ACAccount *facebookAccount;

@end


@implementation SCLoginViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)me{
    NSURL *meurl = [NSURL URLWithString:@"https://graph.facebook.com/me"];
    
    SLRequest *merequest = [SLRequest requestForServiceType:SLServiceTypeFacebook
                                              requestMethod:SLRequestMethodGET
                                                        URL:meurl
                                                 parameters:nil];
    
    merequest.account = _facebookAccount;
    
    [merequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        NSString *meDataString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@", meDataString);
        
    }];
    
}


- (IBAction)login:(id)sender {
        
    
        if(!_accountStore)
            _accountStore = [[ACAccountStore alloc] init];
        
        ACAccountType *facebookTypeAccount = [_accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
        
        [_accountStore requestAccessToAccountsWithType:facebookTypeAccount
                                               options:@{ACFacebookAppIdKey: @"615336705145508", ACFacebookPermissionsKey: @[@"email"]}
                                            completion:^(BOOL granted, NSError *error) {
                                                if(granted){
                                                    NSArray *accounts = [_accountStore accountsWithAccountType:facebookTypeAccount];
                                                    _facebookAccount = [accounts lastObject];
                                                    NSLog(@"Success");
                                                    
                                                    [self me];
                                                }else{
                                                    // ouch
                                                    NSLog(@"Fail");
                                                    NSLog(@"Error: %@", error);
                                                }
                                            }];



    
    
    
    
    
    /*
    if([SLComposeViewController isAvailableForServiceType: SLServiceTypeFacebook])
    {
        // Facebook Service Type is Available
        
        SLComposeViewController *slVC   =   [SLComposeViewController composeViewControllerForServiceType: SLServiceTypeFacebook];
        SLComposeViewControllerCompletionHandler handler    =   ^(SLComposeViewControllerResult result)
        {
            if (result == SLComposeViewControllerResultCancelled)
            {
                NSLog(@"Cancelled");
                
            }
            else
            {
                NSLog(@"Done");
            }
            
            [slVC dismissViewControllerAnimated:YES completion:Nil];
        };
        slVC.completionHandler          =   handler;
        //[slVC setInitialText:@"Test Post from iOS6"];
        //[slVC addURL:[NSURL URLWithString:@"http://www.apple.com"]];
        //[slVC addImage:[UIImage imageNamed:@"someimage.png"]];
        
        [self presentViewController:slVC animated:YES completion:Nil];
    
    
    }
    else
    {
        NSLog(@"Service Unavailable!!!");
    }
    */
}












@end
