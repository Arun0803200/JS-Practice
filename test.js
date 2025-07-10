// Reverse a String
const reverseString = (stringData) => {
const strArr = [];
for (const s of stringData) {
    strArr.unshift(s)
}
return strArr.join('');
}
const reveseStr = reverseString("Arun");
console.log('reveseStr:-', reveseStr);

// palindrome 
const palindrome = (strData) => {
    if (isNaN(strData)) {
        const reverseString = [];
        for(const data of strData) {
            reverseString.unshift(data);
        }
        const reversedStr = reverseString.join('');
        return strData == reversedStr ? 'The give string is palindrome' : 'The given string is not a palindrome';

    } else {
        const reverseString = [];
        for(const data of strData.toString()) {
            reverseString.unshift(data);
        }
        const reversedStr = reverseString.join('');            
        return strData == +reversedStr ? 'The give number is palindrome' : 'The given number is not a palindrome';
    }
}

const isPalindrome = palindrome("aruna");
console.log(isPalindrome);

// Find lagerst Number in array

// sort decending order

const sortOrder = (data) => {
const arr = data;
for (let i=0; i < arr.length; i++) {
    for (let j=0; j<arr.length-1-i; j++) {
        if (arr[j] < arr[j+1]) {
            const temp = arr[j];
            arr[j] = arr[j+1];
            arr[j+1] = temp;
        }
    }    
}
return arr;
}
const sortOrders = sortOrder([-5,2,7,3,100,6,-3,-3])
console.log(sortOrders);

// Remove Duplicate
const removeDuplicate = sortOrders.filter((value, index, self) => self.indexOf(value) == index)
console.log(removeDuplicate[0], ' -> is a largest number');

// or

const maxNumber = (data) => {
    let max = data[0];
    for (let i = 0; i < data.length; i++) {
        if (max < data[i]) {
            max = data[i];
        }
    }
    return max;
}
const findingMax = maxNumber([-5,2,7,3,100,6,-3,-3]);
console.log('the maximum number is - ', findingMax);

// Frequency of elements in array
const freElementArr= [21,3,4,21,3,3,4,4,21,4, 4];
const frequencyData = freElementArr.reduce((acc, value) => {
    acc[value] = (acc[value] || 0) + 1;
    return acc;
}, {});
console.log('frequencyData', frequencyData);

// Sum of digits in a number
const sumDigit = (value) => {
    let num = value;
    let sum = 0
    while(num > 0) {
        sum = sum + num % 10;
        num = Math.floor(num/10);
    }
    return sum
}
const digit = sumDigit(1001);
console.log('Sum of digit', digit);

// Count vowels and consonants

const findVowelsCount = (data) => {
    const vowels = ['a','e','i','o','u'];
    let vowelsCount = 0;
    let constantCount = 0;
    for(const val of data) {
        if (vowels.includes(val)) {
            vowelsCount++;
        } else {
            constantCount++;
        }
    }
    return {
        vowelsCount,
        constantCount,
    };
}

console.log(`vowels and constant count of 'Arundhika'`, findVowelsCount("Arundhika"));

// Fibonacci Series
// 0, 1, 1, 2, 3, 5, 8, 13, 21.......

const fibonacciSeries = (data) => {
    const fiboSeries = [0,1];
    for (let i = 2; i < data; i++) {
        fiboSeries[i] = fiboSeries[i-1] + fiboSeries[i-2];
    }
    return fiboSeries;
}
console.log('fibonacciSeries', fibonacciSeries(10));

// Print Prime Numer in between of particular number
const primeData = (data) => {
    const primeArr = []
    for(let i = 2; i <= data; i++) {
        let isPrime = true;
        for(let j = 2; j < i; j++) {            
            if (i % j == 0) {
                isPrime = false;
            }
        }        
        if (isPrime) {
            primeArr.push(i);
        }
        isPrime = true;
    }
    return primeArr;
}
console.log('Prime Numers in between of 1 to 100', primeData(1000))

// Remove duplicates from array
const dupiArr = [23,46,2,7,3,2,543,1,1];
const removedDuplicateArray = dupiArr.filter((val, index, self) => self.indexOf(val) == index);
console.log('removed Duplicated on array', removedDuplicateArray);

// Merge two sorted arrays remove duplicate
const arraySort1 = [2,4,6,6,8,1,3,5,7,9,1,2,3];
const arraySort2 = [3,5,7,9,1,2,4,6,8,1,2,3,4,5,6,7,8,9];

const tempArr = arraySort1.concat(arraySort2);
const sortByAsc = tempArr.sort((a, b) => a-b);
const removeDuplicated = sortByAsc.filter((value, index, self) => self.indexOf(value) == index);
console.log('Merged ans remove duplicate of two array', removeDuplicated);

// Two Sum Problem

const twoSumPrblm = (arrData, target) => {
    const possibleIndexes = []
    for (let i = 0; i < arrData.length; i++) {
        for (let j = i+1; j < arrData.length; j++) {
            if(arrData[i] + arrData[j] == target) {
                possibleIndexes.push([i, j])
            }
        }
    }
    return possibleIndexes;
}

const resultTwoSum = twoSumPrblm([3,6,3,5,7], 6)
console.log('Possible Two Sum Problems', resultTwoSum);

// Majority Element in Array
const findMajority = (arrData) => {
    let candidate = null;
    let count = 0;
    for(let num of arrData) {
        if (count == 0) {
            candidate = num
        }
        count += num == candidate ? 1 : -1
    }
    return {candidate, count};
}

console.log('findMajority', findMajority([1,1,2,2,2,3,1,3,1]));
