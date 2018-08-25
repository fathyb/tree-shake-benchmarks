#!/bin/bash

set -e

PATH=$PATH:node_modules/.bin

function clear_last_line {
    if [ "$VERBOSE" == "false" ]; then
        tput cuu1
        tput el
    fi
}

function run_yarn {
    script_output=$(script -q /dev/null ./scripts/run_yarn.sh $@ </dev/null | tee /dev/tty)

    if [[ $script_output = *"Yarn exited with a non-zero exit status"* ]]; then
        echo "Error when running \"yarn $@\""
        exit 2
    fi

    lines=$(echo -e "$script_output" | wc -l)

    for (( i = 0; i <= $lines; i++ )); do
        clear_last_line
    done
}

function runner {
    file=$1
    path=$output/$file.js
    min=$output/$file.min.js

    echo "⏳  $path"

    start=$(node -p "Date.now()")
    run_yarn $@
    end=$(node -p "Date.now()")

    clear_last_line
    echo "⏳  $path (minify)"

    run_yarn terser $path \
        --config-file config/terser.config.json \
        --output $min

    size=$(ls -lh "$min" | awk '{print $5}')
    time=$(node -p "($end - $start) / 1000")

    clear_last_line
    echo "✅  $path"
    echo "    ├ ⚓️  ${size}"
    echo "    └ ⏱️  ${time}s"
    echo -n ",$size" >> build/results.csv
}

function runRollup {
    runner rollup $input \
        --config config/rollup.config.js \
        --format iife \
        --name TestBundle \
        --file $output/rollup.js
}

function runParcel {
    runner parcel build $input \
        --experimental-scope-hoisting \
        --no-cache \
        --out-dir $output \
        --out-file parcel.js
}

function runWebpack {
    mkdir -p $output

    runner webpack ./$input \
        --config config/webpack.config.js \
        --output $output/webpack.js
}

VERBOSE=false

for i in "$@"
do
case $i in
    -v|--verbose)
        VERBOSE=true
        shift
        ;;
    *)
        echo "Invalid option \"$i\""
        exit 2
        ;;
esac
done

echo "⏳  Prepare"

rm -rf build .cache
mkdir build
run_yarn install

echo "✅  Prepare"

for type in `cd tests && echo *`; do
    for test in `cd tests/$type && echo *`; do
        input=tests/$type/$test/index.js
        output=build/$type-$test

        echo -n "$type,$test" >> build/results.csv
        runParcel
        runRollup
        runWebpack
        echo >> build/results.csv
    done
done

echo "⏳  Rendering results"

readme=$(cat build/results.csv | node scripts/render)
echo "$readme" > README.md

clear_last_line
echo "✨  Done"
