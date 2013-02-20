package com.plter.usinglvca;

import android.content.Context;
import android.view.View;

import com.plter.lib.android.java.anim.AnimationStyle;
import com.plter.lib.android.java.controls.ViewController;

public class Mn2Vc extends ViewController {

	public Mn2Vc(Context context) {
		super(context, R.layout.mn2_layout);
		
		setAnimationStyle(AnimationStyle.PUSH);
		
		findViewByID(R.id.goBackBtn).setOnClickListener(new View.OnClickListener() {
			
			@Override
			public void onClick(View v) {
				getPrevious().popViewController(true);
			}
		});
	}

}
