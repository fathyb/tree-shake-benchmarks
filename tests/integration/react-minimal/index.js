import React from 'react'
import ReactDOM from 'react-dom'

const root = document.createElement('div')

document.body.appendChild(root)

ReactDOM.render(
    React.createElement('div', null, 'Hello world!'),
    root
)
