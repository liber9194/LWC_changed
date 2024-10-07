public with sharing class AccountCaseController {
    @AuraEnabled(cacheable=true)
    public static Integer getOngoingCaseCount(Id accountId)
    {
        if(accountId == null)
        {
            return 0;
        }

        Integer ongoingCaseCount = [SELECT COUNT()
                                    FROM Case
                                    WHERE AccountId = :accountId
                                    AND Status NOT IN ('Closed')];
        
        return ongoingCaseCount;
    }
}