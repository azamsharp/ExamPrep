

const { body, validationResult } = require('express-validator') 

exports.register = async (req, res) => {
    
    const errors = validationResult(req)
    if(!errors.isEmpty()) {
        res.status(400).json({ errors: errors.array() })
        return 
    }

    res.send('OK')
}

exports.validate = (method) => {

    switch(method) {
        case 'register': {
            return [
                body('email', 'Email cannot be empty.').exists().isEmail(), 
                body('password', 'Password must be at least 6 characters long').exists().isLength({ min: 6})
            ]
        }
    }

}