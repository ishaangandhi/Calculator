//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Ishaan Gandhi on 5/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "FlipSideView.h"
//#import "FBConnect.h"

static NSInteger imageNumber;

@implementation CalculatorViewController
//@synthesize facebook = _facebook;

- (void)dealloc {
    [errorField release];
    [waitingOperation release];
    [backgroundImage release];
 //   [screenCollection release];
    [super dealloc];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    
//    if(UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
//        self.view = port;
//    }
//    if(UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
//        self.view = land;
//    }
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)viewWillAppear:(BOOL)animated {
    switch (imageNumber) {
        case 0:
            [backgroundImage setImage:[UIImage imageNamed:@"DVQ-HandcraftedWood.png"]];
            [screenImage setAlpha:0.70];
            break;
        case 1:
            [backgroundImage setImage:[UIImage imageNamed:@"GraySmudge.png"]];
            [screenImage setAlpha:1.00];
            break;
        case 2:
            [backgroundImage setImage:[UIImage imageNamed:@"SleekGray.png"]];
            [screenImage setAlpha:1.00];
            break;
        case 3:
            [backgroundImage setImage:[UIImage imageNamed:@"BlackSmudge.png"]];
            [screenImage setAlpha:1.00];
            break;
        case 4:
            [backgroundImage setImage:[UIImage imageNamed:@"JetBlack.png"]];
            [screenImage setAlpha:1.00];
            break;
        case 5:
            [backgroundImage setImage:[UIImage imageNamed:@"BabyBlue.png"]];
            [screenImage setAlpha:0.85];
            break;
        case 6:
            [backgroundImage setImage:[UIImage imageNamed:@"background.png"]];
            [screenImage setAlpha:1.00];
            break;
    }
}

-(void)viewDidLoad {
//    _facebook = [[Facebook alloc] initWithAppId:@"151943218210930"];
//    _permissions =  [[NSArray arrayWithObjects: @"publish_stream",nil] retain];
//    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//    BOOL premiumIsActive = [prefs boolForKey:@"premiumIsActive"];
//    if (premiumIsActive) {
//        [facebookButton setHidden:YES];
//        [facebookImageView setHidden:YES];
//        [facebookLabel setHidden:YES];
//        [infoButton setHidden:NO];
//    } else {
//        [infoButton setHidden:YES];
//    }
}

-(void)changeImage:(NSInteger)image {
    imageNumber = image;
}

-(IBAction)AC {
    operand = 0;
    waitingOperand = 0;
    [screen setText:@"0"];
    [errorField setText:@""];
}

-(IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [[sender titleLabel] text];
    [errorField setText:@""];
    if([[screen text] length] > 14) {
        [errorField setText:@"Maximum digits on screen"];
    }
    else {
        if (userIsInTheMiddleOfTypingANumber && [screen text] != @"0") {
            [screen setText:[[screen text] stringByAppendingString:digit]];        
        }
        else {
            [screen setText:digit];
            userIsInTheMiddleOfTypingANumber = YES;
        }
    }
}

-(IBAction)flip {
    FlipSideView *flipSideView = [[FlipSideView alloc] initWithNibName:@"FlipSideView" bundle:nil];
    flipSideView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:flipSideView animated:YES];
    [flipSideView release];
}

-(IBAction)operationPressed:(UIButton *)sender {
    [errorField setText:@""];
    if (userIsInTheMiddleOfTypingANumber) {
        operand = [[screen text] doubleValue];
        userIsInTheMiddleOfTypingANumber = NO;
    }
    
    NSString *operation = [[sender titleLabel] text];
    
    if([waitingOperation isEqual:@"^"]) {
        operand = pow(waitingOperand, operand);
    }
    if([waitingOperation isEqual:@"+"]) {
        operand = waitingOperand + operand;
    }
    if([waitingOperation isEqual:@"-"]) {
        operand = waitingOperand - operand;
    }
    if([waitingOperation isEqual:@"*"]) {
        operand = waitingOperand * operand;
    }
    if([waitingOperation isEqual:@"/"]) {
        if (operand) {
            operand = waitingOperand / operand;
        } else {
            [errorField setText:@"Error: Cannot divide by 0"];
        }
    }
    waitingOperation = operation;
    waitingOperand = operand;
    
    NSNumber* result = [NSNumber numberWithDouble:operand];
    
    NSNumberFormatter *fmtr = [[NSNumberFormatter alloc] init];
    [fmtr setNumberStyle:NSNumberFormatterDecimalStyle];
    [fmtr setMaximumFractionDigits:20];
    [fmtr setMaximumIntegerDigits:20];
    [fmtr setUsesGroupingSeparator:NO];
    
    [screen setText:[fmtr stringFromNumber:result]];
    [fmtr release];
}

-(IBAction)mClear {
    memory = 0;
}

-(IBAction)mStore {
    memory = [[screen text] doubleValue];
}

-(IBAction)mRecall {
    [screen setText:[NSString stringWithFormat:@"%g", memory]];
}

-(IBAction)mTwoClear {
    memoryTwo = 0;
}

-(IBAction)mTwoStore {
    memoryTwo = [[screen text] doubleValue];
}

-(IBAction)mTwoRecall {
    [screen setText:[NSString stringWithFormat:@"%g", memoryTwo]];
}

-(IBAction)pointPressed {
    if(userIsInTheMiddleOfTypingANumber) {
        NSString *screenText = [screen text];
        NSLog(@"%@", screenText);
        BOOL points = NO;
        for (int i = 0; i < [screenText length]; i++) {
            if ([screenText characterAtIndex:i] == '.') {
                points = YES;
            }
        }
        if (points) {
            [errorField setText:@"Error: Decimal point already in operand"];
        }
        else {
            [screen setText:[screenText stringByAppendingString:@"."]];
        }
    }
    else {
        [screen setText:@"0."];
         userIsInTheMiddleOfTypingANumber = YES;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////                                        ///////////////////////////////////////////
////////////////////////////////////////            Facebook Stuff              ///////////////////////////////////////////
////////////////////////////////////////                                        ///////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//
//
//
//
//- (void)login {
//    [_facebook authorize:_permissions delegate:self];
//}
//
//
//- (IBAction)publishOnFacebook {
//    
//    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                   @"http://img819.imageshack.us/img819/5700/fbcalc.png", @"picture",
//                                   @"http://itunes.apple.com/us/app/calculator-hd-free-and-ad-free/id441381050?mt=8", @"link",
//                                   @"Calculator HD - Free and Ad Free", @"subtitle",
//                                   @"I'm using a great, free and ad-free iPad calculator!", @"message",
//                                   nil];
//    
//    
//    [_facebook dialog:@"feed" andParams:params andDelegate:self];
//    
//}
//
//-(void)dialogCompleteWithUrl:(NSURL *)url {
//    if ([[NSString stringWithFormat:@"%@", url] isEqual:@"fbconnect://success"]) {
//        
//    } else {
//        [facebookButton setHidden:YES];
//        [facebookImageView setHidden:YES];
//        [facebookLabel setHidden:YES];
//        [infoButton setHidden:NO];
//        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//        [prefs setBool:YES forKey:@"premiumIsActive"];
//        [prefs synchronize];
//    }
//}

@end