const arr = [1,2,3,4,5,6,7,8,9];

// Length
console.log('length', arr.length);

// toString
console.log('toString', arr.toString());

// at
console.log('at', arr.at(3));

// join
console.log('join', arr.join('|'));

// pop
console.log('pop', arr.pop(), 'after pop', arr);

// push
console.log('push', arr.push('9'), 'after push -->>', arr);

// shift
console.log('shift', arr.shift(), 'After Shift the array', arr);

// unshift
// unshift return the length of the array after unshift, and it is add the element in starting of the array
console.log('unshift', arr.unshift('1'), 'After unshift the arr', arr);

// delete
console.log(delete arr[0],'After delete the arr', arr);

// concat
const arr2 = [9,8,7,6,5,4,3,2,1];
console.log('concat', arr.concat(arr2));

// copyWithin -->> it is return with fixed length, the first index of value is for Copy length, the second para value is for ignore the balance set of starting length
console.log(arr.copyWithin(6, 2));

// flat -> Used to  <1 empty item>
console.log(arr.flat(), 'With out flat ->>', arr);

// slice -> it is not affect the original array
const sliceArr = [11,12,13,14,15];
console.log(sliceArr.slice(2,4), 'original arr ->>', sliceArr);

// splice -> it affect the original array, first param is start index and second index is length of after starting index
const spliceArr = [11,12,13,14,15];
console.log(spliceArr.splice(2,2), 'original arr ->>', spliceArr);

// Array looping methods
const loopArr = [100, 200, 300, 400, 500];
// forEact()
console.log(`
    ----------------------------For Each--------------------------------
    `);
loopArr.forEach((value, index, arrays) => {
    console.log('forEachValue', value);
    console.log('forEachIndex', index);
    console.log('dorEachArr', arrays);
})

// map()
console.log(`
    ----------------------------Map--------------------------------
    `);

loopArr.map((value, index, arr) => {
    console.log('Map Value', value);
    console.log('Map Index', index);
    console.log('Map Arr', arr);
})

// filter()
console.log(`
    ----------------------------Filter--------------------------------
    `);

const filteredArr = loopArr.filter((value, index, arr) => value >= 300);
console.log(filteredArr, 'filteredArr');

// reduce()
console.log(`
    ----------------------------Reduce--------------------------------
    `);
const reduceArr = loopArr.reduce((previousValue, currentValue, currentIndex, arr)=> {
    console.log(previousValue, 'previousValue');
    console.log(currentValue, 'currentValue');
    console.log(currentIndex, 'currentIndex');
    console.log(arr, 'arr');

    return previousValue+currentValue
}, 0)
console.log(reduceArr, 'reduceArr');

// find()
console.log(`
    ----------------------------Find--------------------------------
    `);
const findArr = loopArr.find((value, index, arr) => {
    console.log(value, 'value');
    console.log(index, 'index');
    console.log(arr, 'arr');
    return value === 400;
});
console.log(findArr, 'findArr');

// findIndex()
// Returns the index of the first element that satisfies the condition.
console.log(`
    ----------------------------FindIndex--------------------------------
    `);
const nums = [10, 20, 30];
const index = nums.findIndex(n => n > 15); // 1
console.log(index, 'index');


// some()
// Returns true if any element satisfies the condition.
console.log(`
    ----------------------------some--------------------------------
    `);
const hasEven = nums.some(n => n % 2 === 0); // true
console.log(hasEven, 'some');

// every()
// Returns true if all elements satisfy the condition.
console.log(`
    ----------------------------Every--------------------------------
    `);
const allEven = nums.every(n => n % 2 === 0); // true
console.log(allEven, 'every');

// for...of
// Iterates over array values (modern syntax).
console.log(`
    ----------------------------for...of--------------------------------
    `);
const colors = ['red', 'green'];
for (const color of colors) {
  console.log(color);
}

// for...in
// Iterates over indices (not recommended for arrays).
console.log(`
    ----------------------------for...in--------------------------------
    `);
for (const index in colors) {
  console.log(index, colors[index]);
}

// Traditional for loop
// Gives full control over index and iteration.
console.log(`
    ----------------------------Traditional for loop--------------------------------
    `);
for (let i = 0; i < nums.length; i++) {
  console.log(nums[i]);
}
