#import <UIKit/UIKit.h>
#import "CDNoteModel.h"
#import "APINoteModel.h"

@interface NoteCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageViewheightConstraints;
@property (strong, nonatomic) IBOutlet UILabel *noteLabel;
@property (strong, nonatomic) IBOutlet UIImageView *pinImageView;
@property (strong, nonatomic) IBOutlet UILabel *reminderLabel;
-(void)setData:(APINoteModel*)note;
@end
