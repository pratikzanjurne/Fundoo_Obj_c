#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CDNoteModel.h"
#import <UserNotifications/UserNotifications.h>
#import "AppDelegate.h"

@interface Helper : NSObject
+(id)sharedInstance;
-(CGFloat)getImageAspectRatio:(UIImage*)image;
-(void)setReminder:(CDNoteModel*)note reminderDate:(NSString*)date reminderTime:(NSString*)time completion:(void(^)(BOOL))completion;
@end
