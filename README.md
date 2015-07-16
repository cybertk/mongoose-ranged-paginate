## mongoose-ranged-paginate

Mongoose ORM Document Pagination Based on Ranged Query

[![Build Status](http://img.shields.io/travis/cybertk/mongoose-ranged-paginate.svg?style=flat)](https://travis-ci.org/cybertk/mongoose-ranged-paginate)
[![Dependency Status](https://david-dm.org/cybertk/mongoose-ranged-paginate.svg)](https://david-dm.org/cybertk/mongoose-ranged-paginate)
[![devDependency Status](https://david-dm.org/cybertk/mongoose-ranged-paginate/dev-status.svg)](https://david-dm.org/cybertk/mongoose-ranged-paginate#info=devDependencies)
[![Coverage Status](https://img.shields.io/coveralls/cybertk/mongoose-ranged-paginate.svg)](https://coveralls.io/r/cybertk/mongoose-ranged-paginate)

## Features

- next_max_id
- count

## Installation

[Node.js][] and [NPM][] is required.

    $ npm install mongoose-ranged-paginate

[Node.js]: https://npmjs.org/
[NPM]: https://npmjs.org/

## Usage

To get 20 **MyModel**s started from `1cdfb22e1f3c000000003152`,

```js
require('mongoose-ranged-paginate')

MyModel.find()
    .sort('-_id')
    .paginate(20, '1cdfb22e1f3c000000003152')
    .exec(function (err, models) {
    };
```

To get 20 latest **MyModel**s

```js
require('mongoose-ranged-paginate')

MyModel.find()
    .paginate(20)
    .exec(function (err, models) {
    };
```

Or set default count via `paginate.count`

```js
paginate = require('mongoose-ranged-paginate')
paginate.count = 20

MyModel.find()
    .paginate()
    .exec(function (err, models) {
    };
```

## Contribution

## Run Tests

    $ npm test

Any contribution is more then welcome!
