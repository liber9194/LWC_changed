public with sharing class AccountAmountController {
    @AuraEnabled(cacheable = true)
    public static Decimal getTotalAmount(Id accountId)
    {
        if(accountId == null)
        {
            return 0.0;
        }

        List<Quote> approvedQuotes = [SELECT TotalPrice
                                     FROM Quote
                                     WHERE AccountId = :accountId
                                     AND Status IN ('Approved')];
        
        Decimal totalPrice = 0;

        for(Quote q : approvedQuotes)
        {
            totalPrice += q.TotalPrice;
        }

        return totalPrice;
    }
}