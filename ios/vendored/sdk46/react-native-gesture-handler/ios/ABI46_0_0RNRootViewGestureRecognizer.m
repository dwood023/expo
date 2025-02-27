//
//  ABI46_0_0RNRootViewGestureRecognizer.m
//  ABI46_0_0RNGestureHandler
//
//  Created by Krzysztof Magiera on 12/10/2017.
//  Copyright © 2017 Software Mansion. All rights reserved.
//

#import "ABI46_0_0RNRootViewGestureRecognizer.h"

#import <UIKit/UIGestureRecognizerSubclass.h>

#ifdef ABI46_0_0RN_FABRIC_ENABLED
#import <ABI46_0_0React/ABI46_0_0RCTSurfaceTouchHandler.h>
#else
#import <ABI46_0_0React/ABI46_0_0RCTTouchHandler.h>
#endif // ABI46_0_0RN_FABRIC_ENABLED


@implementation ABI46_0_0RNRootViewGestureRecognizer
{
    BOOL _active;
}

@dynamic delegate;

- (instancetype)init
{
    if (self = [super init]) {
        self.delaysTouchesEnded = NO;
        self.delaysTouchesBegan = NO;
    }
    return self;
}

- (BOOL)shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    // This method is used to implement "enabled" feature for gesture handlers. We enforce gesture
    // recognizers that are connected with "disabled" handlers to wait for the root gesture
    // recognizer to fail and this way we block them from acting.
    ABI46_0_0RNGestureHandler *otherHandler = [ABI46_0_0RNGestureHandler
                                      findGestureHandlerByRecognizer:otherGestureRecognizer];
    if (otherHandler != nil && otherHandler.enabled == NO) {
        return YES;
    }
    return NO;
}

- (BOOL)canPreventGestureRecognizer:(UIGestureRecognizer *)preventedGestureRecognizer
{
    return ![preventedGestureRecognizer isKindOfClass:[
#ifdef ABI46_0_0RN_FABRIC_ENABLED
        ABI46_0_0RCTSurfaceTouchHandler
#else
        ABI46_0_0RCTTouchHandler
#endif
        class]];
}

- (BOOL)canBePreventedByGestureRecognizer:(UIGestureRecognizer *)preventingGestureRecognizer
{
    // When this method is called it means that one of handlers has activated, in this case we want
    // to send an info to JS so that it cancells all JS responders
    [self.delegate gestureRecognizer:preventingGestureRecognizer didActivateInViewWithTouchHandler:self.view];
    return [super canBePreventedByGestureRecognizer:preventingGestureRecognizer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _active = YES;
    self.state = UIGestureRecognizerStatePossible;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.state = UIGestureRecognizerStatePossible;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.state == UIGestureRecognizerStateBegan || self.state == UIGestureRecognizerStateChanged) {
        self.state = UIGestureRecognizerStateEnded;
    } else {
        self.state = UIGestureRecognizerStateFailed;
    }
    [self reset];
    _active = NO;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.state = UIGestureRecognizerStateCancelled;
    [self reset];
    _active = NO;
}

- (void)blockOtherRecognizers
{
    if (_active) {
        self.state = UIGestureRecognizerStateBegan;
    }
}

@end
