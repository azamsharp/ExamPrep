
const express = require('express')
const router = express.Router() 
const facultyController = require('../controllers/facultyController') 
const { check } = require('express-validator') 

router.get('/courses/:userId',
 [
    check('userId').exists().withMessage('userId must be provided'), 
    check('userId').isInt().withMessage('UserId must be an integer')

], facultyController.getCoursesByUserId) 
router.post('/courses', facultyController.validate("createCourse"), facultyController.createCourse)

module.exports = router 