//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Ishaan Gandhi on 5/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CalculatorViewController : UIViewController //<FBRequestDelegate,
//FBDialogDelegate,
//FBSessionDelegate>
{
    //Calculator Values
    BOOL userIsInTheMiddleOfTypingANumber;    
    double operand;
    double memory;
    double memoryTwo;
    double waitingOperand;
    NSString *waitingOperation;
    
    //Interface
    IBOutlet UILabel *screen;
    //IBOutletCollection(UILabel) UILabel *screenCollection;
    IBOutlet UIImageView *screenImage;
    IBOutlet UILabel *errorField;
    //IBOutlet UIView *land;
    //IBOutlet UIView *port;
    IBOutlet UIImageView *backgroundImage;
    
    //Facebook Elements
    //IBOutlet UIButton *facebookButton;
    //IBOutlet UIButton *infoButton;
    //IBOutlet UILabel  *facebookLabel;
    //IBOutlet UIImageView *facebookImageView;
    //Facebook *facebook;
    //NSArray *_permissions;

}

//@property (nonatomic, retain) Facebook *facebook;
//@property (nonatomic, retain) IBOutletCollection(UILabel) UILabel *screenCollection;

-(IBAction)AC;
-(IBAction)digitPressed:(UIButton *)sender;
-(IBAction)flip;
-(IBAction)operationPressed:(UIButton *)sender;
//-(IBAction)publishOnFacebook;
-(IBAction)mClear;
-(IBAction)mStore;
-(IBAction)mRecall;
-(IBAction)mTwoClear;
-(IBAction)mTwoStore;
-(IBAction)mTwoRecall;
-(IBAction)pointPressed;

-(void)changeImage:(NSInteger)image;

@end