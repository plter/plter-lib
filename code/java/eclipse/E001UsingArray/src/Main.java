import com.plter.lib.java.lang.Array;
import com.plter.lib.java.lang.ArrayLoopCallback;


public class Main {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
		final Array<String> arr = new Array<String>();
		
		arr.push("Haha");
		arr.insert("Ha", 0);
		arr.push("end");
//		arr.remove(0);
		
//		arr.clear();
		
		
//		for (int i = 0; i < arr.length(); i++) {
//			System.out.println(arr.get(i));
//			if (i==1) {
//				arr.insert("Hello",0);
//			}
//		}
		
		
		arr.each(new ArrayLoopCallback<String>() {
			int i = 0;
			
			@Override
			public void onRead(String current) {
				System.out.println(current);
				
				i++;
				if (i==1) {
//					arr.insert("hi", 0);
					arr.push("hi");
				}
				
				if (i==2) {
					break_();
				}
			}
		});
		
		System.out.println(arr.length());
		
		System.out.println(arr.indexOf("Ha"));
	}

}
