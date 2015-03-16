The SuperAwesome SDK for iOS provides various login experiences that your app can use to authenticate someone. This document includes all the information you need to know in order to implement SuperAwesome login in your iOS app.

![alt text](/doc_files/iOSSDK/sign_in.png "Signing In With SuperAwesome")

Sessions and permissions are stored in access tokens, which are cached automatically by the SDK so they are available when a logged in user returns to your app. The SDK provides prebuilt UI components that you can use to log people in and out of your app.

To show the SuperAwesome login page instantiate SALoginViewController.
	
	SALoginViewController *vc = [[SALoginViewController alloc] init];
	vc.delegate = self;
	[self presentViewController:vc animated:YES completion:nil];

By implementing the SALoginViewControllerDelegate protocol you can get notified about the result of the authentication procedure.

	@protocol SALoginViewControllerDelegate <UINavigationControllerDelegate>
	@optional
	- (void)loginViewController:(SALoginViewController *)loginVC didSucceedWithToken:(NSString *)token;
	- (void)loginViewController:(SALoginViewController *)loginVC didFailWithError:(NSString *)error;
	@end
