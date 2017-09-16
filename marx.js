const request = require("superagent")
const mongoose = require("mongoose")

mongoose.connect("mongodb://localhost/shuati")
//const db = mongoose.connection
//db.on("error", console.error.bind(console, "连接错误"))
//db.once("open", () => {
    //console.log("successfully connected to mongodb")
//})

const QuestionSchema = new mongoose.Schema({
    Id: Number,
    QuestionStr: String,
    Answer: String,
    Type: String,
    OptionA: String,
    OptionB: String,
    OptionC: String,
    OptionD: String,
    Unit: Number,
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
                        Id: question.ID,
                        Answer: question.Answer,
                        QuestionStr: question.QuestionStr,
                        Type: question.Mode,
                        OptionA: question.ChoosenA,
                        OptionB: question.ChoosenB,
                        OptionC: question.ChoosenC,
                        OptionD: question.ChoosenD,
                        Unit: question.Unit,
                    }).then(() => {
                        console.log(++inserted+" inserted")
                    })
                })
            })
    }
})
