    const socketIO = require("socket.io");
    // const { markAsRead } = require('./chat'); // استيراد الدالة من الملف الآخر
    // const msgpack = require("msgpack-lite");

    function socketpage(server) {
      const io = socketIO(server, {
        cors: {
          origin: "*",
          methods: ["GET", "POST"],
        },
        pingInterval: 30000, // زيادة الفترة إلى 30 ثانية
        pingTimeout: 10000,  // زيادة الفترة إلى 10 ثواني
      });
      
    
    const users = {};
    // const users = new Map(); // استخدام Map بدلاً من الكائن العادي


    io.on("connection", (client) => {
      const userId = client.handshake.query.userId;
      console.log("User connected with ID:", userId);

      // //=========== تخزين المستخدم
      users[userId] = client;
      io.emit("online",Object.keys(users));
      console.log("User connected:", Object.keys(users));
  // تخزين المستخدم
  // users.set(userId, client);
  // io.emit("online", Array.from(users.keys())); // إرسال قائمة المستخدمين المتصلين
  // console.log("User connected:", Array.from(users.keys()));


      //=========== عند قطع الاتصال
      client.on("disconnect", () => {
        const id_user = Object.keys(users).find((key) => users[key].id === client.id);

        if (id_user) {
          delete users[id_user];
        }
        io.emit("online",Object.keys(users));
        console.log("User disconnected:", Object.keys(users));
      });
      // console.log(users['192']);

        // عند قطع الاتصال
  // client.on("disconnect", () => {
  //   users.delete(userId); // حذف المستخدم من الـ Map
  //   io.emit("online", Array.from(users.keys()));
  //   console.log("User disconnected:", Array.from(users.keys()));
  // });


      //=========== استقبال الرسائل
      client.on("message", (data) => {
        const { msg, receiver, sender } = data;
        // console.log("Message received:", data);
        // تأكد أن الرسالة (msg) تحتوي على كائن موجود
        if (msg != null && msg.message != null) {
          msg.msg_sent = 1;
          
          //messageBatch إذا كان التطبيق يرسل رسائل صغيرة بشكل متكرر، يمكنك تجميعها وإرسالها معًا لتقليل عدد الطلبات. مستقبلا

          if (Object.keys(users).length > 0 && users[receiver.user_id]) {
            const map = { ...msg, ...sender };
            console.log("Sending message to receiver:", map);
            users[receiver.user_id].emit("message", [map]);
          }
          // if (users.has(receiver.user_id)) {
          //   const map = { ...msg, ...sender };
          //   // const compressedData = msgpack.encode(map); // ضغط البيانات
          // console.log("Sending message to reciever:", map);

          //   users.get(receiver.user_id).emit("message", [map]);
          // }
      
          // إرسال نسخة إلى المرسل
          const mapSender = { ...msg, ...receiver };
          // const compressedDataSender = msgpack.encode(mapSender); // ضغط البيانات
          client.emit('message',[mapSender]);
          console.log("Sending message to sender:", mapSender);
        } else {
          console.error("Message or msg object is undefined or null");
        }
      });
      

      client.on("error", (err) => {
        console.error("Error detected:", err);
      });
    });
  }

  module.exports = { socketpage };



//   let messageBatch = []; // مصفوفة لتجميع الرسائل
// const BATCH_INTERVAL = 100; // الفترة الزمنية للتجميع (100 مللي ثانية)

// client.on("message", (data) => {
//   const { msg, receiver, sender } = data;

//   if (msg != null && msg.message != null) {
//     msg.msg_sent = 1;

//     // إضافة الرسالة إلى الدُفعة
//     messageBatch.push({ msg, receiver, sender });

//     // إذا وصلت الدُفعة إلى حجم معين أو انقضت الفترة الزمنية، يتم إرسالها
//     if (messageBatch.length >= 10 || Date.now() - lastBatchTime >= BATCH_INTERVAL) {
//       sendBatch();
//     }
//   } else {
//     console.error("Message or msg object is undefined or null");
//   }
// });

// function sendBatch() {
//   if (messageBatch.length > 0) {
//     // إرسال الدُفعة إلى المستقبل
//     const receiverId = messageBatch[0].receiver.user_id;
//     if (users.has(receiverId)) {
//       users.get(receiverId).emit("message", messageBatch);
//     }

//     // إرسال نسخة إلى المرسل
//     client.emit('message', messageBatch);

//     // تفريغ الدُفعة
//     messageBatch = [];
//     lastBatchTime = Date.now();
//   }
// }

// void socketListen() {
//   socket?.on('message', (data) {
//     if (data is List) {
//       for (var messageData in data) {
//         msgSocketEvent(messageData); // معالجة كل رسالة في الدُفعة
//       }
//     } else {
//       msgSocketEvent(data); // معالجة رسالة فردية
//     }
//   });
// }