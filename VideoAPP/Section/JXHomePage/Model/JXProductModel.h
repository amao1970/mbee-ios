//
//  JXProductModel.h
//  MovieApp
//
//  Created by admxjx on 2019/4/19.
//

#import "JXJSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JXProductModel : JXJSONModel

//"id": 73,
//"title": "《痴痴女人心》送给天下女人们的一首情歌",
//"image": "http://demo.starapp.cc/uploads/videoimg/20181112/6c9d309d21659d2a83a268b40f20461e.jpg",
//"score": "",
//"cate": 3,
//"kindID": 3
@property (nonatomic, strong) NSString<Optional> *id;
@property (nonatomic, strong) NSString<Optional> *title;
@property (nonatomic, strong) NSString<Optional> *image;
@property (nonatomic, strong) NSString<Optional> *score;
@property (nonatomic, strong) NSString<Optional> *cate;
@property (nonatomic, strong) NSString<Optional> *kindID;


@end

NS_ASSUME_NONNULL_END
