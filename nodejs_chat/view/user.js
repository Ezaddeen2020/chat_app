
const connect = require("../config/connect");


  //============================= Login ===============================

const login = ((req,res)=>{
  const {email , password ,token} = req.body;
  const sql = "SELECT * FROM users,verifycode WHERE  users.user_email = verifycode.email AND users.user_email = ? AND users.user_password = ? order by verifycode.id desc";
  connect.query(sql, [email,password],(e, result)=>{
      if(e){
          return res.json({"state":"error" ,"message":e.code});
      }
      console.log(result);
      if(result.length!= 0){
        console.log(result[0]);
        if(result[0].checked){  //صحيحةاي أن المستخدم قد تحقق checked إذا كانت خاصية 
          updateToken(email,password,token);  //يتم تحديث التوكن
          return res.json({status: "success", data: result[0]});
          }else{                                                    //checked = false المستخدم موجود ولكن لم يتم التحقق منه
            const code = Math.floor(10000 + Math.random() * 90000); // انشاء رمز تحقق جديد
            updateverifycode(code,result[0].id_otp,false);          // تحديث رمز التحقق في قاعدة البيانات
            sendCodeToEmail(email,code);                            //إرسال رمز التحقق الجديد إلى البريد الإلكتروني
            return res.json({ status: "success", id_otp :result[0].id_otp,page:"page_verifycode"});
          }                                                         //هو معرف فريد يُستخدم لتعقب كل طلب تحقق، لذا فهو يُبقي ثابتًا في قاعدة البيانات id_otp 
      }
          return res.json({status: "This email not found"}) 
  }) ;
});

  //============================= SignUp ===============================

const signup = (req, res) => {
    const { user, email, password, phone,user_img, token } = req.body;
 console.log(user_img);
    const sql = "INSERT INTO users (user_name, user_email, user_password, user_phone,user_img, token) VALUES (?, ?,?, ?, ?,?)";
  
    connect.query(sql, [user, email, password, phone,user_img, token], async (e, result) => {
      if (e) {
        return res.json({ error: `Error: ${e.message}` });
      }
      //لإرسال كود التحقق إلى البريد الإلكترونيsendEmailإذا تم إدخال المستخدم بنجاح يتم استدعاء الدالة
      if (result.affectedRows > 0) {
       const id_otp = await sendEmail(email);         
        return res.json({ status: "success", id_otp :id_otp });
      }
  
      return res.json({ status: "This email is valid" });
    });

  };



    //============================= Index Function ===============================

  // CREATE INDEX id_phone_number ON users (user_phone);


  //============================= ResetPassword ===============================

  const resetpass =  ((req,res)=>{
      const {password,email, id_otp} = req.body;
      const sql = "UPDATE users,verifycode SET users.user_password = ? WHERE users.user_email = ? AND verifycode.id_otp = ?";
      connect.query(sql,[password,email,id_otp],(e,result)=>{
          if(e){
              return res.json({e:`error in ${e}`});
          }
          if(result.length!=0){

              return res.json({status:"success"});
          }
      });
  });


  //============================= ForgetPassword ===============================

  const check_email =  (async (req,res)=>{
    const email = req.body.email;
    const id_otp = await sendEmail(email);
          return res.json({ status: "success", id_otp :id_otp });
     });
  


  //============================= Logout ==============================

const logout = (req, res) => {
  const { email } = req.body;
  const sql = "DELETE FROM users WHERE user_email = ?";
  
  connect.query(sql, [email], (err, result) => {
      if (err) {
          return res.status(500).json({ error: `Error: ${err}` });
      }
      if (result.affectedRows > 0) {
          return res.json({ status: "success", message: "User logged out and deleted." });
      }
      return res.status(404).json({ status: "error", message: "Email not found." });
  });
};


  //============================= Verify_Code ===============================


