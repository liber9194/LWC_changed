public with sharing class AccountAmountController {
    @AuraEnabled(cacheable = true)
    public static Decimal getTotalAmount(Id accountId)
    {
        if(accountId == null)
        {
            return 0.0;
        }

        /*
        List<Quote> approvedQuotes = [SELECT TotalPrice
                                     FROM Quote
                                     WHERE AccountId = :accountId
                                     AND Status IN ('Approved')];*/
        List<Opportunity> closedOpp = [SELECT Amount
                                      FROM Opportunity
                                      WHERE AccountId = :accountId
                                      AND StageName IN ('Closed Won')];
        
        Decimal totalPrice = 0;

        /*
        for(Quote q : approvedQuotes)
        {
            totalPrice += q.TotalPrice;
        }*/

        for(Opportunity opp : closedOpp)
        {
            totalPrice += opp.Amount;
        }

        return totalPrice;
    }
}