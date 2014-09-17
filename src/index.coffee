mongoose = require 'mongoose'

Aggregate = require 'mongoose/lib/aggregate.js'

module.exports.count = 20

mongoose.Query.prototype.paginate = (count = module.exports.count, next_max_id) ->
  if next_max_id
    this.where
      _id: { $lt: next_max_id}
  this.limit count

Aggregate.prototype.paginate = (count = module.exports.count, next_max_id) ->
  if next_max_id
    this.match
      _id: { $lt: next_max_id}
  this.limit count
