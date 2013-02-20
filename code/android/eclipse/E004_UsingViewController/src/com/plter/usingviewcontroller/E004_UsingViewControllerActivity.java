package com.plter.usingviewcontroller;

import com.plter.lib.android.java.anim.AnimationStyle;
import com.plter.lib.android.java.controls.ViewController;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;

public class E004_UsingViewControllerActivity extends Activity {
	
	
	private ViewController rootVc;
	private ViewController mn2Vc;
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        rootVc=new ViewController(this, R.layout.mn1_layout);
        setContentView(rootVc.getViewStack());
        
        mn2Vc=new ViewController(this, R.layout.mn2_layout);
        mn2Vc.setAnimationStyle(AnimationStyle.PUSH);
        
        rootVc.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				rootVc.pushViewController(mn2Vc, true);
			}
		});
        
        mn2Vc.setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				mn2Vc.getPrevious().popViewController(true);
			}
		});
    }
}