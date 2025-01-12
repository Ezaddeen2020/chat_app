
const multer = require('multer');
const mime = require('mime-types');
const fs = require('fs');
const path = require('path');

// Setup multer for file storage
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        const fileType = mime.lookup(file.originalname);
        const typeFolder = getTypeFolderName(fileType, file.originalname);
        console.log(__dirname);
        const dir = path.join(__dirname, `../files/${typeFolder}`);
        if (!fs.existsSync(dir)) {
            fs.mkdirSync(dir, { recursive: true });
        }
        cb(null, dir);
    },
    filename: (req, file, cb) => {
        cb(null, file.originalname);
    }
});

const upload = multer({ storage: storage });

function getTypeFolderName(fileType, fileName) {
    const fileExtension = path.extname(fileName).toLowerCase();
    if (fileExtension !== '.aac') {
        // Conditions for folder categorization based on MIME type
        if (fileType.startsWith("image/")) return 'image';
        if (fileType.startsWith("video/")) return 'video';
        if (fileType.startsWith("audio/")) return 'audio';
        if (fileType.includes("pdf")) return 'application';
        if (fileType.includes("plain")) return 'text';
        if (fileType.includes("msword") || fileType.includes("wordprocessingml")) return 'application';
        if (fileType.includes("ms-excel") || fileType.includes("spreadsheetml")) return 'application';
        if (fileType.includes("ms-powerpoint") || fileType.includes("presentationml")) return 'application';
        if (fileType.includes("octet-stream")) return 'applications';
        if (fileType.includes("gif")) return 'image';
        if (fileType.includes("xml")) return 'text';
        if (fileType.includes("zip")) return 'application';
        if (fileType.includes("json")) return 'application';
        return 'application'; // Default folder for types not explicitly matched
    } else {
        return 'audio';
    }
}
const showFiles = (req, res) => {
    const { type } = req.params;
    const { name } = req.query;
    const filePath = path.join(__dirname, '../files', type, name);
    const fileMimeType = mime.lookup(filePath);

    fs.readFile(filePath, (err, data) => {
        if (err) {
            console.log(err);
            return res.status(404).send('File not found.');
        }
        res.type(fileMimeType).send(data);
    });
};


module.exports = { upload, showFiles };
