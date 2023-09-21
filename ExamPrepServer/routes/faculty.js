
const express = require('express')
const router = express.Router() 
const facultyController = require('../controllers/facultyController') 

router.get('/', facultyController.getAllCourses) 
router.post('/', facultyController.validate("createCourse"), facultyController.createCourse)

module.exports = router 