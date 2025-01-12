import 'package:chat_application/core/constant/routes.dart';
import 'package:chat_application/view/Screens/auth/language_screen.dart';
import 'package:chat_application/bindings/initial_bindings.dart';
import 'package:chat_application/core/middel_ware/mymiddel_ware.dart';
import 'package:chat_application/view/Screens/home/home_test.dart';
import 'package:chat_application/view/Screens/auth/forget_password_screen.dart';
import 'package:chat_application/view/Screens/auth/reset_password_screen.dart';
import 'package:chat_application/view/Screens/auth/success_screen.dart';
import 'package:chat_application/view/Screens/auth/verifycode_screen.dart';
import 'package:chat_application/view/Screens/camera/camera_screen.dart';
import 'package:chat_application/view/Screens/home/indiviual_chat/indiviual_screen.dart';
import 'package:chat_application/view/Screens/auth/login_screen.dart';
import 'package:chat_application/view/Screens/auth/signup_screen.dart';
import 'package:chat_application/view/Screens/home/tab_bar_screens/contacts_page.dart';
import 'package:chat_application/view/Screens/home/tab_bar_screens/home_page.dart';
import 'package:chat_application/view/Screens/status/my_status.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

List<GetPage<dynamic>>? routesScreens = [
  GetPage(name: "/", page: () => const MyLanguage(), middlewares: [MymiddelWare()]),

  //========================== Home ====================================
  // GetPage(name: AppRoute.landingScreen, page: () => const LandingScreen()),
  // GetPage(name: AppRoute.numberPage, page: () => const NumberScreen()),
  // GetPage(name: AppRoute.verifyCode, page: () => const OtpScreen()),
  // GetPage(name: AppRoute.homescreen, page: () => const HomeScreen()),

  GetPage(name: AppRoute.homeTest, page: () => HomeTest(), binding: InitialBindings()),

//============================ Auth ==================================
  GetPage(name: AppRoute.login, page: () => const LoginScreen()),
  GetPage(name: AppRoute.signUp, page: () => const SignUpScreen()),

  GetPage(name: AppRoute.emailVerifyCode, page: () => const VerifycodeSignup()),
  GetPage(name: AppRoute.successSignUp, page: () => const SuccessSignupScreen()),
  GetPage(name: AppRoute.forgetPassword, page: () => const ForgetPasswordScreen()),
  GetPage(name: AppRoute.resetPassword, page: () => const ResetPasswordScreen()),

//============================ Home Screen ==================================

  GetPage(name: AppRoute.cameraPage, page: () => const CameraScreen()),
  GetPage(name: AppRoute.contactPage, page: () => ContactPage()),
  GetPage(name: AppRoute.myStatus, page: () => const MyStatus()),
  GetPage(name: AppRoute.homePage, page: () => HomePage()),
  // GetPage(name: AppRoute.createGroup, page: () => const CreateGroup()),
  // GetPage(name: AppRoute.selectContacts, page: () => SelectContacts()),
  GetPage(name: AppRoute.indiviualScreen, page: () => IndiviualScreen()),
];
