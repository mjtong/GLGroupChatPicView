//
//  MultiImageView.m
//  GLGroupChatPicView
//
//  Created by Gautam Lodhiya on 30/04/14.
//  Copyright (c) 2014 Gautam Lodhiya. All rights reserved.
//

#import "GLGroupChatPicView.h"
#import "UIImageView+WebCache.h"

@interface GLGroupChatPicView()
@property (nonatomic, assign) NSUInteger totalCount;

@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) UIImageView *imageLayer1;
@property (nonatomic, strong) UIImageView *imageLayer2;
@property (nonatomic, strong) UIImageView *imageLayer3;
@property (nonatomic, strong) UIImageView *imageLayer4;

@property (nonatomic, strong) UIColor *borderColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat borderWidth UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *shadowColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGSize shadowOffset UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat shadowBlur UI_APPEARANCE_SELECTOR;
@end

@implementation GLGroupChatPicView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}


#pragma mark -
#pragma mark - Public helpers

- (void)addImage:(NSString *)image withInitials:(NSString *)initials
{
    if (self.images.count < 4) {
        if (self.images.count == 3 && self.totalEntries > 4) {
            NSString *totalStr = [NSString stringWithFormat:@"%ld", self.totalEntries];
            if (totalStr) {
//                [self addInitials:totalStr];
            }
            return;
        }
        
        
        self.totalCount++;
        
        if (image) {
            [self.images addObject:image];
            
        } else{
            [self.images addObject:@""];
        }
        
    } else {
        if (self.totalEntries > 0) {
            NSString *totalStr = [NSString stringWithFormat:@"%ld", self.totalEntries];
            if (totalStr) {
//                [self.images removeLastObject];
//                [self addInitials:totalStr];
            }
            
        } else {
            if (self.totalCount > 4) {
                self.totalCount++;
                NSString *totalStr = [NSString stringWithFormat:@"%ld", self.totalCount];
                if (totalStr) {
//                    [self.images removeLastObject];
//                    [self addInitials:totalStr];
                }
            }
        }
    }
}



//- (void)addInitials:(NSString *)initials
//{
//    if (initials && initials.length) {
//        CGFloat width = 0;
//        CGSize size = self.frame.size;
//        
//        if (self.totalCount == 0) {
//            width = floorf(size.width);
//        } else if (self.totalCount == 1) {
//            width = floorf(size.width * 0.7);
//        } else if (self.totalCount == 2) {
//            width = floorf(size.width * 0.5);
//        } else if (self.totalCount > 2) {
//            width = floorf(size.width * 0.5);
//        }
//        
//        CGFloat fontSize = initials.length == 1 ? width * 0.6 : width * 0.5;
//        UIImage *image = [self imageFromText:initials withCanvasSize:CGSizeMake(width, width) andFontSize:fontSize];
//        if (image) {
//            [self.images addObject:image];
//        }
//    }
//}

- (void)reset
{
    self.totalEntries = 0;
    self.totalCount = 0;
    [self.images removeAllObjects];
    [self resetLayers];
}

