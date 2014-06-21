highestUnder21 = ( hand ) ->
  _.max hand.scores().filter ( s ) ->
    s <= 21

class window.App extends Backbone.Model

  initialize: ->
    @set 'playerBet', 0
    @set 'playerTotal', 1000
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()


    @get('playerHand').on 'standEvent', =>
      @get('dealerHand').act()

    @get('playerHand').on 'bust', => 
      @trigger 'lose'

    @get('dealerHand').on 'standEvent', =>
      # if @get('dealerHand').scores() > @get('playerHand').scores()
        # console.log('yolo')
        playerTotal = highestUnder21 @get( "playerHand" )
        dealerTotal = highestUnder21 @get( "dealerHand" )

        if dealerTotal > playerTotal
          @trigger "lose"
        else if dealerTotal < playerTotal
          @trigger "win"
        else
          @trigger "push"

    @get('dealerHand').on 'bust', ( hand ) => 
      @trigger 'win'

    # @get('playerHand').on 'betEvent', ( val ) =>
    #   @set 'playerBet', @get('playerBet') + val
    #   @set 'playerTotal', @get('playerTotal') - val
    #   console.log 'total', @get 'playerTotal'
    #   console.log 'bet', @get 'playerBet'
    @
