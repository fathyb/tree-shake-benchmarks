# tree-shake-benchmarks

A suite of benchmarks to evaluate the code size efficiency of the three most popular bundlers.

## Disclaimer

- Safe but experimental features are enabled
- Unfair benchmarks are encouraged (eg. unit-json)
- We don't check if the final bundle works correctly yet

## Results

<!--BENCH-AUTOGEN:BEGIN-->


| Test | Parcel | Rollup | Webpack |
| ---- | ------ | ------ | ------- |
| [integration - lodash-es-all](./tests/integration/lodash-es-all) | 70K | 85K | 95K |
| [integration - lodash-es-one](./tests/integration/lodash-es-one) | 14K | 80K | 16K |
| [integration - react-material-ui](./tests/integration/react-material-ui) | 158K | 403K | 202K |
| [integration - react-minimal](./tests/integration/react-minimal) | 100K | 287K | 99K |
| [unit - json](./tests/unit/json) | 5.0M | 354B | 5.0M |
| [unit - overhead](./tests/unit/overhead) | 27B | 55B | 978B |


<!--BENCH-AUTOGEN:END-->

## Contribute

> A UNIX env and Yarn are required

### Run benchmarks locally

- `yarn`
- `yarn bench`
    - if you want the full logs `yarn bench --verbose`

### Add a benchmark

Create a new folder under `tests/unit` or `tests/integration` depending on if you require external dependencies.
