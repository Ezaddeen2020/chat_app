import 'package:get/get.dart';

validInput(String val, int min, int max, String type) {
  if (type == "userImage") {
    if (!GetUtils.isImage(val)) {
      return "not valid image";
    }
  }
  if (type == "username") {
    if (!GetUtils.isUsername(val)) {
      return "not valid username";
    }
  }
  
  if (type == "email") {
    if (!GetUtils.isEmail(val)) {
      return "not valid email";
    }
  }
  if (type == "phone") {
    if (!GetUtils.isPhoneNumber(val)) {
      return "not valid phone";
    }
  } 

  if (val.isEmpty) {  
    return "Can't be empty";
  }
  if (val.length < min) {
    return "Can't be less than $min";
  }
  if (val.length > max) {
    return "Can't be more than $max";
  }
}















// import 'package:get/get.dart';

// String? validInput(String val, int min, int max, String type) {
//   // التحقق من المدخلات الأساسية
//   if (val.isEmpty) {
//     return "Can't be empty";
//   }
//   if (val.length < min) {
//     return "Can't be less than $min characters";
//   }
//   if (val.length > max) {
//     return "Can't be more than $max characters";
//   }

//   // تحقق بناءً على النوع
//   if (type == "userImage" && !GetUtils.isImage(val)) {
//     return "Not a valid image";
//   }
//   if (type == "username" && !GetUtils.isUsername(val)) {
//     return "Not a valid username";
//   }
//   if (type == "email" && !GetUtils.isEmail(val)) {
//     return "Not a valid email";
//   }
//   if (type == "phone" && !GetUtils.isPhoneNumber(val)) {
//     return "Not a valid phone number";
//   }

//   // إذا كانت جميع الشروط صحيحة
//   return null; // أو يمكنك إرجاع "" إذا كنت تفضل ذلك
// }




// دالة للتحقق من صحة كلمة المرور
// bool _isValidPassword(String val) {
//   // تحقق من طول كلمة المرور
//   if (val.length < 8) return false;
//   // تحقق من وجود حرف كبير
//   if (!RegExp(r'[A-Z]').hasMatch(val)) return false;
//   // تحقق من وجود حرف صغير
//   if (!RegExp(r'[a-z]').hasMatch(val)) return false;
//   // تحقق من وجود رقم
//   if (!RegExp(r'[0-9]').hasMatch(val)) return false;
//   // تحقق من وجود رمز خاص
//   if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(val)) return false;

//   return true; // إذا اجتازت جميع الفحوصات
// }


// import 'package:get/get.dart';

// String? validInput(String val, int min, int max, String type) {
//   // التحقق من المدخلات الأساسية
//   if (val.isEmpty) {
//     return "Can't be empty";
//   }
//   if (val.length < min) {
//     return "Can't be less than $min characters";
//   }
//   if (val.length > max) {
//     return "Can't be more than $max characters";
//   }

//   // تحقق بناءً على النوع
//   if (type == "userImage" && !GetUtils.isImage(val)) {
//     return "Not a valid image";
//   }
//   if (type == "username" && !GetUtils.isUsername(val)) {
//     return "Not a valid username";
//   }
//   if (type == "email" && !GetUtils.isEmail(val)) {
//     return "Not a valid email";
//   }
//   if (type == "phone" && !GetUtils.isPhoneNumber(val)) {
//     return "Not a valid phone number";
//   }

//   // إذا كانت جميع الشروط صحيحة
//   return null; // أو يمكنك إرجاع "" إذا كنت تفضل ذلك
// }




