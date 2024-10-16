public with sharing class AccountAllCaseController {
    @AuraEnabled(cacheable=true)
    public static Integer getAllCaseCount(Id accountId)
    {
        if(accountId == null)
        {
            return 0;
        }

        Integer AllCaseCount = [SELECT COUNT()
                                    FROM Case
                                    WHERE AccountId = :accountId];
        
        return AllCaseCount;
    }
}