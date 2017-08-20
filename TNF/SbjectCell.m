//
//  SbjectCell.m
//  TNF
//
//  Created by 李立 on 16/1/9.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "SbjectCell.h"
#import "MessageFrame.h"
#import "Message.h"
#import "MessageCell.h"
@implementation SbjectCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //1.创建子视图
        [self initCell];
        _allMessagesFrame = [NSMutableArray array];
        
    }
    return self;
}

- (void)initCell
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];


}

#pragma mark ------UITableView Delegate ----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allMessagesFrame.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // 设置数据
    cell.messageFrame = _allMessagesFrame[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   return [_allMessagesFrame[indexPath.row] cellHeight];
}

- (void)setDataList:(NSArray *)dataList
{
    _dataList = dataList;
    NSMutableArray *array1 = [NSMutableArray array];
    for (int i = 0; i < self.dataList.count; i++) {
        MessageFrame *messageFrame = [[MessageFrame alloc] init];
        Message *message = self.dataList[i];
        messageFrame.message = message;
        [array1 addObject:messageFrame];
        
        
    }
    _allMessagesFrame = array1;
    if (_allMessagesFrame.count != 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_allMessagesFrame.count - 1 inSection:0];
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
   
    

    [_tableView reloadData];


}

- (void)setIsSelf:(BOOL)isSelf
{
    _isSelf = isSelf;

    view = [[UIView alloc] initWithFrame:CGRectMake(0, 200, kScreenWidth, 40)];
    view.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view];
    
    senderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [senderButton setImage:[UIImage imageNamed:@"语音回复按钮"] forState:UIControlStateNormal];
    [senderButton addTarget:self action:@selector(buttonAC:) forControlEvents:UIControlEventTouchUpInside];
    senderButton.frame = CGRectMake(10, 2, 44.5, 36);
    [view addSubview:senderButton];
    
    //设置textField输入起始位置
    _messageField = [[UITextView alloc] initWithFrame:CGRectMake(senderButton.right  + 10,5 , kScreenWidth - 74.5, 30)];
    _messageField.layer.borderColor  = [MyColor colorWithHexString:@"#dcdcdc"].CGColor; //要设置的颜色
    _messageField.font = [UIFont systemFontOfSize:14];
    _messageField.layer.borderWidth = .5; //要设置的描边宽

    _messageField.layer.masksToBounds = YES;
    _messageField.layer.cornerRadius = 2;
    _messageField.backgroundColor = [UIColor whiteColor];
    _messageField.bounces = NO;
    //    _messageField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    //    _messageField.leftViewMode = UITextFieldViewModeAlways;
    
    _messageField.delegate = self;
    _messageField.returnKeyType = UIReturnKeySend;
    [view addSubview:_messageField];


}

- (void)buttonAC:(UIButton *)sender
{
    [self endEditing:YES];
    recode = [[RecoderView alloc] initWithTimes:60];
    recode.delegate = self;
    [recode show];


}

#pragma mark ------------recoderViewDelegate-------
- (void)recordfabuMp3Data:(NSData *)data withTime:(NSString *)time
{
    if ([time intValue] < 3) {
        
        //录音时长太短，请重新录制；
        [MBProgressHUD showError:@"录音时长太短，请重新录制；" toView:[UIApplication sharedApplication].keyWindow];
        [recode hiddens];
        return;
    }
    
    [WXDataService postMP3:Url_uploadImgApp params:nil fileData:data finishBlock:^(id result) {
        
        if(result){
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
                [recode hiddens];
                return;
                
            }
            NSDictionary *dic = result[@"result"];
            [self loadMp3:dic[@"path"]];
            
        }
        
        
    } errorBlock:^(NSError *error) {
        
        [recode hiddens];
    }];
    
}

- (void)loadMp3:(NSString *)path
{
    
    NSString *useid = [UserDefaults objectForKey:Userid];
    NSDictionary *params = @{@"member_id":useid,@"id":self.ID,@"mp3":path};
    [WXDataService requestAFWithURL:Url_mp3CommentSave params:params httpMethod:@"POST" finishBlock:^(id result) {
        if(result){
            NSLog(@"ggggg%@",result);
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [recode hiddens];
                [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
                
                return;
            }
            
            [self addMessageWithMessage:result[@"result"]];
            [recode hiddens];
            
        }
    } errorBlock:^(NSError *error) {
        
        [recode hiddens];
        NSLog(@"%@",error);
    }];

}

#pragma mark 给数据源增加内容
- (void)addMessageWithMessage:(NSDictionary *)dic
{
    Message *addmessage =  [[Message alloc] init];
    addmessage.dict = dic;

    
    MessageFrame *messageFrame = [[MessageFrame alloc] init];
    messageFrame.message = addmessage;
    
    [_allMessagesFrame addObject:messageFrame];
    [_tableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_allMessagesFrame.count - 1 inSection:0];
    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    
}

- (void)sendMessage
{
    if (_messageField.text.length == 0) {
        return;
    }
    NSString *useid = [UserDefaults objectForKey:Userid];
    NSDictionary *params = @{@"member_id":useid,@"id":self.ID,@"content":_messageField.text};
    [WXDataService requestAFWithURL:Url_mp3CommentSave params:params httpMethod:@"POST" finishBlock:^(id result) {
        if(result){
            NSLog(@"ggggg%@",result);
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
                return;
            }
            
            [self addMessageWithMessage:result[@"result"]];
            _messageField.text = @"";
            
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];


}

#pragma mark - 文本框代理方法
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        if(textView.text.length == 0){
        
            return NO;
        }
        [self sendMessage];
        return NO;
    }
    
    return YES;
    
}

#pragma mark - 代理方法

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self endEditing:YES];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
