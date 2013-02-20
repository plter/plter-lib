package com.plter.usingsector;

import com.plter.lib.android.sector.java.Command;

import android.app.Activity;
import android.os.Bundle;

public class E023_UsingSectorActivity extends Activity {
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        MainSector.getMainSector().sendCommand(new Command(Commands.START_UP));
    }
}