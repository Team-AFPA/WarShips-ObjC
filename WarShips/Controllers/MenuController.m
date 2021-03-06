//
//  MenuController.m
//  WarShips
//
//  Created by François Juteau on 10/08/2015.
//  Copyright (c) 2015 Thibault Le Cornec. All rights reserved.
//

#import "MenuController.h"
#import "DataManager.h"
#import "ViewController.h"

@interface MenuController ()
    @property DataManager *sharedDataManager;
@end

@implementation MenuController
@synthesize sharedDataManager, pickerLevels, switchHeadShot, switchShipsMustMove, labelDebugMode, switchDebugMode;

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        sharedDataManager = [DataManager sharedDataManager];
    }
    
    return self;
}

// =================== //
// ----- METHODS ----- //
// =================== //
- (IBAction)activateHeadShot:(id)sender
{
    [sharedDataManager setIsHeadshotEnable:[sender isOn]];
}

- (IBAction)activateShipsMovement:(id)sender
{
    [sharedDataManager setShipsMustMove:[sender isOn]];
    [pickerLevels setHidden:![sender isOn]];
    [switchHeadShot setEnabled:[sender isOn]];
    [switchHeadShot setOn:[sender isOn] animated:YES];
    [sharedDataManager setIsHeadshotEnable:[switchHeadShot isOn]];
}


- (IBAction)showSwitchDebugMode:(UITapGestureRecognizer *)sender
{
    [labelDebugMode setHidden:![labelDebugMode isHidden]];
    [switchDebugMode setHidden:![switchDebugMode isHidden]];
}


- (IBAction)activateDebugMode:(id)sender
{
    [sharedDataManager setDebugMode:[switchDebugMode isOn]];
}


-(IBAction)returnFromGameToSettings:(UIStoryboardSegue*)sender
{
    // Called when exit the ViewController
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
     ViewController *destination = [segue destinationViewController];
    [destination setSharedDataManager:sharedDataManager];
    [destination setShouldHideLabelLevel:![switchShipsMustMove isOn]];
}


-(void)viewWillAppear:(BOOL)animated
{    
    [switchHeadShot setEnabled:[sharedDataManager isHeadshotEnable]];
    [switchHeadShot setOn:[sharedDataManager isHeadshotEnable]];
    
    [switchShipsMustMove setOn:[sharedDataManager shipsMustMove]];
    
    [pickerLevels selectRow:[sharedDataManager level]-1 inComponent:0 animated:NO];
    [pickerLevels setHidden:![switchShipsMustMove isOn]];

    [labelDebugMode setHidden:YES];
    [switchDebugMode setHidden:YES];
    [switchDebugMode setOn:[sharedDataManager debugMode]];
}



#pragma mark UIPickerViewDataSource Methods
// ========================================== //
// ----- UIPickerViewDataSource Methods ----- //
// ========================================== //
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return 5;
}


#pragma mark UIPickerViewDelegate Methods
// ======================================== //
// ----- UIPickerViewDelegate Methods ----- //
// ======================================== //
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"Niveau %ld", row+1];
}


- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
    [sharedDataManager setLevel:row+1];
}
@end
