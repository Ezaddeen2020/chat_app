class AppLinks {
  static String server =
      // "http://10.0.70.9:5000";
      // "http://192.16.100.246:5000";
      // "http://192.168.60.207:5000";
      // "http://192.16.100.244:5000";
      "http://192.168.43.207:5000";
  // "http://216.244.75.253:5000";

  // "https://azooz-vps.meta-code-ye.com";

  static const headersList = {'Accept': '*/*', 'Content-Type': 'application/json'};

  //=============================  auth  ===============================//
  static String signUp = "$server/signup";
  static String login = "$server/login";
  static String verifcodeSignup = "$server/verifycodefun";
  static String checkEmail = "$server/check_email";
  static String resetPassword = "$server/resetpass";
  static String resend = "$server/resendcode";

  //============================= Home Page processing  ===============================//

  //======== Chat processing  ==============//
  static String getMessage = "$server/getData";
  static String addmessage = "$server/addData";
  static String loadMessage = "$server/loadData";
  // static String markAsRead = "$server/markAsRead";
  static String getMsgNotView = "$server/getMsgNotView";

  static String editMessage = "$server/editData";
  static String delMessage = "$server/deleteData";
  static String createChat = "$server/createChat";
  static String uploadfile = "$server/upload";

  //========== Users processing  ===============//
  static String fetchUsers = "$server/fetchAllRegisteredUsers";
}
