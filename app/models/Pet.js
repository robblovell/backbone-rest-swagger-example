// Generated by CoffeeScript 1.6.3
(function() {
  var Backbone, Pet, _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Backbone = require('backbone');

  Pet = (function(_super) {
    __extends(Pet, _super);

    function Pet() {
      _ref = Pet.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Pet.prototype.urlRoot = 'mongodb://127.0.0.1:27017/animal';

    Pet.prototype.sync = require('backbone-mongo').sync(Pet);

    return Pet;

  })(Backbone.Model);

  module.exports = Pet;

}).call(this);

/*
//@ sourceMappingURL=Pet.map
*/
