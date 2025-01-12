// // users.js
// const users = {};
 
// const addUser = (userId, socketId) => {
//     users[userId] = socketId;
// };

// const removeUser = (socketId) => {
//     const userId = Object.keys(users).find(key => users[key] === socketId);
//     if (userId) {
//         delete users[userId];
//     }
// };

// const getUserSocketId = (userId) => {
//     return users[userId] || null;
// };

// module.exports = { users, addUser, removeUser, getUserSocketId };
