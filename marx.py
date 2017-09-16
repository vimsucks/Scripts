from pymongo import MongoClient

client = MongoClient()
db = client.shuati
marxes = db.marxes

with open("/home/vimsucks/Documents/marx.md", "a") as file:
    for unit in range(1,8):
        file.write("## 第 " + str(unit) + " 章\n")
        file.write("### 单选题\n")
        for question in marxes.find({"type": "sig", "unit": unit}):
            file.write("- " + question["questionStr"] + "\n")

            options = {
                "A": question["optionA"],
                "B": question["optionB"],
                "C": question["optionC"],
                "D": question["optionD"]
            }

            for answer in question["answer"]:
                options[answer] = "<span style=\"color:green\">" + options[answer] + "</span>"

            file.write("  - A:" + options["A"] + "\n")
            file.write("  - B:" + options["B"] + "\n")
            file.write("  - C:" + options["C"] + "\n")
            file.write("  - D:" + options["D"] + "\n\n")

        file.write("### 多选题\n")
        for question in marxes.find({"type": "mul", "unit": unit}):
            file.write("- " + question["questionStr"] + "\n")

            options = {
                "A": question["optionA"],
                "B": question["optionB"],
                "C": question["optionC"],
                "D": question["optionD"]
            }

            for answer in question["answer"]:
                options[answer] = "<span style=\"color:green\">" + options[answer] + "</span>"

            file.write("  - A:" + options["A"] + "\n")
            file.write("  - B:" + options["B"] + "\n")
            file.write("  - C:" + options["C"] + "\n")
            file.write("  - D:" + options["D"] + "\n\n")

        file.write("### 判断题\n")
        for question in marxes.find({"type": "jud", "unit": unit}):
            file.write("- " + question["questionStr"] + "    <span style=\"color:green\">"+ question["answer"] + "</span>\n\n")