JAVASCRIPT NOTES (06.23)
// Exercise - types of variables:
// var shoeColor = "Yellow";
// var shoeSize = 40;
// var shoePrice = 124.95;
// var isBestseller = true;
// console.log(shoeColor)
// console.log(shoeSize)
// console.log(shoePrice)
// console.log(isBestseller)

// // Exercise - comparing values:
// var n1 = 10;
// var n2 = 10;
// console.log(n1 === n2) // are they equal?
// console.log(n1 !== n2) // are they not equal?
// console.log(n1 >= n2) // geq
// console.log(n1 <= n2) // leq
// console.log(price) // this prints the value inside the brakets

// // Exercise - operations:
// var cash = 50;
// var saving = 600;
// var result = saving/cash
// console.log("The results is " + result)

// // Exercise - operators:
// var a = "10";
// var b = 5;   // --> this example gives the same results id b is a string
// console.log(a + b)  // --> 105 --> only merges strings together
// console.log(a - b)  // --> 5
// console.log(a * b)  // --> 50
// console.log(a / b)  // --> 2

// // Exercise - average and IF:
// var average = (39+18+10+51+27+69+31)/7
// if(average >= 30) {
//     console.log(average + "minutes per day is the average")
// } else {
//     // do nothing
// }

// // Exercise - more conditionals:
// var isWorking = false;
// var isCarfixed = false;
// if(isWorking) {
//     console.log("I will not be going to Bday party T^T")
// } else if(!isWorking && isCarfixed) {
//     console.log("I will be going to Bday party ^u^!")
// } else if(!isWorking && !isCarfixed) {
//     console.log("I am not working but need to fix my car before going to the party.")
// } else {
//     // do nothing
// }

// // Exercise - functions:
// var earned = 30;
// var spent = 40;
// function dailyBattle(earned, spent){
//     console.log("Today I made $" + earned)
//     console.log("Today I spent $" + spent)
//     var left =  earned - spent
//     if(left>0) {
//         console.log("Total money for today $" + left)
//         console.log("I won today's battle.")
//     } else {
//         left = left*(-1)
//         console.log("Total money for today -$" + left)
//         console.log("I lost the battle.")
//     }    
// }
// dailyBattle(30,40)  // this is how the function is called

// function sum(n1,n2){
//     return n1 + n2; // after return nothing is executed
//     console.log("This text will not be visible")
// }

// function greeting(person){
//     return "Hi " + person + " welcome back"
// }

// // Exercise - function "Become a Member":
// function becomeMember() {
//     console.log("Welcome! You are now a member")
// }

// // Exercise - random numbers - 6-side dice:
// var randomNumb = Math.ceil((6)*(Math.random()));
// console.log(randomNumb)

// Exercise - simple calculator with prompt window:
// let no1 = prompt("Please enter first number");
// let no2 = prompt("Please enter first number");
// function multiply(no1,no2) {
//     return no1*no2
// }
// alert(multiply(no1, no2))

// -------------------------------------------------------------------------

// ARRAYS 

// // Exercise - Are you in list?
// var friends = ["Jim", "Luna", "Tina"];
// friends[2] = "Judy"  // change entry
// friends.push("nika")  //  add item to list
// friends.pop() // removes the last item on list
// friends.shift()  //  removes the first item on list
// // // console.log(friends.includes("diana")) //checks if argument exists inside array
// var isName = prompt("Introduce your name:");
// if (friends.includes(isName)) {
//     console.log("You can view the content.")
// } else {
//     console.log("You do not have access.")
// }

// // Exercise - Pomodoro break-time
// var breakTime = []
// var round = 1;
// var counter = 1;
// function addBreakTime() {
//     if(round%4 == 0) {
//         breakTime.push(15)
//     } else {
//         breakTime.push(5)
//     }
//     round++; // increases round by 1
// }
// while (counter <= 16) {
//     addBreakTime()
//     counter++;
// }

// for (var i=1; i<=8; i++) {
//     addBreakTime();
// }
// console.log(breakTime)

// // Exercise - while loop
// var counter = 1;

// while (counter<=3) {
//     console.log(counter);
//     counter++;
// }

// Exercise - print even numbers from any given list
// var arr = [13, 23, 12, 45, 22, 48, 66, 100]
// function evenCheck() {
//     evenList = []
//     for (var i=0; i < arr.length; i++) {
//         if (arr[i]%2==0) {
//             evenList.push(arr[i])
//         }
//     }    
//     console.log(evenList)
// }

// // Exercise - DOM Selectors - selecting HTML elements
// var obj = document.getElementById("selected-home") // select element by ID
// console.log(obj)
// var obj = document.getElementsByTagName("a") // gives an array of elements
// var obj = document.getElementsByTagName("a")[0] // select one tag element

// var obj = document.getElementsByClassName("main-nav") // gives array
// to change obj first select element in array, in console:
//> console.log(obj)
//> obj[0].style.backgroundColor = "red"

//var obj = document.querySelector("a") // selects the first <a> tag in html file

// var mainNav = document.querySelector("nav") // selects first nav tag 
// var selected = mainNav.querySelector("#selected-home") // selects ID element "selected" inside nv
// var intoButton = document.querySelector(".int-tex a")

// --------------------------------------------------------
// MORE JAVASCRIPT EXERCISES

// SWITCH
var distance = Number(prompt("How fr do you live from our store?"))
switch(distance){
    case 1:
        console.log("The cost of shipping in $0")
        break;
    case 2:
        console.log("The cost of shipping is $3")
        break;
    case 3:
        console.log("The cost of shipping is $5")
        break;
    default:
        console.log("The cost of shipping is $8")
        break;
}
// --------------------------------------
function countTrue(arr) {
    var cnt = 0;
    for (var i=0; i<arr.length; i++){
        if (arr[i]){
            cnt++
        } 
    }
    return cnt
}
// --------------------------------------
// Fibonacci sequence
function fibonacci(n){
    var arr = [0, 1]; 
    for (let i=0; i<(n-2); i++){
        temp = arr[i] + arr[i+1]
        arr.push(temp)
    }
    return arr
}
// --------------------------------------
// Count vowels and consonants - save in object

function countVowelsAndConsonants(str) {
    let vowelCount = 0;
    let consonantCount = 0;
    const lowercaseStr = str.toLowerCase();
    const vowels = /[aeiou]/;
    const consonants = /[bcdfghjklmnpqrstvwxyz]/;

    for (let i = 0; i < lowercaseStr.length; i++) {
      const char = lowercaseStr[i];
  
      if (vowels.test(char)) {
        vowelCount++;
      } else if (consonants.test(char)) {
        consonantCount++;
      }
    }
    const result = {
      vowels: vowelCount,
      consonants: consonantCount
    };
    return result;
}