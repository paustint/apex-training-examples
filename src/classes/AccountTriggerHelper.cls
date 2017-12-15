public with sharing class AccountTriggerHelper {

	public static void handleBeforeInsert(List<Account> accounts) {
		System.debug('handleBeforeInsert()');

	}

	public static void handleAfterInsert(List<Account> accounts, Map<Id, Account> oldAccountMap) {
		System.debug('handleAfterInsert()');

	}

	public static void handleBeforeUpdate(List<Account> accounts, Map<Id, Account> oldAccountMap) {
		System.debug('handleBeforeUpdate()');

	}

	public static void handleAfterUpdate(List<Account> accounts, Map<Id, Account> oldAccountMap) {
		System.debug('handleAfterUpdate()');
		//checkForBillingAddrChange(accounts, oldAccountMap);
		
	}


	private static void checkForBillingAddrChange(List<Account> accounts, Map<Id, Account> oldAccountMap) {

		// Loop account
		// compare new and old to see if billing address field changed
		// if changed
		// Get list of contacts for changed account
		// Query contacts
		// Update fields
		// perform DML
		Set<Id> accountIds = new Set<Id>();
		
		Map<Id, Account> newAccountMap = new Map<Id, Account>(accounts);

		for(Account account : accounts) {
			Account oldAccount = oldAccountMap.get(account.Id);
			
			if(compareField('BillingStreet', account, oldAccount) ||
				compareField('BillingState', account, oldAccount) ||
				compareField('BillingPostalCode', account, oldAccount) ||
				compareField('BillingCity', account, oldAccount)) {
					System.debug('Account address was changed ' + account);
					accountIds.add(account.Id);
			}
		}

		if(accountIds.size() > 0) {
			List<Contact> contacts = [SELECT Id, AccountId FROM Contact WHERE AccountId IN :accountIds];
			// update address fields on contact
			for(Contact contact : contacts) {
				Account account = newAccountMap.get(contact.AccountId);
				contact.MailingStreet = account.BillingStreet;
				contact.MailingState = account.BillingState;
				contact.MailingCity = account.BillingCity;
				contact.MailingCountry = account.BillingCountry;
				contact.MailingPostalCode = account.BillingPostalCode;
				System.debug('Updating contact mailing address: ' + contact);
			}

			if(contacts.size() > 0) {
				update contacts;
			}
		}
	}

	private static Boolean compareField(String fieldName, SObject newObj, SObject oldObj) {
		Object newVal = newObj.get(fieldName);
		Object oldVal = oldObj.get(fieldName);
		System.debug('newVal ' + newVal);
		System.debug('oldVal ' + oldVal);
		return newVal != oldVal;
	}

}







