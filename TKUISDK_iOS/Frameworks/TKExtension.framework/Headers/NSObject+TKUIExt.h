//
//  NSObject+TKUIExt.h
//  test1
//
//  Created by edy on 2022/8/30.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (TKUIExt)

@end


@interface UILabel (TKext)


#pragma mark - ********** UILable *************

+(UILabel*)LabWithFrame:(CGRect)frame text:(NSString*)text textColor:(UIColor*)textColor textAlign:(NSTextAlignment)textAlign font:(UIFont*)font;

+(UILabel*)LabWithText:(NSString*)text textColor:(UIColor*)textColor textAlign:(NSTextAlignment)textAlign font:(UIFont*)font;

@end

#pragma mark ********** UIButton *************

@interface UIButton (TKext)

+ (UIButton *)ButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font target:(id)target action:(SEL)action;
@end

#pragma mark ********** UIImageView *************
@interface UIImageView (TKext)

+ (UIImageView *)ImageViewWithImageName:(NSString*)imageName frame:(CGRect)frame;
+ (UIImageView *)ImageViewWithImageName:(NSString*)imageName;



@end


#pragma mark ********** UITableView *************
@interface UITableView (TKext)

+ (UITableView *)TableViewWithFrame:(CGRect)frame style:(UITableViewStyle)style backgroundColor:(UIColor *)backgroundColor delegate:(id)delegate separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle;

@end

#pragma mark ********** UITextField *************

@interface UITextField (TKext)

+(UITextField*)TextFieldWithFrame:(CGRect)frame target:(id)target textColor:(UIColor*)textColor textAlign:(NSTextAlignment)textAlign placeHolder:(NSString*)placeHolder clearMode:(UITextFieldViewMode)clearMode returnKey:(UIReturnKeyType)returnKey keyBord:(UIKeyboardType)keyBord;

+(UITextField*)TextFieldWithTarget:(id)target textColor:(UIColor*)textColor textAlign:(NSTextAlignment)textAlign placeHolder:(NSString*)placeHolder clearMode:(UITextFieldViewMode)clearMode returnKey:(UIReturnKeyType)returnKey keyBord:(UIKeyboardType)keyBord;

@end


#pragma mark ********** UIImage *************

@interface UIImage (TKext)

+ (UIImage *) ImageWithColor: (UIColor *) color frame:(CGRect)aFrame;

+ (UIImage*)ImageViewImageName:(NSString*)aImageName ;

@end




NS_ASSUME_NONNULL_END
