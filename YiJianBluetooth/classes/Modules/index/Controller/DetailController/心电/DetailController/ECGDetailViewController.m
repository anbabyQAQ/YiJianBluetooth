//
//  ECGDetailViewController.m
//  YiJianBluetooth
//
//  Created by tyl on 16/8/11.
//  Copyright © 2016年 LEI. All rights reserved.
//

#import "ECGDetailViewController.h"
#import "PersonalInformationViewController.h"
#import "ChooseUser.h"
#import "User.h"
#import "UsersDao.h"
@interface ECGDetailViewController ()<UIScrollViewDelegate,chooseUserDelegate>

@property(nonatomic, strong)UIScrollView *scrollerView;


@property (nonatomic, strong) UILabel  *temp_lab;
@property (nonatomic, strong) UIButton *startTest_btn;

@property (nonatomic, strong) UILabel *stateLabel;//状态
@property (nonatomic, strong) UILabel *electricityLabel;//电量

@property (nonatomic, strong) NSMutableArray *users;

@property (nonatomic, strong) UIImageView *pictureImageView;


@property (nonatomic, strong) UILabel *HRLabel;
@property (nonatomic, strong) UILabel *RRMAXLabel;
@property (nonatomic, strong) UILabel *RRMINLabel;
@property (nonatomic, strong) UILabel *HRVLabel;
@property (nonatomic, strong) UILabel *MoodLabel;

@end

@implementation ECGDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H-NAVIGATION_HEIGHT-80)];
    self.scrollerView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollerView];
    
     [self initTempLayout];
    [self initLeftBarButtonItem];
    

}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self initwithScroll];
}
- (void)initwithScroll{
    
    _users = [NSMutableArray arrayWithArray:[UsersDao getAllUsers]];
    
    ChooseUser *view = [[ChooseUser alloc]initWithFrame:CGRectMake(0, self.MoodLabel.frame.origin.y + 40, SCR_W, 80)];
    view.user_delegate =self;
    [view setWithUserInfo:_users];
    [self.scrollerView addSubview:view];
    
}

-(void)initTempLayout{
    self.temp_lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 150, 20)];
    [self addUILabel:self.temp_lab labelString:@"心电"];
    
    self.stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCR_W - 115, 20, 100, 20)];
    self.stateLabel.textAlignment=NSTextAlignmentRight;
    self.stateLabel.text=@"状态";
    self.stateLabel.font = [UIFont systemFontOfSize:text_size_between_normalAndSmall];
    self.stateLabel.textColor = [UIColor blackColor];
    [self.scrollerView addSubview: self.stateLabel];
    
    
    self.electricityLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCR_W/2 - 75, 20, 150, 20)];
    self.electricityLabel.textAlignment=NSTextAlignmentCenter;
    self.electricityLabel.text=@"仪器用电量";
    self.electricityLabel.font = [UIFont systemFontOfSize:text_size_between_normalAndSmall];
    self.electricityLabel.textColor = [UIColor blackColor];
    [self.scrollerView addSubview: self.electricityLabel];
    
    
    self.pictureImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 60, SCR_W - 40, SCR_H/667 *150)];
    self.pictureImageView.image = [UIImage imageNamed:@"Yosemite04.jpg"];
    [self.scrollerView addSubview:self.pictureImageView];
    
    
    self.HRLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.pictureImageView.frame.origin.y + self.pictureImageView.frame.size.height + 20, 150, 20)];
    [self addUILabel:self.HRLabel labelString:@"HR:"];
   
    self.RRMAXLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.HRLabel.frame.origin.y + 40, 150, 20)];
    [self addUILabel:self.RRMAXLabel labelString:@"RRMAX:"];
    
     self.RRMINLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.RRMAXLabel.frame.origin.y + 40, 150, 20)];
    [self addUILabel:self.RRMINLabel labelString:@"RRMIN:"];
    
     self.HRVLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.RRMINLabel.frame.origin.y + 40, 150, 20)];
    [self addUILabel:self.HRVLabel labelString:@"HRV:"];
    
     self.MoodLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.HRVLabel.frame.origin.y + 40, 150, 20)];
    [self addUILabel:self.MoodLabel labelString:@"Mood:"];
    

    _startTest_btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _startTest_btn.frame = CGRectMake(20, SCR_H-NAVIGATION_HEIGHT-70, SCR_W-40, 50);
    [_startTest_btn addTarget:self action:@selector(clickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    _startTest_btn.backgroundColor = UIColorFromRGB(0xc62828);
    [_startTest_btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [_startTest_btn setTitle:@"保存记录" forState:(UIControlStateNormal)];
    self.startTest_btn.layer.masksToBounds = YES;
    self.startTest_btn.layer.cornerRadius = 6.0;
    self.startTest_btn.layer.borderWidth = 1.0;
    self.startTest_btn.layer.borderColor = [[UIColor whiteColor] CGColor];
    [self.view addSubview:_startTest_btn];
    
    
    [self.scrollerView setContentSize:CGSizeMake(SCR_W, self.MoodLabel.frame.origin.y + 120)];
}

-(void)addUILabel:(UILabel *)label labelString:(NSString *)string{
    
    label.textAlignment=NSTextAlignmentLeft;
    label.text=string;
    label.font = [UIFont systemFontOfSize:text_size_between_normalAndSmall];
    label.textColor = [UIColor blackColor];
    [self.scrollerView addSubview: label];
}

-(void)clickBtn:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)callBaceAddUser{
    
    PersonalInformationViewController *pserson  = [[PersonalInformationViewController alloc] init];
    [self.navigationController pushViewController:pserson animated:YES];
}
- (NSMutableArray *)users {
    if (_users == nil) {
        _users = [[NSMutableArray alloc]init];
    }
    return _users;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
