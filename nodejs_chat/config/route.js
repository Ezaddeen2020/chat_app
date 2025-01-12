
const express = require("express");
const route = express.Router();
const users = require("../view/user");
const chats = require("../view/chat");
const {upload} = require("../view/upload_File"); 
// const {markAsRead} = require('../view/chat'); 
const showFiles = require('../view/upload_File');
route.get("/" , (req,res)=>{
    res.json("hellow boye");
});


//==========  Users   ==================
route.post("/login",users.login)
route.post("/signup",users.signup)
route.post("/resetpass",users.resetpass)
route.post("/logout",users.logout)  
route.post("/verifycodefun",users.verifycodefun)
route.post("/resendcode",users.resendCode)
route.post("/check_email",users.check_email)
route.post("/updateToken",users.updateToken)
// route.post("/fetchAllRegisteredUsers", users.fetchUsersByPhoneNumbers);



//==========  Image Uploads ==================
// upload function
route.post('/upload', upload.array('files'), (req, res) => {

    if (req.files && req.files.length > 0) {
      
        res.send({status:"success",data:`${req.files.length} files uploaded successfully!`});
    } else {
        res.send( {status:"Fialer",data:"No files were uploaded."});
    }
});
//get file funcation
route.get('/files/:type', showFiles.showFiles);


//==========  Chats  ==================
route.post("/addData",chats.addData)
route.post("/deleteData",chats.deleteData)
route.post("/editData",chats.editData)
route.get("/getData/:userid",chats.getData)
route.get("/loadData/:senderId/:receiverId",chats.loadData)
route.get("/getMsgNotView/:userid",chats.getUnView)

// route.post("/createChat", chats.createChat);
// route.post('/markAsRead',chats.markAsRead); 




module.exports = route
