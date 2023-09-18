
const jwt = require('jsonwebtoken')

exports.authenticate = (req, res, next) => {

    const authHeader = req.headers['Authorization']
    if(authHeader) {
       
    } else {
        res.statusCode(401).json({success: false, message: 'Required headers are missing.'})
    }

}