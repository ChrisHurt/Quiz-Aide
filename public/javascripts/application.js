var revealAnswer = (event) => {
    var i = 0;
    keyNum = event.target.className.match(/check_answer\d+/g)[0].slice(12);
    var key = '.answer_key' + keyNum
    var key2 = '.answer' + keyNum;
    if (document.querySelector(key) && document.querySelector(key2) && document.querySelector(key).classList.contains('hidden') && document.querySelector(key2).value != "") {
        document.querySelector(key).classList.remove('hidden');
        document.querySelector(key2).readOnly = true;
    }
}

for(var i = 0; i < document.querySelectorAll('.check_answer').length; i++){
    document.querySelector('.check_answer' + i).addEventListener('click',revealAnswer);
}

