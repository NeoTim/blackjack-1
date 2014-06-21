class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop()).last()
    if (@scores().every (s) -> s > 21)
      @trigger 'bust'
      return
    do @act

  stand: ->
    console.log 'in hand collection'
    @trigger 'standEvent', @isDealer
  

  # playToWin: ->
  #   @first().flip()
  #   if @scores()[0] < 17
  #     @hit()
  #     playToWin()
  #   else stand()

  act: ->
    if @isDealer 
      if (@scores().every ( s ) -> s < 17 )
        console.log('Back in Collection')
        do @hit
      else 
        do @stand

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]


  bestScore: ->
    if @scores().length is 1 then currScore = @score()
    else if 16   < @scores()[1] < 21 then currScore = @scores()[1]
