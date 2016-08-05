//
//  LPSearchBar.m
//
//  Created by litt1e-p on 16/8/3.
//  Copyright © 2016年 litt1e-p. All rights reserved.
//


#import "LPSearchBar.h"

@interface LPSearchBar()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *textFieldContainer;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, assign) BOOL hasCustomLeftView;

@end

@implementation LPSearchBar
@synthesize text = _text;
@synthesize leftView = _leftView;

- (void)awakeFromNib
{
    [self initSubviews];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)initSubviews
{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.textFieldContainer];
    [self.textFieldContainer addSubview:self.leftView];
    [self.textFieldContainer addSubview:self.textField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LPSearchBarDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backgroundImageView.frame = self.bounds;
    self.textFieldContainer.frame  = CGRectMake(10.0, 4.5, [self searchTextFieldWidth], [self searchTextFieldHeight]);
    self.leftView.frame = CGRectMake(5.0, [self searchTextFieldHeight] * 0.3, self.hasCustomLeftView ? self.leftView.frame.size.width : [self searchTextFieldWidth] * 0.4, [self searchTextFieldHeight] * 0.4);
    self.textField.frame      = CGRectMake(CGRectGetMaxX(self.leftView.frame) + 5.0, 0.0, self.textFieldContainer.frame.size.width - CGRectGetMaxX(self.leftView.frame) - 5.0, self.textFieldContainer.frame.size.height);
    self.cancelButton.frame   = CGRectMake(CGRectGetMaxX(self.textFieldContainer.frame) + 5.0, self.textFieldContainer.frame.origin.y, self.bounds.size.width - CGRectGetMaxX(self.textFieldContainer.frame) - 5.0, self.textFieldContainer.frame.size.height);
    
}

- (UIButton *)cancelButton
{
    if (!_cancelButton) {
        UIButton *cb = [UIButton buttonWithType:UIButtonTypeCustom];
        if (self.tintColor) {
            [cb setTitleColor:self.tintColor forState:UIControlStateNormal];
            [cb setTitleColor:[self.tintColor colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
        } else {
            [cb setTitleColor:cb.tintColor forState:UIControlStateNormal];
            [cb setTitleColor:[cb.tintColor colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
        }
        cb.titleLabel.font = [UIFont systemFontOfSize:17.0];
        [cb addTarget:self action:@selector(cancelBtnEvent) forControlEvents:UIControlEventTouchUpInside];
        self.cancelButton  = cb;
    }
    return _cancelButton;
}

- (UITextField *)textField
{
    if (!_textField) {
        UITextField *tf           = [[UITextField alloc] init];
        tf.backgroundColor        = [UIColor clearColor];
        tf.borderStyle            = UITextBorderStyleNone;
        tf.delegate               = self;
        tf.clearButtonMode        = YES;
        tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
        tf.returnKeyType          = UIReturnKeySearch;
        tf.enablesReturnKeyAutomatically = YES;
        tf.font = [UIFont systemFontOfSize:15.0];
        if (self.tintColor) {
            tf.tintColor = self.tintColor;
        }
        self.textField   = tf;
    }
    return _textField;
}

- (UIView *)textFieldContainer
{
    if (!_textFieldContainer) {
        UIView *bg              = [[UIView alloc] init];
        bg.backgroundColor      = [UIColor whiteColor];
        bg.layer.cornerRadius   = 4.0;
        bg.layer.masksToBounds  = YES;
        self.textFieldContainer = bg;
    }
    return _textFieldContainer;
}

- (UIImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        UIImageView *iv          = [[UIImageView alloc] init];
        iv.image                 = [self defaultBackgroundImage];
        self.backgroundImageView = iv;
    }
    return _backgroundImageView;
}

- (UIImage *)defaultBackgroundImage
{
    CGSize imageSize = self.bounds.size;
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0] set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *colorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return colorImage;
}

- (UIView *)leftView
{
    if (!_leftView) {
        UIImageView *lv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scope_icon"]];
        lv.contentMode  = UIViewContentModeScaleAspectFit;
        self.leftView   = lv;
    }
    return _leftView;
}

- (void)setLeftView:(UIView *)leftView
{
    if (_leftView) {
        [_leftView removeFromSuperview];
    }
    _leftView = leftView;
    [self.textFieldContainer addSubview:_leftView];
    self.hasCustomLeftView = true;
}

- (void)setCancelStr:(NSString *)cancelStr
{
    _cancelStr = cancelStr;
    [self.cancelButton setTitle:cancelStr forState:UIControlStateNormal];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    _backgroundImage               = backgroundImage;
    self.backgroundImageView.image = backgroundImage;
}

- (void)setShowsCancelButton:(BOOL)showsCancelButton
{
    _showsCancelButton = showsCancelButton;
    if (showsCancelButton) {
        [self addSubview:self.cancelButton];
        self.cancelStr = @"Cancel";
        [self setNeedsLayout];
    }
}

- (CGFloat)searchTextFieldHeight
{
    return 60.0 * self.bounds.size.height / 88.0;
}

- (CGFloat)searchTextFieldWidth
{
    if (self.cancelStr.length > 0) {
        CGFloat textWidth = self.cancelButton.titleLabel.intrinsicContentSize.width;
        return (self.showsCancelButton ? 600 - textWidth * 2 : 600.0) * self.bounds.size.width / 640.0;
    }
    return (self.showsCancelButton ? 530.0 : 600.0) * self.bounds.size.width / 640.0;
}

- (void)setFont:(UIFont *)font
{
    _font               = font;
    self.textField.font = font;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self.textField setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    [self.textField setTextColor:textColor];
    
}

- (void)setText:(NSString *)text
{
    _text = text;
    self.textField.text = text;
}

- (NSString *)text
{
    return self.textField.text;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder               = placeholder;
    self.textField.placeholder = placeholder;
}

- (void)resignFirstResponder
{
    [self.textField resignFirstResponder];
}

- (void)becomeFirstResponder
{
    [self.textField becomeFirstResponder];
}

#pragma mark - TextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)] ) {
        return [self.delegate searchBarShouldBeginEditing:self];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.isFirstResponder = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarTextDidBeginEditing:)]) {
        [self.delegate searchBarTextDidBeginEditing:self];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarShouldEndEditing:)]) {
        return [self.delegate searchBarShouldEndEditing:self];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarTextDidEndEditing:)]) {
        [self.delegate searchBarTextDidEndEditing:self];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBar:shouldChangeTextInRange:replacementText:)]) {
        return [self.delegate searchBar:self shouldChangeTextInRange:range replacementText:string];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarSearchButtonClicked:)]) {
        [self.delegate searchBarSearchButtonClicked:self];
    }
    return YES;
}

- (void)LPSearchBarDidChange:(NSNotification *)notification
{
    UITextField *textField = [notification object];
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBar:textDidChange:)]) {
        [self.delegate searchBar:self textDidChange:textField.text];
    }
}

- (void)cancelBtnEvent
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarCancelButtonClicked:)]) {
        [self.delegate searchBarCancelButtonClicked:self];
    }
}
@end