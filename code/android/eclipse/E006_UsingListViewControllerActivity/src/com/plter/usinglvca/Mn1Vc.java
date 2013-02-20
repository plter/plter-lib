package com.plter.usinglvca;

import android.content.Context;
import android.view.View;
import android.view.View.OnClickListener;

import com.plter.lib.android.java.anim.AnimationStyle;
import com.plter.lib.android.java.controls.ViewController;

public class Mn1Vc extends ViewController implements OnClickListener {

	public Mn1Vc(Context context) {
		super(context, R.layout.mn1_layout);
		
		setAnimationStyle(AnimationStyle.PUSH);
		
		findViewByID(R.id.goBackBtn).setOnClickListener(this);
		findViewByID(R.id.nextBtn).setOnClickListener(this);
	}

	@Override
	public void onClick(View v) {
		switch (v.getId()) {
		case R.id.nextBtn:
			pushViewController(new Mn2Vc(getContext()), true);
			break;
		case R.id.goBackBtn:
			getPrevious().popViewController(true);
			break;

		default:
			break;
		}
		
	}

}
