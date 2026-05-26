//
//  TKServiceAndPrivacyAlterView.m
//  EduClass
//
//  Created by Evan on 2020/3/16.
//  Copyright © 2020 talkcloud. All rights reserved.
//

#define CheckProportion fmin((ScreenH < ScreenW ? ScreenW/1024.0 : ScreenH/1024.0), 1)

#define selfviewWidth (ScreenH < ScreenW ? ScreenH : ScreenW)
#define KButtonHeight (IS_PAD ? 50.0f : 35.0f)
#define KBtnFont   (IS_PAD ? 20.0f : 17.0f)
#import "TKServiceAndPrivacyAlterView.h"
#import "TKPrivacyView.h"

@interface TKServiceAndPrivacyAlterView  ()<UITextViewDelegate>
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLa;
@property (nonatomic, strong) UITextView *detailsLa;
@property (nonatomic, strong) UIButton *agreeBtn;
@property (nonatomic, strong) UIButton *disagreeBtn;
@property (nonatomic, strong) NSArray *stringArr;
@property (nonatomic, strong) NSMutableArray *rangeMarry;

@end

@implementation TKServiceAndPrivacyAlterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
        
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.titleLa];
        [self.contentView addSubview:self.detailsLa];
        [self.contentView addSubview:self.agreeBtn];
        [self.contentView addSubview:self.disagreeBtn];
        
        if (IS_PAD) {
            [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@(560));
                make.center.equalTo(self);
                make.height.equalTo(@(588));
//                make.top.equalTo(self).offset(80);
//                make.bottom.equalTo(self).offset(-80);
            }];
        }else{
            [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.top.equalTo(self).offset(50);
                make.bottom.equalTo(self).offset(-50);
                make.left.equalTo(self).offset(20);
                make.right.equalTo(self).offset(-20);
            }];
        }
        
        [_titleLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(40 * CheckProportion);
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView.mas_right);
        }];
        
        [_detailsLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLa.mas_bottom).offset(30 * CheckProportion);
            make.left.equalTo(self.contentView).offset(50 * CheckProportion);
            make.right.equalTo(self.contentView.mas_right).offset(-50 * CheckProportion);
            make.bottom.equalTo(self.contentView).offset(-143 * CheckProportion);
        }];
        
        [_agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-52 * CheckProportion);
            make.right.equalTo(self.detailsLa.mas_right);
            make.size.mas_equalTo(CGSizeMake(KButtonHeight * 3.5,KButtonHeight));
        }];
        
        
        [_disagreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_agreeBtn);
            make.left.equalTo(_detailsLa);
            make.size.mas_equalTo(CGSizeMake(KButtonHeight * 3.5,KButtonHeight));
        }];
        
        
    }
    return self;
}

- (void)agreeButtonAction:(UIButton *)sender {
    [[NSUserDefaults standardUserDefaults] setObject_TKSafe:@"1" forKey:@"isShowServiceAgreementAndprivacyPolicy"];
    [self removeFromSuperview];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TKAllowServiceAgreementAndprivacyPolicy" object:nil];
}

- (void)disagreeButtonAction:(UIButton *)sender {
    [self removeFromSuperview];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kTLoginPrivacypolicyNotifi" object:nil];
}



#pragma mark - 富文本处理


#pragma mark - Getter
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.layer.cornerRadius = Fit(20);
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}


- (NSArray *)stringArr {
    if (!_stringArr) {
        _stringArr = [NSArray array];
    }
    return _stringArr;
}

- (NSMutableArray *)rangeMarry {
    if (!_rangeMarry) {
        _rangeMarry = [NSMutableArray array];
    }
    return _rangeMarry;
}


