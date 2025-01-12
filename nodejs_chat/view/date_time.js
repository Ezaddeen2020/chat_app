

const moment = require('moment-timezone');

function getCurrentDateTimeInSaudiArabia() {    
    return moment().tz("Asia/Riyadh").format('YYYY-MM-DD HH:mm:ss');
}

module.exports = { getCurrentDateTimeInSaudiArabia };







// const moment = require('moment');

// // احصل على الوقت الحالي بالتوقيت العالمي UTC
// function getCurrentDateTimeInUTC() {
//     return moment().utc().format('YYYY-MM-DD HH:mm:ss');
// }

// module.exports = { getCurrentDateTimeInUTC };
