
const bcrypt = require('bcryptjs') 
const { body, validationResult } = require('express-validator')
const models = require('../models')

exports.register = async (req, res) => {

    const { email, password } = req.body 

    const errors = validationResult(req)
    if (!errors.isEmpty()) {
        res.status(400).json({ success: false, message: errors.array().map(error => error.msg).join(' ') })
        return
    }

    // check if the user is already registered 
    const user = await models.User.findOne({
        where: {
            email: email
        }
    })

    if (user) {
        // already exists 
        res.status(400).json({ success: false, message: 'Email is already registered.' })
        return
    }

    try {

        // hash the password 
        const hashedPassword = await bcrypt.hash(password, 10)

        // register new user 
        const newUser = await models.User.create({
            email: email,
            password: hashedPassword
        })

        // 201 for created and send the new user back 
        res.status(201).json({success: true})

    } catch(error) {
        console.error(error)
        res.status(500).json({success: false, message: 'Internal server error'})
    }
}

exports.validate = (method) => {

    switch (method) {
        case 'register': {
            return [
                body('email', 'Email cannot be empty.').exists().isEmail(),
                body('password', 'Password must be at least 6 characters long').exists().isLength({ min: 6 })
            ]
        }
    }

}