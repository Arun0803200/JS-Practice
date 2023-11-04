// Promise methods

// Promise.all
const promise1 = Promise.resolve(3);
const promise2 = 43;
const promise3 = new Promise((resolve, reject) => {
    setTimeout(resolve, 5000, 'Welcome !!');
})
const result = Promise.all([promise1, promise2, promise3]).then((alue) => {
    console.log(alue, 'value...........'); // When all are completed then only the promise get resolve
}).catch((err) => {
    console.log(err, 'error..........');
});

// Promise.race
const racePromise1 = new Promise((resolve, reject) => {setTimeout(resolve, 200, '200 racing....')});
const racePromise2 = new Promise((resolve, reject) => {setTimeout(reject, 100, '100 racing...........')});
Promise.race([racePromise1, racePromise2]).then((value) => {
    console.log(value); // Only execute whichever one is completed first for both resolve and reject
}).catch((err) => {
    console.log(err);
});

// Promise.any
const anyPromise1 = new Promise((resolve, reject) => {setTimeout(resolve, 100, '100 any...')});
const anyPromise2 = new Promise((resolve, reject) => {setTimeout(resolve, 200, '200 any....')});
Promise.any([anyPromise1, anyPromise2]).then((value) => {
    console.log(value); // Only execute whichever one is completed only resole
}).catch((err) => {
    console.log(err);
});

// Promise.allSettled
const settledPromise1 = new Promise((resolve, reject) => {setTimeout(resolve, 100, '100 settled...')});
const settledPromise2 = new Promise((resolve, reject) => {setTimeout(resolve, 200, '200 settled...')});
Promise.allSettled([settledPromise1, settledPromise2]).then((value) => {
    console.log(value);
}).catch((err) => {
    console.log(err);
})
