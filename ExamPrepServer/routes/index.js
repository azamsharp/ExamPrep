
const express = require('express')
const router = express.Router() 
const { body, validationResult } = require('express-validator') 
const userController = require('../controllers/userController') 

router.post('/register', userController.validate('register'), userController.register)

module.exports = router 