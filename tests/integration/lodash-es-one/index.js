import {every} from 'lodash-es'

console.log('All primes?', every([2, 11], isPrime) ? 'yes' : 'nope')