- (void)updateLayout
{
    [self resetLayers];
    
    if (self.images) {
        CGFloat width = 0;
        CGSize size = self.frame.size;
        
        if (self.images.count == 1) {
            width = floorf(size.width);
            [[SDImageCache sharedImageCache] queryDiskCacheForKey:((NSString *)self.images[0]) done:^(UIImage *image, SDImageCacheType cacheType) {
                if (image!=nil){
                    
                    [self.imageLayer1 setImage:image];
                }else{
//                    NSLog(@"%@", self.images[0]);
                    
                    NSString *imgStr = [[NSString alloc] init];
                    @try {
                        //NSLog(@"SDImageCache self.images[0] try");
                        imgStr = ((NSString *)self.images[0]);
                    }
                    @catch (NSException *exception) {
                        NSLog(@"SDImageCache self.images[0] catch exception: %@", exception);
                    }
                    @finally {
                        //NSLog(@"SDImageCache self.images[0] finally");
                        [self.imageLayer1 sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"profile-pic.png"] options:SDWebImageRefreshCached];
                    }
                    
                    
                    [self.imageLayer1 sd_setImageWithURL:[NSURL URLWithString:((NSString *)self.images[0])] placeholderImage:[UIImage imageNamed:@"profile-pic.png"] options:SDWebImageRefreshCached];
                }
            }];
            self.imageLayer1.frame = CGRectMake(0, 0, width, width);
            self.imageLayer1.hidden = NO;
            
        } else if (self.images.count == 2) {
            width = floorf(size.width * 0.7);
            [[SDImageCache sharedImageCache] queryDiskCacheForKey:((NSString *)self.images[0]) done:^(UIImage *image, SDImageCacheType cacheType) {
                if (image!=nil){
                    [self.imageLayer1 setImage:image];
                }else{
                    NSString *imgStr = [[NSString alloc] init];
                    @try {
                        //NSLog(@"SDImageCache self.images[0] try");
                        imgStr = ((NSString *)self.images[0]);
                    }
                    @catch (NSException *exception) {
                        NSLog(@"SDImageCache self.images[0] catch exception: %@", exception);
                    }
                    @finally {
                        //NSLog(@"SDImageCache self.images[0] finally");
                        [self.imageLayer1 sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"profile-pic.png"] options:SDWebImageRefreshCached];
                    }
                
//                    [self.imageLayer1 sd_setImageWithURL:[NSURL URLWithString:((NSString *)self.images[0])] placeholderImage:[UIImage imageNamed:@"profile-pic.png"] options:SDWebImageRefreshCached];
                }
            }];
            self.imageLayer1.frame = CGRectMake(0, 0, width-1, width*2);
            self.imageLayer1.layer.zPosition = width* 0.5;
            self.imageLayer1.hidden = NO;
            
            [[SDImageCache sharedImageCache] queryDiskCacheForKey:((NSString *)self.images[1]) done:^(UIImage *image, SDImageCacheType cacheType) {
                if (image!=nil){
                    [self.imageLayer2 setImage:image];
                }else{
                    NSString *imgStr = [[NSString alloc] init];
                    @try {
                        //NSLog(@"SDImageCache self.images[1] try");
                        imgStr = ((NSString *)self.images[1]);
                    }
                    @catch (NSException *exception) {
                        NSLog(@"SDImageCache self.images[1] catch exception: %@", exception);
                    }
                    @finally {
                        //NSLog(@"SDImageCache self.images[1] finally");
                        [self.imageLayer2 sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"profile-pic.png"] options:SDWebImageRefreshCached];
                    }
                    
//                    [self.imageLayer2 sd_setImageWithURL:[NSURL URLWithString:((NSString *)self.images[1])] placeholderImage:[UIImage imageNamed:@"profile-pic.png"] options:SDWebImageRefreshCached];
                }
            }];
            self.imageLayer2.frame = CGRectMake((size.width - width)+1, 0, width-1, width*2);
            self.imageLayer2.layer.zPosition = 0;
            self.imageLayer2.hidden = NO;
            
        } else if (self.images.count == 3) {
            width = floorf(size.width * 0.5);

            self.imageLayer1.frame = CGRectMake(0, 0, width-1, width*2);
            self.imageLayer1.hidden = NO;
            self.imageLayer1.contentMode = UIViewContentModeScaleAspectFill;
            [[SDImageCache sharedImageCache] queryDiskCacheForKey:((NSString *)self.images[0]) done:^(UIImage *image, SDImageCacheType cacheType) {
                if (image!=nil){
                    [self.imageLayer1 setImage:image];
                }else{
                    
                    //NSLog(@"self.images: %@", self.images);
                    NSString *imgStr = [[NSString alloc] init];
                    @try {
                        //NSLog(@"SDImageCache self.images[0] try");
                        imgStr = ((NSString *)self.images[0]);
                    }
                    @catch (NSException *exception) {
                        NSLog(@"SDImageCache self.images[0] catch exception: %@", exception);
                    }
                    @finally {
                        //NSLog(@"SDImageCache self.images[0] finally");
                        [self.imageLayer1 sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"profile-pic.png"] options:SDWebImageRefreshCached];
                    }
                    
                    
//                    [self.imageLayer1 sd_setImageWithURL:[NSURL URLWithString:((NSString *)self.images[0])] placeholderImage:[UIImage imageNamed:@"profile-pic.png"] options:SDWebImageRefreshCached];
                }
            }];
            [[SDImageCache sharedImageCache] queryDiskCacheForKey:((NSString *)self.images[1]) done:^(UIImage *image, SDImageCacheType cacheType) {
                if (image!=nil){
                    [self.imageLayer2 setImage:image];
                }else{
                    //NSLog(@"self.images: %@", self.images);
                    NSString *imgStr = [[NSString alloc] init];
                    @try {
//                       NSLog(@"SDImageCache self.images[1] try");
                        imgStr = ((NSString *)self.images[1]);
                    }
                    @catch (NSException *exception) {
                        NSLog(@"SDImageCache self.images[1] catch exception: %@", exception);
                    }
                    @finally {
                        //NSLog(@"SDImageCache self.images[1] finally");
                        [self.imageLayer2 sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"profile-pic.png"] options:SDWebImageRefreshCached];
                    }

                    
//                    [self.imageLayer2 sd_setImageWithURL:[NSURL URLWithString:((NSString *)self.images[1])] placeholderImage:[UIImage imageNamed:@"profile-pic.png"] options:SDWebImageRefreshCached];
                }
            }];

            self.imageLayer2.frame = CGRectMake((size.width - width)+1, 0, width, width-1);
            self.imageLayer2.hidden = NO;
            [[SDImageCache sharedImageCache] queryDiskCacheForKey:((NSString *)self.images[2]) done:^(UIImage *image, SDImageCacheType cacheType) {
                if (image!=nil){
                    [self.imageLayer3 setImage:image];
                }else{
                    NSString *imgStr = [[NSString alloc] init];
                    @try {
                        //                       NSLog(@"SDImageCache self.images[1] try");
                        imgStr = ((NSString *)self.images[2]);
                    }
                    @catch (NSException *exception) {
                        NSLog(@"SDImageCache self.images[2] catch exception: %@", exception);
                    }
                    @finally {
                        //NSLog(@"SDImageCache self.images[2] finally");
                        [self.imageLayer3 sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"profile-pic.png"] options:SDWebImageRefreshCached];
                    }
                    
                   
                }
            }];

            self.imageLayer3.frame = CGRectMake((size.width - width)+1, (size.height - width)+1, width, width);
            self.imageLayer3.hidden = NO;
            
        } else if (self.images.count > 3) {
//             NSLog(@"self.images 0 count: %d and contents: %@", [self.images count],self.images);
            width = floorf(size.width * 0.5);
            
            [[SDImageCache sharedImageCache] queryDiskCacheForKey:((NSString *)self.images[0]) done:^(UIImage *image, SDImageCacheType cacheType) {
                if (image!=nil){
                    [self.imageLayer1 setImage:image];
                }else{
//                    NSLog(@"self.images: %@", self.images);
                    NSString *imgStr = [[NSString alloc] init];
                    @try {
//                        NSLog(@"SDImageCache self.images[0] try");
                        imgStr = ((NSString *)self.images[0]);
                    }
                    @catch (NSException *exception) {
                        NSLog(@"SDImageCache self.images[0] catch exception: %@", exception);
                    }
                    @finally {
                        NSLog(@"SDImageCache self.images[0] finally");
                        [self.imageLayer1 sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"profile-pic.png"] options:SDWebImageRefreshCached];
                    }

//                    [self.imageLayer1 sd_setImageWithURL:[NSURL URLWithString:((NSString *)self.images[0])] placeholderImage:[UIImage imageNamed:@"profile-pic.png"] options:SDWebImageRefreshCached];
                }
            }];
            self.imageLayer1.frame = CGRectMake(0, 0, width-1, width-1);
            self.imageLayer1.hidden = NO;
            
