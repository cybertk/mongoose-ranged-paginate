require '..'
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
foos = ''


describe 'Ranged Paginate', ->

  before (done) ->

    foos =
      Foo:
        foo1:
          _id: new ObjectId()
          bar: '1'
        foo2:
          _id: new ObjectId()
          bar: '2'
        foo3:
          _id: new ObjectId()
          bar: '3'
        foo4:
          _id: new ObjectId()
          bar: '4'
        foo5:
          _id: new ObjectId()
          bar: '5'

    fixtures.load foos, mongoose.connection, () ->
      done()


  describe 'when paginate Query with next_max_id and count', ->

    before (done) ->

      FooModel.find()
        .paginate(2, foos.Foo.foo5._id)
        .exec (err, foos) ->
          result = foos
          done()

    it 'should return limited count of objects', ->
      result.length.should.equal 2

    it 'objects are paginated', ->
      result[0].bar.should.equal '4'
      result[1].bar.should.equal '3'


  describe 'when paginate Aggregate with next_max_id and count', ->

    before (done) ->

      FooModel.aggregate()
        .paginate(2, foos.Foo.foo5._id)
        .exec (err, foos) ->
          result = foos
          done()

    it 'should return limited count of objects', ->
      result.length.should.equal 2

    it 'objects are paginated', ->
      result[0].bar.should.equal '4'
      result[1].bar.should.equal '3'
