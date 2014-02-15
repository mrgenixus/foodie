var NewVenueView = Backbone.View.extend({
  el: '#new_venue_modal',

  initialize: function(options){
      this.$el.modal({show: false});
      this.$el.on('hidden', _.partial(this.trigger, 'hidden'));
  },

  events: {
    'ajax:success form': 'save_success',
    'click .btn-default':  'submit_form'
  },

  render: function(options){
    this.success_callback = _.isFunction(options.callback) ? options.callback : function(){};
    this.show();
    return this.$el;
  },

  save_success: function(e, data){
    Backbone.trigger("venue:add", data.venue);
    this.success_callback(data.venue);
    this.reset_modal();
  },

  reset_modal: function () {
    this.$('form').each(function(i,form){
        $.each(form.elements,function(i,el){
          $(el).val('');
        });
      });
    this.hide();
  },

  show: function() {
    this.$el.modal('show');
  },

  hide: function() {
    this.$el.modal('hide');
  },

  submit_form: function(){
    this.$('form').submit();
  }

});

var AddMealFormView = Backbone.View.extend({

  initialize: function(options){
    this.add_venue_modal = options.add_venue_modal;
    this.$venues_select = this.$('select.venue_select');
    this.initializeEvents();
  },

  initializeEvents: function(){
    this.listenTo(Backbone, 'venue:add', this.add_venue_option, this);
  },

  events: {
    'click .add_new_venue': 'add_venue',
    'click .invite_new_user': 'noop',
    'click .select_receipe': 'noop'
  },

  add_venue: function(e){
    this.add_venue_modal.render({callback: _.bind(this.select_venue, this) });
  },

  select_venue: function(venue){
    this.$venues_select.find('option').prop('selected', false);
    this.$venues_select.find('[value=' + venue.id + ']').prop('selected', 'true');
  },

  build_venue_option: function(venue){
    return $('<option>').val(venue.id).text(venue.name);
  },

  add_venue_option: function(venue, view){
    var option = this.build_venue_option(venue);
    this.$venues_select.append(option);

    return option;
  },

  noop : function(){}

});

var AddMealsFormView = Backbone.View.extend({
  initialize: function(options){
    var this_view = this;
    this.add_venue_modal = new NewVenueView({el: "#new_venue_modal"});
    this.addMealViews = this.$('.meal-block').map(function(i, meal_block_element){

      return new AddMealFormView({
        el: meal_block_element,
        add_venue_modal: this_view.add_venue_modal
      });

    });
  }
});

$(function(){
  if ($('#new_plan').length){
    window.addMealsFormView = new AddMealsFormView({ el: '#new_plan'});
  } else {
    window.addMealsFormView = new AddMealsFormView({ el: 'body' });
  }
});