//             NSLog(@"self.images 1 count: %d and contents: %@", [self.images count],self.images);
            
            [[SDImageCache sharedImageCache] queryDiskCacheForKey:((NSString *)self.images[1]) done:^(UIImage *image, SDImageCacheType cacheType) {
                if (image!=nil){
                    [self.imageLayer2 setImage:image];
                }else{
                    //'NSRangeException', reason: '*** -[__NSArrayM objectAtIndex:]: index 1 beyond bounds [0 .. 0]'
//                    NSLog(@"self.images: %@", self.images);
                    NSString *imgStr = [[NSString alloc] init];
                    @try {
//                        NSLog(@"SDImageCache self.images[1] try");
                        imgStr = ((NSString *)self.images[1]);
                      }
                    @catch (NSException *exception) {
                        NSLog(@"SDImageCache self.images[1] catch exception: %@", exception);
                    }
                    @finally {
                        NSLog(@"SDImageCache self.images[1] finally");
                        [self.imageLayer2 sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"profile-pic.png"] options:SDWebImageRefreshCached];
                    }

//

                }
            }];

            self.imageLayer2.frame = CGRectMake((size.width - width)+1, 0, width, width-1);
            self.imageLayer2.hidden = NO;
            [[SDImageCache sharedImageCache] queryDiskCacheForKey:((NSString *)self.images[2]) done:^(UIImage *image, SDImageCacheType cacheType) {
                if (image!=nil){
                    [self.imageLayer3 setImage:image];
                }else{
//                    NSLog(@"self.images: %@", self.images);
                    NSString *imgStr = [[NSString alloc] init];
                    @try {
//                        NSLog(@"SDImageCache self.images[2] try");
                        imgStr = ((NSString *)self.images[2]);
                    }
                    @catch (NSException *exception) {
                        NSLog(@"SDImageCache self.images[2] catch exception: %@", exception);
                    }
                    @finally {
                        NSLog(@"SDImageCache self.images[2] finally");
                        [self.imageLayer3 sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"profile-pic.png"] options:SDWebImageRefreshCached];
                    }
                    
                    
//                    [self.imageLayer3 sd_setImageWithURL:[NSURL URLWithString:((NSString *)self.images[2])] placeholderImage:[UIImage imageNamed:@"profile-pic.png"] options:SDWebImageRefreshCached];
                }
            }];
            self.imageLayer3.frame = CGRectMake(0, (size.height - width)+1, width-1, width);
            self.imageLayer3.hidden = NO;
            [[SDImageCache sharedImageCache] queryDiskCacheForKey:((NSString *)self.images[3]) done:^(UIImage *image, SDImageCacheType cacheType) {
                if (image!=nil){
                    [self.imageLayer4 setImage:image];
                }else{
//                    NSLog(@"self.images: %@", self.images);
                    NSString *imgStr = [[NSString alloc] init];
                    @try {
//                        NSLog(@"SDImageCache self.images[3] try");
                        imgStr = ((NSString *)self.images[3]);
                    }
                    @catch (NSException *exception) {
                        NSLog(@"SDImageCache self.images[3] catch exception: %@", exception);
                    }
                    @finally {
                        NSLog(@"SDImageCache self.images[3] finally");
                        [self.imageLayer4 sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"profile-pic.png"] options:SDWebImageRefreshCached];
                    }
                    
                    
//                    [self.imageLayer4 sd_setImageWithURL:[NSURL URLWithString:((NSString *)self.images[3])] placeholderImage:[UIImage imageNamed:@"profile-pic.png"] options:SDWebImageRefreshCached];
                }
            }];
            self.imageLayer4.frame = CGRectMake((size.width - width)+1, (size.height - width)+1, width, width);
            self.imageLayer4.hidden = NO;
        }
    }
    
    self.layer.cornerRadius = floorf(self.frame.size.width) * 0.5;
    self.layer.masksToBounds = YES;
}


