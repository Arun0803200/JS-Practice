const arr = [8,37,1526,10,2,42];
for (i=0;i<arr.length; i++) {
    for (j=0;j<arr.length-1-i;j++) {
        if (arr[j] > arr[j+1]) {
            const temp = arr[j];
            arr[j] = arr[j+1];
            arr[j+1] = temp;
        }
    }
}
console.log(`${arr[arr.length-1]} is a largest no`)