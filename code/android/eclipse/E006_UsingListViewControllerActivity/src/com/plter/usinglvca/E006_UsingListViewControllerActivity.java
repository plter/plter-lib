package com.plter.usinglvca;

import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.TextView;

import com.plter.lib.android.java.controls.ArrayAdapter;
import com.plter.lib.android.java.controls.ListViewControllerActivity;

public class E006_UsingListViewControllerActivity extends ListViewControllerActivity implements OnItemClickListener {
	
	
	private ArrayAdapter<String> adapter;
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        adapter=new ArrayAdapter<String>(this,android.R.layout.simple_list_item_1) {
			
			@Override
			public void initListCell(int position, View listCell, ViewGroup parent) {
				((TextView)listCell).setText(getItem(position));
			}
		};
		
		adapter.add("mn1");
		adapter.add("mn2");
		setAdapter(adapter);
		
		setOnItemClickListener(this);
    }

	@Override
	public void onItemClick(AdapterView<?> arg0, View arg1, int arg2, long arg3) {
		switch (arg2) {
		case 0:
			pushViewController(new Mn1Vc(this), true);
			break;
		case 1:
			pushViewController(new Mn2Vc(this), true);
			break;

		default:
			break;
		}
	}
}