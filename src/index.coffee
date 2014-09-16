mongoose = require 'mongoose'

Aggregate = require 'mongoose/lib/aggregate.js'


mongoose.Query.prototype.paginate = (count, next_max_id) ->
  this.sort '-_id'
  this.where
    _id: { $lt: next_max_id}
  this.limit count

Aggregate.prototype.paginate = (count, next_max_id) ->
  this.sort '-_id'
  this.match
    _id: { $lt: next_max_id}
  this.limit count
