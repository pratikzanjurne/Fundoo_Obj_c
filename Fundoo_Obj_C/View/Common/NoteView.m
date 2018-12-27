
#import "NoteView.h"

@implementation NoteView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commitInit];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commitInit];
    }
    return self;
}
-(void)commitInit{
    [NSBundle.mainBundle loadNibNamed:@"NoteView" owner:self options:nil];
    [self addSubview:self.containerView];
    [self.containerView setFrame:self.bounds];
    [self.containerView setAutoresizingMask: UIViewAutoresizingFlexibleHeight];
    [self.containerView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
}
@end
