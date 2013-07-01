package com.plter.usinglvc;

import com.plter.lib.android.java.controls.ArrayAdapter;
import com.plter.lib.android.java.controls.ListViewController;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.TextView;

public class E007_UsingListViewControllerActivity extends Activity implements OnItemClickListener {
	
	
	private ListViewController rootLvc;
	private ArrayAdapter<String> adapter;
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        rootLvc=new ListViewController(this, R.layout.list_layout);
        setContentView(rootLvc.getViewStack());
        
        adapter=new ArrayAdapter<String>(this,android.R.layout.simple_list_item_1) {
			
			@Override
			public void initListCell(int position, View listCell, ViewGroup parent) {
				((TextView)listCell).setText(getItem(position));
			}
		};
		
		adapter.add("中国");
		adapter.add("美国");
		rootLvc.setAdapter(adapter);
		
		rootLvc.setOnItemClickListener(this);
    }

	@Override
	public void onItemClick(AdapterView<?> arg0, View arg1, int arg2, long arg3) {
		switch (arg2) {
		case 0:
			rootLvc.pushViewController(new ChinaLvc(this), true);
			break;
		case 1:
			rootLvc.pushViewController(new USALvc(this), true);
			break;
		default:
			break;
		}
	}
	
	@Override
	public void onBackPressed() {
		if (rootLvc.getTopViewController()!=rootLvc) {
			rootLvc.getTopViewController().getPrevious().popViewController(true);
		}else{
			finish();
		}
		
	}
}