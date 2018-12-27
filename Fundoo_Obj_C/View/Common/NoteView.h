
#import <UIKit/UIKit.h>

@interface NoteView : UIView
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITextView *titleTextView;
@property (strong, nonatomic) IBOutlet UITextView *noteTextView;

@property (strong, nonatomic) IBOutlet UILabel *reminderTextLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageViewHConstraints;
@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *titleViewHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *noteViewHeightConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *reminderViewHeightC;

@end
