// Call back function
function main(value, callback) {
    console.log('the gieven value is', value);
    const name = 34 + value;
    callback(name);
}

function checkingCallback(name) {
    console.log('The value to add name is', name);
}

// main(3, checkingCallback);

// Differents of call back function

// ****** ----------------------------------------- ******
// Synchronous Callbacks
function sunMain() {
    const number = [1,3,4,5]
    number.forEach((value) => {
        console.log(value, 'number');
    });
}
// sunMain();
// ****** ----------------------------------------- ******

// ****** ----------------------------------------- ******
// Asynchronous call back function
function timeOutFunction() {
    setTimeout(() => {
        console.log('after a second');
    }, 1000);
    console.log('before print the conditions');
}

// timeOutFunction();

// ****** ----------------------------------------- ******

// ****** ----------------------------------------- ******
// Named and Anonymous call back function
// Named function
function namedFun(value) {
    console.log('the gien vlue is :', value);
}
// namedFun(4);

// Anonymous Function
const anonymousFunc = ((value) => {
    console.log(value, ' -> this is the anonymous value');
})
// anonymousFunc(10);
// ****** ----------------------------------------- ******

function greet(name) {
  console.log('Hello, ' + name + '!');
}

function processUserInput(callback) {
  var name = prompt('Please enter your name: ');
  callback(name);
}

processUserInput(greet);
