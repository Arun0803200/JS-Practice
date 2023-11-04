/**
 * Certainly! Timeout functions like 
 * setTimeout,
 * setInterval,
 * process.nextTick,
 * and setImmediate are used in JavaScript and Node.js to manage asynchronous operations,
 * allowing code execution after a certain period or on the next iteration of the event loop.
 */

// setTimeout
setTimeout(() => {
    console.log('executing setTimeout function');
}, 1000);

// setInterval
/**
 * setIterval also similar to setTimeout
 * but it is repeatly call a function with specific time interval between each call
 */
let counter = 0;
const interal = setInterval(() => {
    console.log('Itration is: ', counter++); // completed all function then only execute this console.....
    if (counter === 5) {
        clearInterval(interal);
    }
},1500);

// process.nextTick()
console.log('start next tick');

process.nextTick(() => {
    console.log('Ececute next tick');
}, 2000);

console.log('end next tick');
// o/p: first execute -> 'start'. 2nd execute -> 'end'. 3rd execute

//setImmediate is used to execute a call back function before excute the i/o operation

console.log('immediate Start....');
setImmediate(() => {
    console.log('Set immediate ......'); // this one is execute befor process.tick() 
});
console.log('immediate end.......');
