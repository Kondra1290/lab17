// здесь наодится игровая логика
var score = 0
var points = 1
var correctAnswer = -1
var blitsProbability = -1
var nums = [0, 0, 0, 0, 0, 0]
var operations = ['', '', '', '', '']
var parametersCount = 0
var blitsLock = 7
var blitsQuestion = false

// Создание вопроса. Может быть как обычный так и блиц вопрос
function generateQuestion() {

    if(blitsLock <= 0)
    {
        blitsProbability = Math.random() * 100
    }

    if(blitsProbability <= 30 && blitsLock <= 0)
    {
        console.log("BLITS")
        blitsQuestion = true
        button1.visible = false;
        button2.visible = false;
        button3.visible = false;
        button4.visible = false;
        questionText1.visible = true;
        generateBlitsQuestion()
        blitsLock = 7
        blitsProbability = -1
        animation.start()
    }
    else
    {
        console.log("USUSL")
        blitsLock--
        blitsQuestion = false
        questionText1.visible = false;
        button1.visible = true;
        button2.visible = true;
        button3.visible = true;
        button4.visible = true;

        generateUsualQuestion()
    }
    makeQuestionText()
}

// Создание обычного вопроса
function generateUsualQuestion() {
    do {
        parametersCount = 2
        nums[0] = Math.floor(Math.random() * 4);
        nums[1] = Math.floor(Math.random() * 4);

        if (score > 100)
        {
            parametersCount++
            nums[2] = Math.floor(Math.random() * 4);
        }
        if (score > 1000)
        {
            parametersCount++
            nums[3] = Math.floor(Math.random() * 4);
        }
        if (score > 10000)
        {
            parametersCount++
            nums[4] = Math.floor(Math.random() * 4);
        }

        correctAnswer = nums[0];
        for(var i = 1; i < parametersCount; i++){
            operations[i-1] = Math.random() < 0.5 ? '+' : '-';
            correctAnswer += operations[i-1] === '+' ? nums[i] : -1*nums[i]
        }
    } while (correctAnswer < 0 || correctAnswer > 3)

    timeLeft = 7
}

// Создание облиц вопроса
function generateBlitsQuestion() {
    parametersCount = 3

    nums[0] = Math.floor(Math.random() * 10)
    nums[1] = Math.floor(Math.random() * 10)
    nums[2] = Math.floor(Math.random() * 10)

    parametersCount = Math.floor(Math.random()*3 + 3);

    if (parametersCount > 3) nums[3] = Math.floor(Math.random() * 10);
    if (parametersCount > 4) nums[4] = Math.floor(Math.random() * 10);
    if (parametersCount > 5) nums[5] = Math.floor(Math.random() * 10);

    correctAnswer = parseInt(nums[0]);
    for(var i = 1; i < parametersCount; i++){
        operations[i-1] = Math.random() < 0.5 ? '+' : '-'
        correctAnswer += operations[i-1] === '+' ? parseInt(nums[i]) : parseInt(-1*nums[i])
    }

    timeLeft = Math.floor(Math.random() * 7 + 14);
}

//создание текса вопроса котрый увидет пользователль
function makeQuestionText(){
    questionText.text = ''
    for(var i = 0; i < parametersCount; i++){
        if(i != parametersCount-1) questionText.text += String(nums[i]) + " " + operations[i] + " "
        else questionText.text += String(nums[i])
    }

    ///*
    questionText.text += ' = ?'
    console.log('---------------------')
    console.log(parametersCount)
    console.log(nums)
    console.log(correctAnswer)
    console.log(operations)
    console.log(blitsProbability)
    console.log(blitsLock)
    console.log(questionText.text)
    console.log("\n")
    //*/
}

// Проверка ответа
function checkAnswer(answer) {
    if (answer === correctAnswer) {
        score += blitsQuestion ? 2*points : points;
        points++;
        game.sc = score
        generateQuestion();
    } else {
        gameOver();
    }
}

// Действия про истечении времени или неправилльном ыопросе
function gameOver() {
    timer.running = false
    game.visible = false

    if(sqlitedatabase.checkUser(game.user, score))
    {
       sqlitedatabase.updateRecord(game.user, score)
    }
    else sqlitedatabase.insertIntoTable(game.user, score)

    myModel.updateModel()

    var component = Qt.createComponent("Main.qml")
    var mainWindow = component.createObject()
    mainWindow.show()

    score = 0
    points = 1
    blitsLock = 7
    blitsProbability = -1
}
