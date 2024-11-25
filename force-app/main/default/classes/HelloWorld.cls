public class HelloWorld {
	public String var1 = 'hello1';

	@InvocableMethod(label='Hello World')
	public static void helloWorld(List<Account> accList) {
		System.Debug(accList);
	}

}