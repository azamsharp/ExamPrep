

const express = require('express')
const router = express.Router() 
const studentController = require('../controllers/studentController') 

router.post('/courses', studentController.validate('enroll'), studentController.enroll)

module.exports = router 