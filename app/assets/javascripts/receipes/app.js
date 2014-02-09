var ReceipesMainView = Backbone.View.extend({
  el: "#app"
});

var ReceipesCollection = Backbone.Collection.extend({
  url: 'receipes'
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