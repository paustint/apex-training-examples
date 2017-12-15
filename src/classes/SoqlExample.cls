public with sharing class SoqlExample {


	public static void execute() {

		// SELECT Id, Name, Type FROM Account

		List<Account> accounts = [
			SELECT Id, Name, Type
			FROM Account
		];

		for(Account account : accounts) {
			account.Type = 'Technology Partner';
			System.debug(account);
		}

		//for(List<Account> accounts : [SELECT Id, Name, Type FROM Account]) {
		//	for(Account account : accounts) {
		//		account.Type = 'Technology Partner';
		//		System.debug(account);
		//	}
		//}

		update accounts;
	}

	public static void relationshipQuery() {

		List<Contact> contacts = [
			SELECT Id, Name,
				Account.Name, Account.Type,
				Sibling_Account__c, Sibling_Account__r.Id, Sibling_Account__r.Name,
				Sibling_Account__r.Industry
			FROM Contact
			WHERE Account.Id = '0011I00000Dc3V1'
		];

		System.debug('contacts: ' + contacts);

		// loop contacts
		// if sibling account exists, update industry to 'Agriculture'
		List<Account> accountsToUpdate = new List<Account>();
		for(Contact contact : contacts) {
			if(contact.Sibling_Account__c != null) {
				Account account = contact.Sibling_Account__r;
				account.Industry = 'Agriculture';
				accountsToUpdate.add(account);

				System.debug('Updating undustry on sibling account: ' + account);
			}
		}

		if(accountsToUpdate.size() > 0) {
			update accountsToUpdate;
		}

		
	}

	public static void printOutOppInfo() {

		// requirements:
		// query ALL quote lines
		// For each quote line
		// Print to the console the name of the opportunity and the stage of the opportunity

		// TODO!!! complete assignment
		
		List<SBQQ__QuoteLine__c> quoteLines = [
			SELECT Id,
				// Query relationship from quote line to quote to opportunity
				SBQQ__Quote__r.SBQQ__Opportunity2__r.Name,
				SBQQ__Quote__r.SBQQ__Opportunity2__r.StageName
			FROM SBQQ__QuoteLine__c
		];

		for(SBQQ__QuoteLine__c quoteLine : quoteLines) {
			Opportunity opp = quoteLine.SBQQ__Quote__r.SBQQ__Opportunity2__r;
			System.debug('Opp name: ' + opp.Name + ' - Stage: ' + opp.StageName);
		}

	}


	public static void childRelationshipExample() {

		List<SBQQ__Quote__c> quotes = [
			SELECT Id, Name,
				(SELECT Id, Name FROM SBQQ__LineItems__r)
			FROM SBQQ__Quote__c
		];

		for(SBQQ__Quote__c quote : quotes) {
			
			System.debug('quote name: ' + quote.name);

			List<SBQQ__QuoteLine__c> quoteLines = quote.SBQQ__LineItems__r;

			for(SBQQ__QuoteLine__c quoteLine : quoteLines) {
				System.debug('quote line name: ' + quoteLine.name);
			}

		}

	}



}







