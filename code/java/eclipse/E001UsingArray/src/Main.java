import com.plter.lib.java.lang.Array;
import com.plter.lib.java.lang.ArrayIterator;


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
		
		int i=0;
		for(ArrayIterator<String> it = arr.begin();it.nextItem!=arr.end();it=it.nextItem){
			
			i++;
			if (i==1) {
//					arr.insert("hi", 0);
				arr.push("hi");
			}
			
			if (i==2) {
				break;
			}
			
		}
		
		System.out.println(arr.length());
		
		System.out.println(arr.indexOf("Ha"));
	}

}
