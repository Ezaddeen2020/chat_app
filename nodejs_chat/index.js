const route = require("./config/route"); 
const  {socketpage} = require("./view/socket"); 


const http = require("http"); 
const express = require("express"); 
const app = express(); 
const server = http.createServer(app); 


socketpage(server); 
app.use(express.json()); 
app.use("/", route); 

server.listen(5000, '0.0.0.0', (err) => {
  if (err) {
    console.error("Server failed to start", err);
  } else {
    console.log("Server is listening on port 5000");
  }
});

