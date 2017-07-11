const request = require("superagent")
const mongoose = require("mongoose")

mongoose.connect("mongodb://localhost/shuati")
//const db = mongoose.connection
//db.on("error", console.error.bind(console, "连接错误"))
//db.once("open", () => {
    //console.log("successfully connected to mongodb")
//})

const QuestionSchema = new mongoose.Schema({
    questionStr: String,
    answer: String,
    type: String,
    optionA: String,
    optionB: String,
    optionC: String,
    optionD: String,
    unit: Number,
})

const classes = {
    mao: { model: mongoose.model("mao", QuestionSchema), units: 12, code: 2 },
    marx: { model: mongoose.model("marx", QuestionSchema), units: 7, code: 5 },
}

let inserted = 0

Object.keys(classes).forEach((key) => {
    console.log(`getting ${key}...`)
    for (let unit = 0; unit < classes[key].units; ++unit) {
        request.get(`http://dt.m.cust.edu.cn/queReturnByUnit.ashx?que=${classes[key].code}&unit=${unit}`)
            .then((res) => {
                let questions = JSON.parse(res.text)
                console.log(`${key} unit ${unit} has ${questions.length} questions`)
                questions.forEach((question) => {
                    classes[key].model.create({
                        answer: question.Answer,
                        questionStr: question.QuestionStr,
                        type: question.Mode,
                        optionA: question.ChoosenA,
                        optionB: question.ChoosenB,
                        optionC: question.ChoosenC,
                        optionD: question.ChoosenD,
                        unit: question.Unit,
                    }).then(() => {
                        console.log(++inserted+" inserted")
                    })
                })
            })
    }
})
