
@protocol TakeNotePresenterDelegate
-(void)updateView;
-(void)updateImageView;
@end

@protocol DashboardCollectionViewDelegate

@end
@protocol SetReminderDelegate
-(void)setReminderData:(NSString*)date time:(NSString*)time;
@end

