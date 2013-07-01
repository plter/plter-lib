package com.plter.usingxml;

import java.io.IOException;
import java.io.InputStream;

import android.app.Activity;
import android.os.Bundle;

import com.plter.lib.java.xml.XML;
import com.plter.lib.java.xml.XMLList;
import com.plter.lib.java.xml.XMLRoot;

public class E022_UsingXMLActivity extends Activity {
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        InputStream is = getResources().openRawResource(R.raw.data);
        try {
			byte[] bytes=new byte[is.available()];
			is.read(bytes);
			
			String str = new String(bytes,"utf-8");
			
			XMLRoot root = XMLRoot.parse(str);
			System.out.println("root tag : "+root.getName());
			System.out.println("root num : "+root.getAttr("num"));
			System.out.println("root.people :>>>>>>>>>>>>>>>>>>");
			XMLList people = (XMLList) root.getChild("people");
			for (XML x : people.getChildren()) {
				System.out.println("name : "+x.getAttr("name")+";age : "+x.getAttr("age")+";sex : "+x.getAttr("sex"));
			}
			System.out.println("root.people :<<<<<<<<<<<<<<<<<<");
			System.out.println("root.other : "+root.getChild("other").getText());
		} catch (IOException e) {
			e.printStackTrace();
		}
    }
}