
const express = require('express')
const router = express.Router() 
const { body, validationResult } = require('express-validator') 
const userController = require('../controllers/userController') 

router.post('/register', userController.validate('register'), userController.register)
router.post('/login', userController.validate('login'), userController.login)

module.exports = router 