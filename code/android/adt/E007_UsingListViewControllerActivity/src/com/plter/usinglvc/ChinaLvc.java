package com.plter.usinglvc;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.plter.lib.android.java.anim.AnimationStyle;
import com.plter.lib.android.java.controls.ArrayAdapter;
import com.plter.lib.android.java.controls.ListViewController;

public class ChinaLvc extends ListViewController {

	
	private ArrayAdapter<String> adapter;
	
	public ChinaLvc(Context context) {
		super(context);
		setAnimationStyle(AnimationStyle.PUSH_RIGHT_TO_LEFT);
		
		adapter=new ArrayAdapter<String>(context,android.R.layout.simple_list_item_1) {
			
			@Override
			public void initListCell(int position, View listCell, ViewGroup parent) {
				((TextView)listCell).setText(getItem(position));
			}
		};
		adapter.add("北京");
		adapter.add("上海");
		setAdapter(adapter);
	}

}
