const express = require('express')
const app = express() 
const cors = require('cors')
const indexRouter = require('./routes/index') 
const facultyRouter = require('./routes/faculty')

app.use(cors())
app.use(express.json())
app.use('/api', indexRouter)
app.use('/api/faculty', facultyRouter)

app.listen(8080, () => {
    console.log('Server is running...')
})