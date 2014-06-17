//
//  AddArticleViewController.m
//  CheerUp_V1
//
//  Created by huang huijing on 6/13/14.
//  Copyright (c) 2014 huang huijing. All rights reserved.
//

#import "AddArticleViewController.h"

@interface AddArticleViewController ()

@end

@implementation AddArticleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addImage:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self
                                                    cancelButtonTitle:@"取消" destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从手机相册选择", nil];
    [actionSheet showInView:self.view];
}

#pragma mark - action sheet
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self takePhoto];
            break;
        case 1:
            [self choosePhoto];
            break;
        default:
            break;
    }
}

-(void)takePhoto{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *contoller = [[UIImagePickerController alloc] init];
        contoller.sourceType = UIImagePickerControllerSourceTypeCamera;
        contoller.allowsEditing = NO;
        contoller.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        contoller.delegate = self;
        [self presentViewController:contoller animated:YES completion:nil];
    }
}

-(void)choosePhoto{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *contoller = [[UIImagePickerController alloc] init];
        contoller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        contoller.allowsEditing = NO;
        contoller.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        contoller.delegate = self;
        [self presentViewController:contoller animated:YES completion:nil];
    }
}

#pragma mark - image picker
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    self.image.image = [info valueForKey:UIImagePickerControllerOriginalImage];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    // create a nsobject
    Article * article = [NSEntityDescription insertNewObjectForEntityForName:@"Article" inManagedObjectContext:self.managedObjectContext];
    article.content = self.content.text;
    article.tag = @"正能量";
    article.image = UIImagePNGRepresentation(self.image.image);
    article.title = self.titleField.text;
    
    // save
    NSError *err = nil;
    if (![self.managedObjectContext save:&err]) {
        NSLog(@"Can't save! %@ %@", err, [err localizedDescription]);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - touches event
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