- (UILabel *)titleLa {
    if (!_titleLa) {
        _titleLa = [[UILabel alloc] init];
        _titleLa.text = NSLocalizedString(@"Login.userPrivacyAgreementAlterTitle", nil);
        [_titleLa setFont:[UIFont fontWithName:@"Helvetica-BoldOblique" size:20]];
        _titleLa.textColor = [UIColor blackColor];
        _titleLa.backgroundColor = UIColor.clearColor;
        _titleLa.textAlignment = NSTextAlignmentCenter;
        _titleLa.numberOfLines = 0;
    }
    return _titleLa;
}

- (UITextView *)detailsLa {
    if (!_detailsLa) {
        _detailsLa = [[UITextView alloc] init];
        _detailsLa.backgroundColor = UIColor.clearColor;
        _detailsLa.editable = NO;
        _detailsLa.scrollEnabled = YES;
        _detailsLa.selectable = YES;
        _detailsLa.textColor = UIColor.blackColor;
        _detailsLa.delegate = self;
        _detailsLa.attributedText = [self jointAttributrdString];

    }
    return _detailsLa;
}

- (UIButton *)agreeBtn {
    if (!_agreeBtn) {
        _agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_agreeBtn setTitle:NSLocalizedString(@"Login.userPrivacyAgreementButton", nil) forState:UIControlStateNormal];
        _agreeBtn.backgroundColor = [UIColor colorWithHexColorString:@"#3997F8"];
        _agreeBtn.layer.cornerRadius = KButtonHeight /2;
        [_agreeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _agreeBtn.titleLabel.font = [UIFont systemFontOfSize:KBtnFont];
        [_agreeBtn addTarget:self action:@selector(agreeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _agreeBtn;
}

- (UIButton *)disagreeBtn {
    if (!_disagreeBtn) {
        _disagreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_disagreeBtn setTitle:NSLocalizedString(@"Login.userPrivacyDisagreementButton", nil) forState:UIControlStateNormal];
        _disagreeBtn.backgroundColor = UIColor.clearColor;
        _disagreeBtn.layer.cornerRadius = KButtonHeight / 2;
        _disagreeBtn.clipsToBounds = YES;
        _disagreeBtn.layer.borderWidth = 1;
        _disagreeBtn.layer.borderColor = HexRGBA("#000000",0.2).CGColor;
        [_disagreeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _disagreeBtn.titleLabel.font = [UIFont systemFontOfSize:KBtnFont];
        [_disagreeBtn addTarget:self action:@selector(disagreeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _disagreeBtn;
}

- (NSMutableAttributedString *)jointAttributrdString{
    return [self setupAttributeString:NSLocalizedString(@"Login.userPrivacyAgreementAlter", nil) highlightText:NSLocalizedString(@"Login.userPrivacyAgreementAlterRed", nil)];
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
   if ([[URL scheme]isEqualToString:@"privacypolicy"]) {
       [TKPrivacyView showPrivacyViewWithType:PrivacyView_PrivacyPolicy];
        return NO;
    } else if ([[URL scheme] isEqualToString:@"userPrivacyt"]) {
        [TKPrivacyView showPrivacyViewWithType:PrivacyView_UserPolicy];
        return NO;
        
    }
    return YES;
    
}

- (NSMutableAttributedString *)setupAttributeString:(NSString *)text highlightText:(NSString *)highlightText {
    NSRange hightlightTextRange = [text rangeOfString:highlightText];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attributeStr addAttribute:NSForegroundColorAttributeName
                         value:HexRGB("#EB4E3D")
                         range:hightlightTextRange];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16.0f] range:hightlightTextRange];
    [attributeStr addAttribute:NSLinkAttributeName
                                 value:@"privacypolicy://"
                                 range:[[attributeStr string] rangeOfString:NSLocalizedString(@"Login.privacypolicy", nil)]];
    [attributeStr addAttribute:NSLinkAttributeName
                                 value:@"userPrivacyt://"
                                 range:[[attributeStr string] rangeOfString:NSLocalizedString(@"Login.userAgreement", nil)]];
    return attributeStr;
    
}

@end
