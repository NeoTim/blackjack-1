class window.AppView extends Backbone.View

  template: _.template '
    <div class="col-md-8 col-md-offset-2">
      <div class="panel">
        <div class="btn-group btn-group-justified">
          <div class="btn-group">
            <button class="hit-button btn btn-info">Hit</button>
          </div>
          <div class="btn-group">
            <button class="stand-button btn btn-warning">Stand</button>
          </div>
        </div>
      </div>
    </div>
    <div class="col-md-8 col-md-offset-2">
      <div class="panel">
        <div class="player-hand-container"></div>
      </div>
      <div class="panel">
        <div class="dealer-hand-container"></div>
      </div>
    </div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()

  initialize: ->
    @render()

    @model.on 'win', ->
      $('.modal').find('h1').text('YOU WON!!')
      $('.modal').modal 'show'
    @model.on 'lose', ->
      $('.modal').find('h1').text('FUCK YOU!!')
      $('.modal').modal 'show'
    @model.on 'push', ->
      $('.modal').find('h1').text('PUSH!!')
      $('.modal').modal 'show'

    $('.modal').on 'click', '.btn-primary', ->
      do restart

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