const verifycodefun = (req, res) => {
  const { code, id_otp } = req.body;

  if (!code || !id_otp) {
      return res.status(400).json({ status: "error", message: "Invalid input" });
  }

  const sql = "SELECT * FROM verifycode WHERE code = ? AND id_otp = ? AND checked = 0 LIMIT 1";
  connect.query(sql, [code, id_otp], (e, result) => {
      if (e) {
          return res.status(500).json({ status: "error", message: `Database error: ${e}` });
      }
      if (result.length !== 0) {
          updateverifycode(code, id_otp, true);
          return res.json({ status: "success" });
      }
      return res.json({ status: "failure", message: "Invalid verification code" });
  });
};

  //============================= Resend_Code ===============================

const resendCode= ((req,res)=>{
    const {email,id_otp} = req.body;
    const code = Math.floor(10000 + Math.random() * 90000);
    updateverifycode(code,id_otp,false);
     sendCodeToEmail(email,code);
     return res.json({status:"success"});
    
});


function updateverifycode(code , id_otp, checked){
    const sql = " UPDATE verifycode SET code = ? , checked = ? WHERE id_otp =? AND checked = 0";
    connect.query(sql,[code, checked, id_otp]);
}


  //============================= update token function ===============================

  function updateToken(email,password,newToken){
    const sql = "UPDATE users SET token = ? WHERE user_email = ? AND user_password = ? ";
    connect.query(sql,[newToken,email,password],(err, result)=>{
      if(err){
        return console.error("error updating token", err);
      }
      if (result.affectedRows > 0) {
        console.log("Token updated successfully");
      } 
      else{
        return console(" token not update ");
      }
    });

  }



  //============================= Send Email Function ===============================

async function sendEmail(email)  {
    const id_otp = generateOtp();
    const verifycode = Math.floor(10000 + Math.random() * 90000);
    const sql = "INSERT INTO verifycode (email, code, id_otp) VALUES (?, ?, ?)";
  
    connect.query(sql, [email, verifycode, id_otp], async (err, result) => {
      if (err) {
        console.error('Error inserting verification code:', err);
        return;
      }
  
      if (result.affectedRows > 0) {
       await sendCodeToEmail(email,verifycode); //بعد عملية انشاء و اضافة اوتيبي و الايميل و الكود الى جدول التحقق يتم ارسال الايميل و الكود معا الى هذه الدالة
      }
      
    });
    return id_otp;
}
  
  function generateOtp() {
    const characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const shuffle = (str) => str.split('').sort(() => 0.5 - Math.random()).join('');
    const group1 = shuffle(characters).substring(0, 5);
    const group2 = shuffle(characters).substring(0, 5);
    const group3 = shuffle(characters).substring(0, 5);
    return `${group1}-${group2}-${group3}`;
  }



  //============================= Send ===============================

  const https = require('https');
  const querystring = require('querystring');// convert the js ob to the query string it used in the URL
  
  /**
   * Sends an email and code to the PHP endpoint.
  //  * @param {string} email - The email address to send.
  //  * @param {string} code - The code to send.
  //  */
  function sendCodeToEmail(email, code) {
    // Define the data to be sent
    const postData = querystring.stringify({
      email: email,
      code: code  
    });
  
    // Define the request options (ارسال طلب الى السيرفر)
    const options = {
      hostname: 'azaldeen.meta-code-ye.com',
      port: 443,
      path: '/eco_php/auth/link_vps.php',
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Content-Length': Buffer.byteLength(postData)// حساب طول البيانات المرسلة
      }
    };
  
    // Create the request (انشاء الطلب)
    const req = https.request(options, (res) => {
      let responseData = '';    // متغير يُستخدم لتخزين البيانات المستلمة من الخادم.
  
      res.on('data', (chunk) => { // responseData عندما تصل من الخادم إلى chunks تستخدم لإضافة بيانات جديدة
        responseData += chunk;
      });
  
      res.on('end', () => {     //حدث يُشير إلى انتهاء استلام البيانات. يتم فيه طباعة الاستجابة الكاملة end معالجة نهاية الطلب
        console.log('Response:', responseData);
      });
    });
  
    // Handle errors
    req.on('error', (e) => {
      console.error('Error:', e.message);
    });
  
    // Write the data to the request body
    req.write(postData);
  
    // End the request
    req.end();
  }




