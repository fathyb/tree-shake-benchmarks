import React from 'react';
import ReactDOM from 'react-dom';
import Button from '@material-ui/core/Button';

function App() {
    return React.createElement(
        Button,
        {variant: 'raised', color: 'primary'},
        'Hello World'
    )
}

const root = document.createElement('div')

document.body.appendChild(root)

ReactDOM.render(React.createElement(App), root)