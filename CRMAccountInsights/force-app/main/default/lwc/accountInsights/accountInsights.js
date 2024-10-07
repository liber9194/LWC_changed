import { LightningElement, api, wire, track } from 'lwc';
import {getRecord} from 'lightning/uiRecordApi';
import userRatingFIELD from '@salesforce/schema/Account.Rating__c';
import userCreditFIELD from '@salesforce/schema/Account.SnpCreditRating__c'
import snpimage from '@salesforce/resourceUrl/SnpCreditImage'
import getOngoingCaseCount from '@salesforce/apex/AccountCaseController.getOngoingCaseCount';
import getTotalAmount from '@salesforce/apex/AccountAmountController.getTotalAmount';

export default class AccountInsights extends LightningElement {
    @api recordId;
    rating = '미설정';
    totalAmount = 0;
    totalCase = 0;
    credit = '해당 없음';
    snpIcon = snpimage;

    @wire(getRecord, { recordId: '$recordId', fields: [userRatingFIELD]})
    wiredAccount({error, data})
    {
        if(data)
        {
            this.rating = data.fields.Rating__c.value;
        }
        else if(error)
        {
            this.error = error;
        }
    }

    @wire(getRecord, {recordId : '$recordId', fields: [userCreditFIELD]})
    wiredAccountCredit({error, data})
    {
      if(data)
      {
          this.credit = data.fields.SnpCreditRating__c.value;
      }
      else if(error)
      {
        this.error = error;
      }
    }

    @wire(getOngoingCaseCount, {accountId : '$recordId'})
    wiredCaseCount({data,error})
    {
      if(data)
      {
        this.totalCase = data;
      }
      else if(error)
      {
        this.totalCase = 0;
        console.error('Case 에러발생', error);
      }
    }
    
    @wire(getTotalAmount, {accountId : '$recordId'})
    wiredAmountCount({data,error})
    {
      if(data)
      {
        this.totalAmount = data;
      }
      else if(error)
      {
        this.totalAmount = 0;
        console.error('Amount 에러발생', error);
      }
    }
}