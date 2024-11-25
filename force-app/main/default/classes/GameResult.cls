public class GameResult {
    public static void methodName () {
        List<Game__c> gameList = [SELECT Id, Name, Player1__C, Player2__c, Status__c FROM Game__c 
                                  WHERE Player1__c != NULL AND Player2__c != NULL
                                 ];
   
        for (Game__c gameInstance: gameList) {
            if(gameInstance.Player1__c == gameInstance.Player2__c) {
                gameInstance.Status__c = 'Draw';
            }
            else if ( (gameInstance.Player1__c == 'Rock' && gameInstance.player2__c == 'Scissor') || (gameInstance.Player1__c == 'Paper' && gameInstance.player2__c == 'Rock') || (gameInstance.Player1__c == 'Scissor' && gameInstance.player2__c == 'Rock')) {
                gameInstance.Status__c = 'Player1 Won';
            }
            else {
                gameInstance.Status__c = 'Player2 Won';
            }
        }
        update gameList;
        
    } 
}