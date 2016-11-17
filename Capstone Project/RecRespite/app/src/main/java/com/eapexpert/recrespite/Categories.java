package com.eapexpert.recrespite;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.Spinner;

import java.util.ArrayList;

public class Categories extends AppCompatActivity {
    ListView categoreis;
    ArrayList<String> list = new ArrayList<String>();
    private ArrayAdapter<String> listAdapter ;
    View view;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_categories);

    }


    public void parent(View v) {
        AlertDialog.Builder b1 = new AlertDialog.Builder(this);




                                final LayoutInflater inflater = (LayoutInflater)this.getSystemService
                                        (Context.LAYOUT_INFLATER_SERVICE);

                                // Inflate and set the layout for the dialog
                                // Pass null as the parent view because its going in the dialog layout
                                view=inflater.inflate(R.layout.dialog, null) ;

        categoreis=(ListView)view.findViewById(R.id.listView);
        list.add("Developmental");
        list.add("Intellectual");
        list.add("Mental Health");
        list.add("Physical");
        list.add("Chronic Illness");
        list.add("Neurological and Brain Injury");
        list.add("Mobility Impairment");
        listAdapter=new ArrayAdapter<String>(this, R.layout.dialog_list_layout,list);
        categoreis.setAdapter(listAdapter);
                                b1.setView(view);

        b1.setCancelable(false);
        b1.show();
    }

    public void signUp(View view) {
        Intent intent= new Intent(this,SignUp.class);
        startActivity(intent);
    }
}