#pragma mark -
#pragma mark - Private helpers

- (void)setup
{
    self.borderColor = [UIColor whiteColor];
    self.borderWidth = 1.f;
//    self.shadowColor = [UIColor colorWithRed:0.25f green:0.25f blue:0.25f alpha:.75f];
    self.shadowOffset = CGSizeMake(0, 0);
    self.shadowBlur = 2.f;
    self.backgroundColor = [UIColor clearColor];
    
    self.images = [@[] mutableCopy];
}

- (void)resetLayers
{
    self.imageLayer1.hidden = YES;
    self.imageLayer2.hidden = YES;
    self.imageLayer3.hidden = YES;
    self.imageLayer4.hidden = YES;
    
    self.imageLayer1.layer.zPosition = 0;
    self.imageLayer2.layer.zPosition = 0;
    self.imageLayer3.layer.zPosition = 0;
    self.imageLayer4.layer.zPosition = 0;
}

- (UIImageView *)getImageLayer
{
    UIImageView *mImageLayer = [[UIImageView alloc] init];
    mImageLayer.layer.masksToBounds = YES;
    return mImageLayer;
}

- (UIImage *)imageFromText:(NSString *)text withCanvasSize:(CGSize)canvasSize andFontSize:(CGFloat)fontSize
{
    if (UIGraphicsBeginImageContextWithOptions) {
        CGFloat imageScale = 0.0f;
        UIGraphicsBeginImageContextWithOptions(canvasSize, NO, imageScale);
    }
    else {
        UIGraphicsBeginImageContext(self.frame.size);
    }
    
    
    UIColor *color = [self randomColor];
    //UIColor *color = [UIColor colorWithRed:203 green:205 blue:207 alpha:1];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGRect rect = CGRectMake(0.0f, 0.0f, canvasSize.width, canvasSize.height);
    CGContextFillRect(context, rect);
    
    
    // draw in context, you can use also drawInRect:withFont:
    UIFont *font = [UIFont boldSystemFontOfSize:fontSize];//[UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:fontSize];
    NSDictionary *attributesNew = @{NSFontAttributeName: font, NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    // transfer image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}


#pragma mark -
#pragma mark - Accessors

- (UIImageView *)imageLayer1
{
    if (!_imageLayer1) {
        _imageLayer1 = [self getImageLayer];
        _imageLayer1.hidden = YES;
         [self addSubview:_imageLayer1];
    }
    return _imageLayer1;
}

- (UIImageView *)imageLayer2
{
    if (!_imageLayer2) {
        _imageLayer2 = [self getImageLayer];
        _imageLayer2.hidden = YES;
         [self addSubview:_imageLayer2];
    }
    return _imageLayer2;
}

- (UIImageView *)imageLayer3
{
    if (!_imageLayer3) {
        _imageLayer3 = [self getImageLayer];
        _imageLayer3.hidden = YES;
         [self addSubview:_imageLayer3];
    }
    return _imageLayer3;
}

- (UIImageView *)imageLayer4
{
    if (!_imageLayer4) {
        _imageLayer4 = [self getImageLayer];
        _imageLayer4.hidden = YES;
        [self addSubview:_imageLayer4];
    }
    return _imageLayer4;
}

@end
