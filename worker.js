const promise1 = Promise.reject(45);
const promise2 = new Promise((resolve, reject) => {
    setTimeout(resolve, 5000, 'Welcome to promise methods');
});

Promise.allSettled([promise1,promise2]).then((value) => {
    console.log(value);
}).catch((error) => {
    console.log(error);
});