//
//  TKYYText.h
//  TKYYText <https://github.com/ibireme/TKYYText>
//
//  Created by ibireme on 15/2/25.
//  Copyright (c) 2015 ibireme.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import <UIKit/UIKit.h>

#if __has_include(<TKYYText/TKYYText.h>)
FOUNDATION_EXPORT double TKYYTextVersionNumber;
FOUNDATION_EXPORT const unsigned char TKYYTextVersionString[];
#import <TKYYText/TKYYLabel.h>
#import <TKYYText/TKYYTextView.h>
#import <TKYYText/TKYYTextAttribute.h>
#import <TKYYText/TKYYTextArchiver.h>
#import <TKYYText/TKYYTextParser.h>
#import <TKYYText/TKYYTextRunDelegate.h>
#import <TKYYText/TKYYTextRubyAnnotation.h>
#import <TKYYText/TKYYTextLayout.h>
#import <TKYYText/TKYYTextLine.h>
#import <TKYYText/TKYYTextInput.h>
#import <TKYYText/TKYYTextDebugOption.h>
#import <TKYYText/TKYYTextKeyboardManager.h>
#import <TKYYText/TKYYTextUtilities.h>
#import <TKYYText/NSAttributedString+TKYYText.h>
#import <TKYYText/NSParagraphStyle+TKYYText.h>
#import <TKYYText/UIPasteboard+TKYYText.h>
#else
#import "TKYYLabel.h"
#import "TKYYTextView.h"
#import "TKYYTextAttribute.h"
#import "TKYYTextArchiver.h"
#import "TKYYTextParser.h"
#import "TKYYTextRunDelegate.h"
#import "TKYYTextRubyAnnotation.h"
#import "TKYYTextLayout.h"
#import "TKYYTextLine.h"
#import "TKYYTextInput.h"
#import "TKYYTextDebugOption.h"
#import "TKYYTextKeyboardManager.h"
#import "TKYYTextUtilities.h"
#import "NSAttributedString+TKYYText.h"
#import "NSParagraphStyle+TKYYText.h"
#import "UIPasteboard+TKYYText.h"
#import "TKYYTextAttachment+TKEmoji.h"
#import "TKYYTextAttribute.h"
#endif
