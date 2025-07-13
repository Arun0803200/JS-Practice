const personalObject = {
    name: 'aaaaa',
    agg: 23,
    phone: '9748574857',
    city: 'Chennai',
    state: 'Tamil Nadu',
    country: 'India'
}

console.log(Object.keys(personalObject)); // [ 'name', 'agg', 'phone', 'city', 'state', 'country' ]
console.log(Object.values(personalObject)); // [ 'aaaaa', 23, '9748574857', 'Chennai', 'Tamil Nadu', 'India' ]
console.log(Object.entries(personalObject));
/* 
    [
        [ 'name', 'aaaaa' ],
        [ 'agg', 23 ],
        [ 'phone', '9748574857' ],
        [ 'city', 'Chennai' ],
        [ 'state', 'Tamil Nadu' ],
        [ 'country', 'India' ]
    ]
*/
const entries = Object.entries(personalObject);
const object = Object.fromEntries(entries);
console.log(object);
/* {
        name: 'aaaaa',
        agg: 23,
        phone: '9748574857',
        city: 'Chennai',
        state: 'Tamil Nadu',
        country: 'India'
  } */
console.log(Object.hasOwn(personalObject, 'name')); // true
console.log(Object.hasOwn(personalObject, 'salary')); // false
const additionalData = {
    salary: '50000',
    department: 'CSE'
}
console.log(Object.assign(personalObject, additionalData))
/*
    {
  name: 'aaaaa',
  agg: 23,
  phone: '9748574857',
  city: 'Chennai',
  state: 'Tamil Nadu',
  country: 'India',
  salary: '50000',
  department: 'CSE'
}
*/

const obj = Object.freeze({a: 1});
obj.a = 2;
console.log(obj); // Won’t change

// Prevents adding or removing properties, but allows value changes.
const sealed = Object.seal({ a: 1 });
sealed.a = 2;
sealed.b = 3; // Won’t be added
console.log(sealed); // { a: 2 }
