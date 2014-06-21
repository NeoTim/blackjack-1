cardToDisplay = ( scores ) ->
  u21 = scores.filter ( s ) -> s <= 21
  if u21.length then _.max u21 else _.min scores

class window.HandView extends Backbone.View

  className: 'hand'

  #todo: switch to mustache
  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    @render()



  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text cardToDisplay @collection.scores()
    # @$('.score').text @collection.scores()
    # if @collection.scores()[0] > 21
    #   @$('.score').css('color', 'red');

