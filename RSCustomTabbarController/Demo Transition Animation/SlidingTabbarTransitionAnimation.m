//
//  SlidingTabbarTransitionAnimation.m
//  RSCustomTabbarController
//
//  Created by Ratul Sharker on 9/26/16.
//  Copyright © 2016 funtoos.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
// associated documentation files (the "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the
// following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial
// portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
// LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
// EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
// THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "SlidingTabbarTransitionAnimation.h"
#import "RSCustomTabbarController.h"

@implementation SlidingTabbarTransitionAnimation

-(void)customTabbarController:(RSCustomTabbarControllerBasic *)tabbarController
          willSwitchFromIndex:(NSUInteger)oldIndex
            willSwitchToIndex:(NSUInteger)newIndex
 withAnimationCompletionBlock:(RSCustomTabbarGeneralPurposeBlock)completionBlock
{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    UIViewController *toViewController = [tabbarController getViewControllerAtIndex:newIndex];
    CGRect finalFrame = [(RSCustomTabbarController*)tabbarController getViewControllerContainerFrame];
    
    toViewController.view.alpha = 0.0;
    toViewController.view.frame = CGRectMake((newIndex > oldIndex) ? finalFrame.size.width : -finalFrame.size.width,
                                             finalFrame.origin.y,
                                             finalFrame.size.width,
                                             finalFrame.size.height);
    
    

    [UIView animateWithDuration:0.3 animations:^{
       
        toViewController.view.frame = finalFrame;
        toViewController.view.alpha = 1.0;
        
    } completion:^(BOOL finished) {
        
        if(completionBlock)
            completionBlock();
        
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }];
}
@end
