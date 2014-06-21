highestScore = ( hand ) ->
  _.max hand.scores().filter ( s ) ->
    s <= 21


#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'standEvent', =>
      @get('dealerHand').act();
      #@trigger ''

    @get('playerHand').on 'bust', (hand) => 
      @trigger 'lose'

    @get('dealerHand').on 'standEvent', =>
      playerTotal = highestScore @get( "playerHand" )
      dealerTotal = highestScore @get( "dealerHand" )
      if dealerTotal > playerTotal
          @trigger "lose"
        else if dealerTotal < playerTotal
          @trigger "win"
        else
          @trigger "push"

    @get('dealerHand').on 'bust', ( hand ) =>
      @trigger 'win'


    # @get('playerHand').on 'bust', -> @trigger 'win:dealer'
    # @get('playerHand').on 'standEvent', -> @get('dealerHand').playToWin()
    # @get('dealerHand').on 'bust', -> @trigger 'win:player'
    # @get('dealerHand').on 'standEvent', ->
    #   @trigger if @get('playerHand').maxScore() < @get('dealerHand').maxScore()
    #     'win:player'
    #   else if 
    #     'win:dealer'
    #   else
    #     'push'