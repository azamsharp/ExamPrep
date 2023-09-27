
const { body, validationResult } = require('express-validator')
const models = require('../models') 

exports.enroll = async (req, res) => {

    const { courseCode } = req.body 

    const errors = validationResult(req)

    if (!errors.isEmpty()) {
        res.status(400).json({ success: false, message: errors.array().map(error => error.msg).join(' ') })
        return
    }

    // get courseId based on courseCode 
    const course = await models.Course.findOne({
        where: {
            courseCode: courseCode
        }
    })

    if(course) {
        
        const enrollment = await models.Enrollment.create({
            studentId: req.userId, 
            courseId: course.id, 
            enrollmentDate: new Date() 
        })

        res.status(200).json({success: true})

    } else {
        res.status(400).json({success: false, message: 'Course not found.'})
    }

   

}

exports.validate = (method) => {
    switch (method) {
        case "enroll": {
            return [
                body('courseCode', 'Course code is required').exists().isLength({ min: 4 })
            ]
        }

    }
}