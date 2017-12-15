public class SObjectExamples {

	public static void createNewAccount() {

		Account account = new Account();
		account.Name = 'New Account 1';


		Account account2 = new Account(Name = 'New Account 2');

		insert account;
		insert account2;

		System.debug('account: ' + account);
		System.debug('account2: ' + account2);
	}


	public static void updateAccountName(Id accountId, String accountName) {
		// show upadting without query
		

		Account account = [
			SELECT Id, Name, Account_Identifier__c
			FROM Account
			WHERE Id = :accountId
		];

		account.Name = accountName;
		update account;

		System.debug('account: ' + account);

	}

	public static void updateAccountNameWithoutQuery(Id accountId, String accountName) {
		// show upadting without query
		
		Account account = new Account(Id=accountId, Name = accountName);

		update account;

		// https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_methods_system_sobject.htm
		account.recalculateFormulas();

		System.debug('account: ' + account);

	}

	public static void upsertExample(String oracleId, String name) {

		Account account = new Account(Name = name, Oracle_Account_Id__c = oracleId);

		upsert account Oracle_Account_Id__c;


	}

}









