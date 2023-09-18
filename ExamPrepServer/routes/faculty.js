
const express = require('express')
const router = express.Router() 
const facultyController = require('../controllers/facultyController') 

router.get('/courses', facultyController.getAllCourses) 

module.exports = router 