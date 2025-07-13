// SET
const setOperation = () => {
    const newSet = new Set();
    newSet.add(1);
    newSet.add(2);
    newSet.add(3);
    newSet.add(4);
    newSet.add(4);
    console.log(newSet, 'newset');

    const arraySet = new Set([1,2,3,4,5]);
    console.log(arraySet.has(3)); // true or false
    console.log(Array.from(arraySet)); // [ 1, 2, 3, 4, 5 ]
    console.log(arraySet.size); // 5
    console.log(arraySet.delete(1)); // true
    console.log(arraySet.clear()); // undefined
}
setOperation();

const mapOperation = () => {
    const newMap = new Map();
    newMap.set('id', 1);
    newMap.set('name', 'Arun');
    newMap.set('city', 'Chennai');
    console.log(newMap, 'newMap'); // Map(3) { 'id' => 1, 'name' => 'Arun', 'city' => 'Chennai' }
    console.log(newMap.get('id')); // 1
    console.log(newMap.has('name')); // true
    console.log(newMap.size); // 3
    console.log(newMap.delete('name')) // true
    console.log(newMap.clear()); // undefined
}
mapOperation();

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

// First Non-Repeating Character
const nonRepeatingChar = (data) => {
    const strArr = data.toLowerCase().split('');
    for (const dataValue of data) {
        const inCaseValue = dataValue.toLowerCase();
        if (strArr.indexOf(inCaseValue) == strArr.lastIndexOf(inCaseValue)) {
            return inCaseValue;
        }
    }
    return 'There is no Repeated Character';
}
console.log('The first non repeated char is - ', nonRepeatingChar('Arundhika'));

// Rotate an array (left/right)
const rotateLeft = (data, k) => {
    const arr = data;
    const valueK = k % arr.length;
    for( let i = 0; i < valueK; i++) {
        const unshiftElm = arr.shift();
        arr.push(unshiftElm);
    }
    return arr;
}

const rotateRight = (data, k) => {
    const arr = data;
    const kValue = k % data.length;
    for (let i = 0; i < kValue; i++) {
        const pop = arr.pop();
        arr.unshift(pop);
    }
    return arr;
}

console.log(rotateLeft([1, 2, 3, 4, 5], 2), 'rotating Left'); 
console.log(rotateRight([1, 2, 3, 4, 5], 2), 'rotating Right'); 

// Balanced Parentheses
const balancedParantheses = (data) => {
    const arrData = data.split('');
    const checkingArr = [];
    const pairs = {
        ')': '(',
        '}': '{',
        ']': '[',
    };
    for (const value of arrData) {
        if (value === '(' || value === '{' || value === '[') {
            checkingArr.push(value);
        } else {
            const pop = checkingArr.pop();
            if (pop !== pairs[value]) {
                return false;
            }
        }
    }
    return checkingArr.length === 0;
}
const checkParantheses = balancedParantheses('({[([])]})');
console.log(checkParantheses ? 'Proper Parantheses': 'Im-Proper Parantheses');

// Find Missing Number in an Array
const findMissingArr = (data, n) => {
    const expectedValue = (n * (n + 1))/2;
    const actualValue = data.reduce((acc, value) => acc+value, 0);
    const checkMissingValue = expectedValue-actualValue;
    return checkMissingValue === 0 ? 'All settled' : checkMissingValue
}
const findMissArr = [1,2,3,5];
const callMissFun = findMissingArr(findMissArr, 5);
console.log('The Missing Element Status is ', callMissFun);

// Find Intersection in 2 Arrays
const intersection = (arr1, arr2) => {
    const intersectionArr = [];
    const newArr1 = Array.from(new Set(arr1));
    const newArr2 = Array.from(new Set(arr2));
    for (const newArrOne of newArr1) {
        if (newArr2.includes(newArrOne)) {
            intersectionArr.push(newArrOne);
        }
    }
    return intersectionArr;
}

console.log(intersection([1,,3,5,7,9], [0,8,6,4,2,1,3,5]), 'intersectionArr');

const findKthLargestNo = (datas, n) => {
    const data = datas;
    for (let i=0; i < data.length; i++) {
        for (let j=0; j < data.length-i-1; j++) {
            if (data[j] < data[j+1]) {
                const temp = data[j];
                data[j] = data[j+1];
                data[j+1] = temp;
            }
        }
    }
    return `The ${n} largest is ${data[n-1]} from ${data}`;
}
console.log(findKthLargestNo([4,74,25,53,25,12,24,25,2,422,1], 100));


const groupAnagrams = (words) => {
  const map = new Map();

  for (const word of words) {
    console.log(word, word.split(''), 'wordword', word.split('').sort());
    // Sort the characters of the word to get a key
    const key = word.split('').sort().join('');
    // Add the word to the group with the same sorted key
    if (!map.has(key)) {
      map.set(key, []);
    }
    console.log(map.get(key), 'mappppp');
    
    map.get(key).push(word);
  }

  // Convert the map values to an array of groups
  return Array.from(map.values());
};

const input = ["eat", "tea", "tan", "ate", "nat", "bat"];
const result = groupAnagrams(input);
console.log(result);

