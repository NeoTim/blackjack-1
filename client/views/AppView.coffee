class window.AppView extends Backbone.View

  template: _.template "
    <div class='col-md-8 col-md-offset-2'>
      <div class='panel'>
        <div clss='btn-group'>
          <button class='hit-button btn btn-primary'>Hit</button>
          <button class='stand-button btn btn-warning'>Stand</button> 
        </div>
      </div>
    </div>
    <div class='info-container'></div>
    <div class='col-md-8 col-md-offset-2'>
      <div class='panel'>
        <div class='player-hand-container'></div>
      </div>
      <div class='panel'>
        <div class='dealer-hand-container'></div>
      </div>
    </div>
  "

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()
    # "click .bet-button": -> @model.get('playerHand').bet $('.bet-select').val()

  initialize: ->
    @render()
    @model.on 'win', =>
      $('.modal').find('h1').text('You Won!!');
      $('.modal').modal('show');
      # do restart
    @model.on 'push', =>
      $('.modal').find('h1').text('DRAW!!!');
      $('.modal').modal('show');
      # alert 'DRAW!!!'
      # do restart
    @model.on 'lose', =>
      $('.modal').find('h1').text('FUCK YOU');
      $('.modal').modal('show');

    $('.modal').on 'click', '.btn', -> 
      do restart
      # do restart
  render: ->

    @$el.children().detach()
    @$el.html @template()
    # @$('.info-container').html(@model.get 'playerBet')
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
