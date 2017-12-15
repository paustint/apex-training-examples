public class MyFirstClass {

	public static void execute() {

		System.debug('I am doing a lot of business logic');

		List<String> myStrings = new List<String>();
		myStrings.add('foo');
		myStrings.add('bar');
		myStrings.add('baz');


		List<String> myStringsWithInitValues = new List<String>{'foo', 'bar', 'baz'};

		System.debug('myStrings: ' + myStrings);
		System.debug('myStringsWithInitValues: ' + myStringsWithInitValues);

		Map<String, String> someStringMap = new Map<String, String>();
		someStringMap.put('foo', 'some value');

		Map<String, String> someStringMapWithInitValues = new Map<String, String>{
			'foo' => 'some value',
			'bar' => 'some other value'
		};

		System.debug('someStringMap: ' + someStringMap);
		System.debug('someStringMapWithInitValues: ' + someStringMapWithInitValues);


		for(Integer i = 0; i < myStrings.size(); i++) {
			System.debug('i = ' + i);
		}

		for(String currString : myStrings) {
			System.debug(currString);
		}

	}


}