const str = "Hellow JS";

// Length
const strLength = str.length;
console.log('The length of string value is', strLength);

// charAt
const strCharAt = str.charAt(0);
console.log('The charAt of gie position', strCharAt);

// charCodeAt
const charCodeAt = str.charCodeAt(1);
console.log('charCodeAt', charCodeAt);

// at
const At = str.at(1);
console.log('At', At);

// toLowerCase
const strToLowerCase = str.toLowerCase();
console.log('Convert all string characterto Loweer Case', strToLowerCase);

// toUpperCase
const strUpperCase = str.toUpperCase();
console.log('to Upper Case', strUpperCase);

// concat
const str2 = 'World'
const concat = str.concat(str2);
console.log('concat', concat);

// trim
const str3 = " Hai Arun How Are You "
const trim = str3.trim();
console.log('beforeTrim', str3);
console.log('trim', trim, 'Is Trimed');

// trimStart
const trimStart = str3.trimStart();
console.log('trimStart', trimStart, 'Is Trimed');

// trimEnd
const trimEnd = str3.trimEnd();
console.log('trimEnd', trimEnd, 'Is Trimed');

// padStart 7 length if any space is available then the second index will get allocate at start
console.log('Hi'.padStart(7,'0') );

// padEnd -> Totaly 5 length if any space is available then the second index will get allocate at last
console.log('hi'. padEnd(5,'k'));

// repeat
console.log('hi'.repeat(3))

// replace
console.log('hi arun, how are you arun ?'.replace('arun', 'Kutty Arun'));

// replaceAll
console.log('hi arun, how are you arun ?'.replaceAll('arun', 'Kutty Arun'));

// split & toString
const splitString = "1,2,3,4,4,5,6,6";
const splitResult = splitString.split(',');
console.log('splitResult',splitResult);
const arrayToSting = splitResult.toString();
console.log('arrayToSting', arrayToSting);

// slice 
//  J  a  v  a  S  c  r  i  p  t
//  0  1  2  3  4  5  6  7  8  9
// -10-9 -8 -7 -6 -5 -4 -3 -2 -1
let stre = "JavaScript";
let result = stre.slice(-5,-2);
let positive = stre.slice(1,2)
console.log('result', result); // "Scr"
console.log('positive', positive);

// substring not working with -ve values
const posResult = stre.substring(1,2)
console.log('posResult', posResult);

// substr -> 1st position is staring index, 2nd position is length
const strSub = stre.substr(5,2);
console.log('strSub', strSub);

// indexOF
console.log('indexOf', stre.indexOf('J'))
console.log('lastIndexOf', stre.lastIndexOf('a')).         

// Search -> Return the starting Postion of index
console.log('search', stre.search(/a/));

// match
console.log('match ->> ', stre.match(/Jav/).input, stre.match(/Jav/))

// 