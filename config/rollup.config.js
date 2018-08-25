import resolve from 'rollup-plugin-node-resolve'
import commonjs from 'rollup-plugin-commonjs'
import json from 'rollup-plugin-json'

export default {
  plugins: [
    json(),
    commonjs(),
    resolve({
      module: true,
      jsnext: true,
      main: true,
      browser: true
    })
  ]
}
