public with sharing class AccountEscalCaseController {
    @AuraEnabled(cacheable=true)
    public static Integer getEscalCaseCount(Id accountId)
    {
        if(accountId == null)
        {
            return 0;
        }

        Integer EscalCaseCount = [SELECT COUNT()
                                    FROM Case
                                    WHERE AccountId = :accountId
                                    AND Status IN ('Escalated')];
        
        return EscalCaseCount;
    }
}