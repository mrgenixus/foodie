var ReceipesMainView = Backbone.View.extend({
  el: "#app",

  root: "/receipes"

});

var ReceipeModel = Backbone.Model.extend({});

var ReceipesCollection = Backbone.Collection.extend({
  url: 'receipes',
  model: ReceipeModel
});

var Router = Backbone.Router.extend({

  routes: {
    '': 'index',
    'receipes/new': 'new',
    'new': 'new'
  },

  index: function(){
    console.log('yup');
  },

  new: function(){
    $('.receipe-add').removeClass('hidden');
  }

});

var router = new Router();
var app = new ReceipesMainView();
$(_.bind(Backbone.history.start, Backbone.history));

$(document).on("click", "a:not([data-bypass])", function(evt) {
  var href = { prop: $(this).prop("href"), attr: $(this).attr("href") };
  var root = location.protocol + "//" + location.host + app.root;

  if (href.prop && href.prop.slice(0, root.length) === root) {
    evt.preventDefault();
    Backbone.history.navigate(href.attr, true);
    console.log(href.attr);
  }
});