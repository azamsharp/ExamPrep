
const express = require('express')
const router = express.Router() 
const { body, validationResult } = require('express-validator') 
const authController = require('../controllers/authController') 
const { authenticate } = require('../middlewares/authMiddleware')

router.post('/register', authController.validate('register'), authController.register)
router.post('/login', authController.validate('login'), authController.login)
router.get('/roles', authController.getRoles)


module.exports = router 