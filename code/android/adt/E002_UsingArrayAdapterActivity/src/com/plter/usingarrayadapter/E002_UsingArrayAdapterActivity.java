package com.plter.usingarrayadapter;

import java.io.File;

import android.app.ListActivity;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.plter.lib.android.java.controls.ArrayAdapter;

public class E002_UsingArrayAdapterActivity extends ListActivity {
	
	
	private ArrayAdapter<File> adapter;
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        adapter=new ArrayAdapter<File>(this,R.layout.list_cell_layout) {
			
			@Override
			public void initListCell(int arg0, View arg1, ViewGroup arg2) {
				
				ImageView iconIv=(ImageView) arg1.findViewById(R.id.iconIv);
				TextView titleTv=(TextView) arg1.findViewById(R.id.fileNameTv);
				File f=getItem(arg0);
				if (f.isDirectory()) {
					iconIv.setImageResource(R.drawable.folder_icon);
				}else{
					iconIv.setImageResource(R.drawable.file_icon);
				}
				titleTv.setText(f.getName());
			}
		};
        
		File rootDir=new File("/");
		for (File file : rootDir.listFiles()) {
			adapter.add(file);
		}
		
		setListAdapter(adapter);
    }
}