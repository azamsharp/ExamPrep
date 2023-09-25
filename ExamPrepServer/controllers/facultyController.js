
const models = require('../models')

const { body, validationResult } = require('express-validator')

// create a course 
exports.createCourse = async (req, res) => {

    const { name, description } = req.body
    const userId = req.userId

    const errors = validationResult(req)

    if (!errors.isEmpty()) {
        res.status(400).json({ success: false, message: errors.array().map(error => error.msg).join(' ') })
        return
    }

    const course = await models.Course.findOne({
        where: {
            name: name
        }
    })

    if(course) {
        // if the course exists then return an error 
        res.status(400).json({success: false, message: 'Course name should be unique.'})
        return 
    }

    try {
        // save the course 
        const course = await models.Course.create({
            name: name,
            description: description,
            userId: userId
        })

         // 201 for created and send the new user back 
         res.status(201).json({ success: true, course: course })

    } catch (error) {
        res.status(500).json({ success: false, message: 'Internal server error' })
    }
}

exports.getAllCourses = async (req, res) => {
    const courses = await models.Course.findAll({
        where: {
            userId: req.userId 
        }
    })
    res.json(courses)
}

exports.validate = (method) => {
    switch (method) {
        case "createCourse": {
            return [
                body('name', 'Name cannot be empty.').exists(),
                body('description', 'Description cannot be empty.').exists()
            ]
        }

    }
}