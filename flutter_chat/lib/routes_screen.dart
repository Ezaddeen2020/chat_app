import 'package:chatapp/bindings/initial_bindings.dart';
import 'package:chatapp/core/constant/routes.dart';
import 'package:chatapp/core/middel_ware/mymiddel_ware.dart';
import 'package:chatapp/view/Screens/home/home_test.dart';
import 'package:chatapp/view/Screens/auth/forget_password_screen.dart';
import 'package:chatapp/view/Screens/auth/reset_password_screen.dart';
import 'package:chatapp/view/Screens/auth/language_screen.dart';
import 'package:chatapp/view/Screens/auth/success_screen.dart';
import 'package:chatapp/view/Screens/auth/verifycode_screen.dart';
import 'package:chatapp/view/Screens/camera/camera_screen.dart';
import 'package:chatapp/view/Screens/home/indiviual_chat/indiviual_screen.dart';
import 'package:chatapp/view/Screens/auth/login_screen.dart';
import 'package:chatapp/view/Screens/auth/signup_screen.dart';
import 'package:chatapp/view/Screens/home/tab_bar_screens/contacts_page.dart';
import 'package:chatapp/view/Screens/home/tab_bar_screens/home_page.dart';
import 'package:chatapp/view/Screens/status/my_status.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

List<GetPage<dynamic>>? routesScreens = [
  GetPage(
      name: "/",
      page: () => const HomeTest(),
      middlewares: [MymiddelWare()],
      binding: InitialBindings()),

  //========================== Home ====================================
  // GetPage(name: AppRoute.landingScreen, page: () => const LandingScreen()),
  // GetPage(name: AppRoute.numberPage, page: () => const NumberScreen()),
  // GetPage(name: AppRoute.verifyCode, page: () => const OtpScreen()),
  // GetPage(name: AppRoute.homescreen, page: () => const HomeScreen()),

  // GetPage(name: AppRoute.homeTest, page: () => const HomeTest(), binding: InitialBindings()),
  GetPage(name: AppRoute.lang, page: () => const MyLanguage(), binding: InitialBindings()),

//============================ Auth ==================================
  GetPage(name: AppRoute.login, page: () => const LoginScreen(), binding: InitialBindings()),
  GetPage(name: AppRoute.signUp, page: () => const SignUpScreen(), binding: InitialBindings()),

  GetPage(
      name: AppRoute.emailVerifyCode,
      page: () => const VerifycodeSignup(),
      binding: InitialBindings()),
  GetPage(name: AppRoute.successSignUp, page: () => const SuccessSignupScreen()),
  GetPage(
      name: AppRoute.forgetPassword,
      page: () => ForgetPasswordScreen(),
      binding: InitialBindings()),
  GetPage(
      name: AppRoute.resetPassword,
      page: () => const ResetPasswordScreen(),
      binding: InitialBindings()),

//============================ Home Screen ==================================

  GetPage(name: AppRoute.cameraPage, page: () => CameraScreen()),
  GetPage(name: AppRoute.contactPage, page: () => ContactPage()),
  GetPage(name: AppRoute.myStatus, page: () => const MyStatus()),
  GetPage(name: AppRoute.homePage, page: () => HomePage()),
  // GetPage(name: AppRoute.createGroup, page: () => const CreateGroup()),
  // GetPage(name: AppRoute.selectContacts, page: () => SelectContacts()),
  GetPage(name: AppRoute.indiviualScreen, page: () => IndiviualScreen()),
];