// const fetchUsersByPhoneNumbers = async (req, res) => {
//   try {
//     const { contacts } = req.body;

//     if (!contacts || contacts.length === 0) {
//       return res.json({
//         status: 'success',
//         data: [],            // لا يوجد مستخدمين مسجلين
//         to_invite: contacts  // كل الأرقام تعتبر غير مسجلة
//       });
//     }
    
//     // استخراج الأرقام فقط من جهات الاتصال لإجراء الاستعلام
//     const phoneNumbers = contacts.map(e => e.user_phone);    // استعلام للتحقق من الأرقام في قاعدة البيانات
    
//     const sql = `SELECT u.user_id, u.user_name, u.user_phone, u.user_status FROM users u WHERE u.user_phone IN (?)`;
//     connect.query(sql, [phoneNumbers], (err, results) => {
//       if (err) {
//         console.error('Database error:', err);
//         return res.status(500).json({ error: 'Database error' });
//       }

//       // استخراج الأرقام التي تم العثور عليها في قاعدة البيانات
//       const matchedPhones = results.map(e => e.user_phone);

//       // إنشاء قائمة الأرقام غير المسجلة بناءً على نتائج قاعدة البيانات
//       // const toInviteUsers = contacts
//       //   .filter(contact => !results.some(result => result.user_phone === contact.user_phone))
//       //   .map(contact => ({
//       //     user_name: contact.user_name,
//       //     user_phone: contact.user_phone,
//       //   }));         

//       // إنشاء قائمة للأرقام غير المسجلة وإضافة الاسم
//       const toInviteUsers = contacts
//         .filter(e => !matchedPhones.includes(e.user_phone))
//         .map(e => ({
//           user_name: e.user_name,  
//           user_phone: e.user_phone,
//         }));

//       return res.json({
//         status: 'success',
//         data: results,       // بيانات المستخدمين المسجلين
//         to_invite: toInviteUsers  // بيانات الأرقام غير المسجلة
//       });
//     });
//   } catch (err) {
//     console.error('Unexpected error:', err);
//     return res.status(500).json({ error: 'Unexpected error' });
//   }
// };

 



  
module.exports = {login,signup,resetpass,logout,verifycodefun,resendCode, check_email,updateToken};







// const inviteNewUsers = async (req, res) => {
//   const { contacts } = req.body; // جهات الاتصال المستلمة من العميل (رقم الهاتف)

//   try {
//       const sql = `
//           SELECT 
//               user_phone 
//           FROM 
//               users 
//           WHERE 
//               user_phone IN (?)`;

//       connect.query(sql, [contacts], (err, results) => {
//           if (err) {
//               console.error('Database error:', err);
//               return res.status(500).json({ error: 'Database error, please try again later.' });
//           }

//           // قائمة الأرقام المسجلة
//           const registeredPhones = results.map(user => user.user_phone);

//           // المستخدمين الذين يحتاجون إلى دعوة
//           const unregisteredContacts = contacts.filter(contact => !registeredPhones.includes(contact));

//           return res.json({ status: 'success', data: unregisteredContacts });
//       });
//   } catch (err) {
//       console.error('Unexpected error:', err);
//       return res.status(500).json({ error: 'Database error, please try again later.' });
//   }
// };




// <?php
// include "../connect.php";

//  $email = $_POST['email'];
//  $verifycode = $_POST['code'];    
//  if($email && $verifycode){
//  sendEmail($email, "Verify Code Ecommerce", "Verify Code $verifycode");
//  echo json_encode("ok");
//     }
//  else{
//      echo json_encode("Error");
//  }
 