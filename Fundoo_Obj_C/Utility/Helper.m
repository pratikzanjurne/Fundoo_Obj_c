#import "Helper.h"

@implementation Helper
+(id)sharedInstance{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc]init];
    });
    return sharedInstance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
-(CGFloat)getImageAspectRatio:(UIImage *)image{
    CGFloat ratio = image.size.width/image.size.height;
    return ratio;
}
-(void)setReminder:(CDNoteModel*)note reminderDate:(NSString*)date reminderTime:(NSString*)time completion:(void(^)(BOOL))completion{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    [content setBody:note.note];
    [content setTitle:note.note_title];
    [content setSound:[UNNotificationSound defaultSound]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd-yyyy h:mm a"];
    NSDate *convertedDate = [formatter dateFromString:[NSString stringWithFormat:@"%@ %@",date,time]];
    NSDateComponents *triggerDate = [[NSCalendar currentCalendar]components: NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:convertedDate];
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:triggerDate repeats:true];
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:note.user_id content:content trigger:trigger];
    [AppDelegate.center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Something went wrong");
        }else{
            NSLog(@"Notification added");
        }
    }];
}
@end
