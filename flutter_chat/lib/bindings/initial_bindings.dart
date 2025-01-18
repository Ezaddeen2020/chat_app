import 'package:chatapp/controller/auth/forgetpassword_controller.dart';
import 'package:chatapp/controller/auth/login_controller.dart';
import 'package:chatapp/controller/auth/reset_password_controller.dart';
import 'package:chatapp/controller/auth/signup_controller.dart';
import 'package:chatapp/controller/auth/verifycode_controller.dart';
import 'package:chatapp/controller/home_controller.dart';
import 'package:chatapp/controller/screens/user_controller.dart';
import 'package:chatapp/core/classes/crud.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => UserController());
    Get.lazyPut(() => LoginControllerImp());
    Get.lazyPut(() => SignUpControllerImp());
    Get.lazyPut(() => ResetPasswordControllerImp());
    Get.lazyPut(() => ForgetpasswordControllerImp());
    Get.lazyPut(() => VerifyCodeSignUpControllerImp());
  }
}

// بشكل تلقائي عند الانتقال إلى صفحة معينة في التطبيق أو عند بدء التطبيق. Controllers أو Services أو Repositories تُستخدم لتحميل 

//من إدارة عملية الإنشاء والتدمير GetX في أي مكان في التطبيق، سيتمكن  Crud بمجرد استدعاء 

//  في بداية تطبيقك أو الانتقال الى صفحة معينة Controllers OR Services  عندما نحتاج الى تهيئة بعض الـ Bindingsيتم استخدام 


//Note
//  سيتم تحميله فقط عندما تكون الصفحة أو الوظيفة التي تعتمد عليه قيد الاستخدام.Bindingsإذا قمت بتعريف كائن معين في  