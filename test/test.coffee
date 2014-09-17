paginate = require '..'
chai = require 'chai'
mongoose = require 'mongoose'
fixtures = require 'pow-mongoose-fixtures'

chai.should()
mongoose.connect 'mongodb://127.0.0.1/mongoose-ranged-paginate'

mongoose.connection.on 'error', (err) ->
  err.should.to.be.null


ObjectId = mongoose.Types.ObjectId
FooSchema = new mongoose.Schema { bar: String }
FooModel = mongoose.model 'Foo', FooSchema


result = ''
foos = {}


describe 'Ranged Paginate', ->

  before (done) ->
    foos['Foo'] = {}

    for num in [1..100]
      foos.Foo["foo#{num}"] =
        _id: new ObjectId()
        bar: "#{num}"

    fixtures.load foos, mongoose.connection, () ->
      done()


  describe 'when paginate Query', ->

    describe 'Arguments with next_max_id and count', ->

      before (done) ->
        FooModel.find()
          .paginate 2, foos.Foo.foo5._id
          .exec (err, foos) ->
            result = foos
            done()

      it 'should return limited count of objects', ->
        result.length.should.equal 2

      it 'returned objects are paginated', ->
        result[0].bar.should.equal '4'
        result[1].bar.should.equal '3'

    describe 'Arguments with count only', ->

      before (done) ->
        FooModel.find()
          .paginate 2
          .exec (err, foos) ->
            result = foos
            done()

      it 'should return limited count of objects', ->
        result.length.should.equal 2

      it 'returned objects are paginated', ->
        result[0].bar.should.equal '100'
        result[1].bar.should.equal '99'

    describe 'with no arguments', ->

      before (done) ->
        FooModel.find()
          .paginate()
          .exec (err, foos) ->
            result = foos
            done()

      it 'should return limited count of objects', ->
        result.length.should.equal 20

      it 'returned objects are paginated', ->
        result[0].bar.should.equal '100'
        result[1].bar.should.equal '99'

    describe 'with no arguments and set default count', ->

      before (done) ->
        paginate.count = 10
        FooModel.find()
          .paginate()
          .exec (err, foos) ->
            result = foos
            done()

      after ->
        paginate.count = 20

      it 'should return limited count of objects', ->
        result.length.should.equal 10


  describe 'when paginate Aggregate', ->

    describe 'Arguments with next_max_id and count', ->

      before (done) ->
        FooModel.aggregate()
          .paginate 2, foos.Foo.foo5._id
          .exec (err, foos) ->
            result = foos
            done()

      it 'should return limited count of objects', ->
        result.length.should.equal 2

      it 'objects are paginated', ->
        result[0].bar.should.equal '4'
        result[1].bar.should.equal '3'


    describe 'Arguments with count only', ->

      before (done) ->
        FooModel.aggregate()
          .paginate 2
          .exec (err, foos) ->
            result = foos
            done()

      it 'should return limited count of objects', ->
        result.length.should.equal 2

      it 'returned objects are paginated', ->
        result[0].bar.should.equal '100'
        result[1].bar.should.equal '99'

    describe 'with no arguments', ->

      before (done) ->
        FooModel.aggregate()
          .paginate()
          .exec (err, foos) ->
            result = foos
            done()

      it 'should return limited count of objects', ->
        result.length.should.equal 20

      it 'returned objects are paginated', ->
        result[0].bar.should.equal '100'
        result[1].bar.should.equal '99'

    describe 'with no arguments and set default count', ->

      before (done) ->
        paginate.count = 10
        FooModel.aggregate()
          .paginate()
          .exec (err, foos) ->
            result = foos
            done()

      after ->
        paginate.count = 20

      it 'should return limited count of objects', ->
        result.length.should.equal 10
