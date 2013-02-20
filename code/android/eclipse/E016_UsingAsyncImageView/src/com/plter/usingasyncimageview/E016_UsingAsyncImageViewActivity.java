package com.plter.usingasyncimageview;

import com.plter.lib.android.java.controls.AsyncImageView;

import android.app.Activity;
import android.os.Bundle;
import android.widget.LinearLayout;

public class E016_UsingAsyncImageViewActivity extends Activity {
	
	private AsyncImageView iv;
	private LinearLayout mainLayout;
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        mainLayout=(LinearLayout) findViewById(R.id.mainLayout);
        iv=new AsyncImageView(this);
        mainLayout.addView(iv, -1, -1);
        
        iv.loadImage("http://www.18fzl.com/uploads/allimg/110315/004U55S4-9.jpg");
    }
}