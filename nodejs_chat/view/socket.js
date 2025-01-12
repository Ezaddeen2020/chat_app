    const socketIO = require("socket.io");
    const { markAsRead } = require('./chat'); // استيراد الدالة من الملف الآخر

    function socketpage(server) {
      const io = socketIO(server,{
        cors:{
          origin:"*",                   // يسمح لأي نطاق بالاتصال
          methods:["GET","POST"],       //فقط تسمح بطريقتين وهي المذكورة

        },
        pingInterval:10000,           //ارسال بينج من الخادم الى العميل كل 10 ثواني 
        pingTimeout:5000,             //اذا لم يرد العميل على البينج خلال الفتره 5 ثوان يتم قطع الاتصال

      });
    
    
    const users = {};

    io.on("connection", (client) => {
      const userId = client.handshake.query.userId;
      console.log("User connected with ID:", userId);

      //=========== تخزين المستخدم
      users[userId] = client;
      io.emit("online",Object.keys(users));
      console.log("User connected:", Object.keys(users));


      //=========== عند قطع الاتصال
      client.on("disconnect", () => {
        const id_user = Object.keys(users).find((key) => users[key].id === client.id);

        if (id_user) {
          delete users[id_user];
        }
        io.emit("online",Object.keys(users));
        console.log("User disconnected:", Object.keys(users));
      });

      //=========== استقبال الرسائل
      client.on("message", (data) => {
        const { msg, receiver, sender } = data;
        console.log("Message received:", data);

        // تأكد أن الرسالة (msg) تحتوي على كائن موجود
        if (msg != null && msg.message != null) {
          msg.msg_sent = 1;
          // msg.msg_view = 0;
          // msg.message.editMsgbyKey = 1; 
          // msg.message.delMsgbykey = 1; 
          
      
          if (Object.keys(users).length > 0 && users[receiver.user_id]) {
            const map = { ...msg, ...sender };
            console.log("Sending message to receiver:", map);
            users[receiver.user_id].emit("message", [map]);
          }
      
          // إرسال نسخة إلى المرسل
          const mapSender = { ...msg, ...receiver };
          client.emit('message',[mapSender]);
          console.log("Sending message to sender:", mapSender);
        } else {
          console.error("Message or msg object is undefined or null");
        }
      });

      //====================   تحديث حالة الرسالة  
        
        // client.on("mark_as_read", (data) => {
        //   const { msgKey, receiverId, senderId } = data;        
        //   // تحديث حالة الرسالة في قاعدة البيانات
        //   markAsRead(msgKey, receiverId);
        
        //   // إرسال إشعار للمُرسل بأن الرسالة قد تم قراءتها
        //   if (users[senderId]) {
        //     users[senderId].emit('msg_read', { msgKey, receiverId });
        //     console.log(`Message ${msgKey} read by user ${receiverId}`);
        //   }
        // });
        
        
      

      client.on("error", (err) => {
        console.error("Error detected:", err);
      });
    });
  }

  module.exports = { socketpage };

