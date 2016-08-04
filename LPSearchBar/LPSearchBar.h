// The MIT License (MIT)
//
// Copyright (c) 2015-2016 litt1e-p ( https://github.com/litt1e-p )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class LPSearchBar;

@protocol LPSearchBarDelegate <NSObject>

@optional

- (BOOL)LPSearchBarShouldBeginEditing:(LPSearchBar *)searchBar;
- (void)LPSearchBarTextDidBeginEditing:(LPSearchBar *)searchBar;
- (BOOL)LPSearchBarShouldEndEditing:(LPSearchBar *)searchBar;
- (void)LPSearchBarTextDidEndEditing:(LPSearchBar *)searchBar;
- (void)LPSearchBar:(LPSearchBar *)searchBar textDidChange:(NSString *)searchText;
- (BOOL)LPSearchBar:(LPSearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (void)LPSearchBarSearchButtonClicked:(LPSearchBar *)searchBar;
- (void)LPSearchBarCancelButtonClicked:(LPSearchBar *)searchBar;

@end

@interface LPSearchBar : UIView

@property (nonatomic, strong) UIImage     *backgroundImage;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView      *leftView;
@property (nonatomic, strong) UIButton    *cancelButton;
@property (nonatomic, copy  ) NSString    *cancelStr;
@property (nonatomic, copy  ) NSString    *placeholder;
@property (nonatomic, strong) UIFont      *font;
@property (nonatomic, copy  ) NSString    *text;
@property (nonatomic, strong) UIColor     *placeholderColor;
@property (nonatomic, strong) UIColor     *textColor;
@property (nonatomic, strong) UIColor     *tintColor;

@property (nonatomic, assign) BOOL showsCancelButton;
@property (nonatomic, assign) BOOL isFirstResponder;

@property (nonatomic, weak) id <LPSearchBarDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)resignFirstResponder;
- (void)becomeFirstResponder;

@end