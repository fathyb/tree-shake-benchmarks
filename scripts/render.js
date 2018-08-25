const fs = require('fs-extra')
const stdin = require('get-stdin')

stdin()
    .then(csv =>
        [
            '\n\n',
            '| Test | Parcel | Rollup | Webpack |',
            '| ---- | ------ | ------ | ------- |',
            ...csv
                .split('\n')
                .map(line => line.trim())
                .filter(Boolean)
                .map(line => line.split(','))
                .map(([type, test, parcel, rollup, webpack]) =>
                    [
                        `[${type} - ${test}](./tests/${type}/${test})`,
                        parcel,
                        rollup,
                        webpack
                    ]
                        .map(line => `| ${line} `)
                        .concat('|')
                        .join('')
                ),
            '\n\n'
        ].join('\n')
    )
    .then(table =>
        fs
            .readFile('README.md', 'utf-8')
            .then(contents =>
                contents.replace(
                    /(<!--BENCH-AUTOGEN:BEGIN-->)(.*)(<!--BENCH-AUTOGEN:END-->)/s,
                    '$1' + table + '$3'
                )
            )
    )
    .then(console.log)
    .catch(console.error)
