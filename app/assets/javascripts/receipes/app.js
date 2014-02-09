var ReceipesMainView = Backbone.View.extend({
  el: "#app"
});

var ReceipeModel = Backbone.Model.extend({});

var ReceipesCollection = Backbone.Collection.extend({
  url: 'receipes',
  model: ReceipeModel
});

var Router = Backbone.Router.extend({

  routes: {
    '': 'index'
  },

  index: function(){
    console.log('yup');
  }

});

var router = new Router();
var app = new ReceipesMainView();
$(_.bind(Backbone.history.start, Backbone.history));