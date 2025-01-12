
const connect = require("../config/connect");

const addData = (req, res) => {
    const { msg, msgKey, msgSent, msgType, receiverId, senderId, timestamp } = req.body;
  
            const timestampWithZ = new Date(timestamp).toISOString(); 
  
    const sql = "INSERT INTO chats (message, msg_key, msg_sent, msg_type, receiver_id, sender_id, msg_date) VALUES (?, ?, ?, ?, ?, ?, ?)";
    connect.query(sql, [msg, msgKey, 1, msgType, receiverId, senderId, timestampWithZ], (e, result) => {
      if (e) {
        return res.json({ error: `Error: ${e.message}` });
      }
  
    //   console.log("=======add data ========", result);
      if (result.affectedRows > 0) {
        return res.json({ status: "success" });
      }
      return res.json({ status: "Errors on data" });
    });
  };
  



//   const deleteData = (req, res) => { 
//     const { msgKey } = req.body;

//     // استعلام حذف الرسالة بناءً على المفتاح
//     const sql = "DELETE FROM chats WHERE msg_key = ?";
    
//     connect.query(sql, [msgKey], (e, result) => {
//         if (e) {
//             return res.json({ error: `Error: ${e}` });
//         }

//         if (result.affectedRows > 0) {
//             return res.json({ 
//                 status: "success",
//                 message: "Message deleted successfully",
//                 msgKey: msgKey 
//             });
//         }

//         // إذا لم يتم العثور على الرسالة بالمفتاح المطلوب
//         return res.json({ 
//             status: "not_found",
//             message: "No message found with the provided key"
//         });
//     });
// };






const deleteData =(req,res)=>{ 
    const { msg, msgKey } = req.body;
    // console.log(req.body+"7777777777");
    const sql = "UPDATE chats SET message = ? WHERE msg_key = ?";
    connect.query(sql, [msg, msgKey], (e, result) => {
        if (e) {
            return res.json({ e: `error in ${e}` });
        }
        if (result.affectedRows > 0) {
            return res.json({ 
                status: "success",
                msg: msg,
                msgKey: msgKey 
            });
        }
        return res.json({ status: "duplicate message" });
    });  
}


const editData = (req, res) => {
    const { msg, msgKey,msgView } = req.body;
    console.log("************************************",req.body);
    const sql = "UPDATE chats SET message = ? , msg_view =? WHERE msg_key = ?";
    connect.query(sql, [msg, msgView,msgKey], (e, result) => {
        if (e) {
            return res.json({ e: `error in ${e}` });
        }
        if (result.affectedRows > 0) {
            return res.json({ 
                status: "success",
                msg: msg,
                msgKey: msgKey 
            });
        }
        return res.json({ status: "duplicate message" });
    });
};


// .params when the valuse passes in the URL    .body
//This code is needed to retrieve the latest chat messages for a specific user. The goal is to get the most recent chat messages between the user and their chat partners.
    
const getData = (req, res)=>{
        const {userid} = req.params;    //The userid parameter is extracted from the req.params object. This userid will be used to filter the chat messages.
        const query = ` 
        SELECT 
        u.*,
        c.*
    FROM 
        users u
    JOIN
        (
            SELECT 
                MAX(msg_id) AS max_id_chat,           
                CASE 
                    WHEN sender_id = ? THEN receiver_id
                    WHEN receiver_id = ? THEN sender_id
                END AS other_user   
            FROM 
                chats
            WHERE 
                (sender_id = ? OR receiver_id = ?)
            
            GROUP BY
                other_user
        ) AS latest_chat ON u.user_id = latest_chat.other_user
    JOIN
        chats c ON c.msg_id = latest_chat.max_id_chat
    ORDER BY
        c.msg_date DESC ;`;

        connect.query(query, [userid, userid, userid, userid], async (e, result) => {
            if (e) return res.json({ error: `error in ${e}` });
        
            // إضافة عدد الرسائل غير المقروءة لكل مستخدم
            // for (let user of result) {
            //   user.countNotRead = await getUnreadMsgCount(user.user_id);
            // }  
        
            res.json({ status: "success", data: result });
          });
    }



const loadData = (req, res) => {
    const { senderId, receiverId} = req.params;

    const query = `
      SELECT * FROM chats
      WHERE sender_id = ? AND receiver_id = ? OR sender_id = ? AND receiver_id = ?
      ORDER BY msg_date DESC 
    LIMIT 20`;

    connect.query(query,[senderId,receiverId,receiverId,senderId],(e,result)=>{
        if(e){
            return res.json({e:`error in ${e}`});
        }
        if (result.affectedRows != 0) {
            return res.json({ status: "success",data:result});
          }
        return res.json({ status: "empty", message: "No messages found" }); 
    });
  }


const markAsRead = (req, res) => {
    const { userId, receiverId } = req.body;
  
    const query = `
      UPDATE chats 
      SET msg_view = 1 
      WHERE receiver_id = ? AND msg_view = 0`;
    
    connect.query(query, [receiverId, userId], (e, result) => {
      if (e) return res.json({ error: `error in ${e}` });
      res.json({ status: "success" });
    });
  };

  // const markAllAsRead = (req, res) => {
  //   const { userId, receiverId } = req.body;
  
  //   const query = `
  //     UPDATE chats 
  //     SET msg_view = 1 
  //     WHERE receiver_id = ? AND sender_id = ? AND msg_view = 0`;
  
  //   connect.query(query, [receiverId, userId], (e, result) => {
  //     if (e) return res.json({ error: `error in ${e}` });
  //     res.json({ status: "success", updatedCount: result.affectedRows });
  //   });
  // };

    const getUnView = (req, res) => {
    const { userid } = req.params;
    const query = `
      SELECT *  FROM users,chats
        WHERE users.user_id=chats.sender_id AND receiver_id = ? AND msg_view = 0`;
  
    connect.query(query, [userid], (e, result) => {
      if (e) return res.json({ error: `error in ${e}` });
      res.json({ status: "success", data: result });
    });
  };

// const getUnreadMsgCount = (userId) => {
//     return new Promise((resolve, reject) => {
//       const query = `
//       SELECT * FROM chats
//         WHERE receiver_id = ? AND msg_view = 0`;
//       connect.query(query, [userId], (e, result) => {
//         if (e) reject(e);
//         else resolve(result[0].unreadCount);
//       }); 
//     });
//   };



module.exports = {addData,deleteData,editData, getData,loadData,getUnView};
  