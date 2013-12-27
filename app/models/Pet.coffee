Backbone = require 'backbone'

class Pet extends Backbone.Model
  urlRoot: 'mongodb://127.0.0.1:27017/animal'
  sync: require('backbone-mongo').sync(Pet)

module.exports = Pet
