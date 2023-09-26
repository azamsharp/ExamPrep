
const { Op } = require('sequelize')
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

    // the same instructor cannot make the course with the same name 
    const course = await models.Course.findOne({
        where: {
            name: {
                [Op.iLike]: name 
            },
            userId: userId 
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

exports.getCoursesByUserId = async (req, res) => {

    const errors = validationResult(req)
    if(!errors.isEmpty()) {
        res.status(400).json({success: false, message: 'userId is missing or incorrect format'})
        return 
    }

    const userId = req.params.userId 

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
                body('name', 'Name cannot be empty.').exists().isLength({ min: 2 }),
                body('description', 'Description cannot be empty.').exists().isLength({ min: 2 })
            ]
        }

    }
}