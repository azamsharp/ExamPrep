const express = require('express')
const app = express() 
const cors = require('cors')
const indexRouter = require('./routes/index') 

app.use(cors())
app.use(express.json())
app.use('/api', indexRouter)

app.listen(8080, () => {
    console.log('Server is running...')
})