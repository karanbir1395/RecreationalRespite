package com.eapexpert.recrespite;

import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Spinner;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class AddParticipants extends AppCompatActivity {

    Spinner diagnosisSpinner;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add_participants);

        diagnosisSpinner = (Spinner) findViewById(R.id.diagnosisSpinner);
        new getDiagnosis().execute();

    }

    public void home(View view) {
        Intent intent = new Intent(this, Home.class);
        startActivity(intent);
    }

    public class getDiagnosis extends AsyncTask {

        ArrayList<String> diagnosisArray = new ArrayList<String>();

        @Override
        protected void onPreExecute() {

        }

        protected Object doInBackground(Object[] params) {

            try {
                JSONParser jParser = new JSONParser(); // get JSON data fro
                //  JSONObject jsonObject=jParser.getJSONFromUrl("https://recrespite-3c13b.firebaseio.com/userlog/hallen.json");
                final String json1 = jParser.getJSONFromUrl("https://recrespite-3c13b.firebaseio.com/diagnosis/diagnosis.json");

                Log.d("array", String.valueOf(json1));

                //loadData(json1);
                runOnUiThread(new Runnable() {
                    public void run() {
                        try {
                            loadData(json1);
                        } catch (JSONException e) {

                            Log.e("JSON not processed", "Error processing JSON", e);
                        }
                    }
                });
            }

            catch (IOException e) {
                e.printStackTrace();
            }  finally {

            }
            return null;
        }


        public void loadData(String json) throws JSONException {

            List<String> diagnosisList = new ArrayList<String>();


            if (json == null) {
                Log.v("TAG JSON", "Json was empty");
            }
            else{
                // Log.v("TAG JSON", "Json was not empty");
                try {

                    JSONArray jsonArray = new JSONArray(json);
                    // Log.v("LOG JSON ARRAY", jsonArray.getString(2));

                    JSONObject jsonObject = new JSONObject();

                    for(int i=0; i<jsonArray.length(); i++) {
                        // jsonObject = jsonArray.getJSONObject(i);
                        diagnosisList.add(jsonArray.getJSONObject(i).getString("name").toString().trim());

                    }
                    int inee = jsonArray.length();

                    Log.v("Array length", "length is: "+ inee);


                    ArrayAdapter<String> diagnosis_Adapter = new ArrayAdapter<String>(
                            AddParticipants.this, android.R.layout.simple_spinner_item, diagnosisList);
                    diagnosis_Adapter.setDropDownViewResource( android.R.layout.simple_spinner_dropdown_item );

// Spinner spinYear = (Spinner)findViewById(R.id.spin);
                    diagnosisSpinner.setAdapter(diagnosis_Adapter);

                    //Log.d("LOG JSON", jsonObject.getString("name"));

                } catch (Throwable t) {
                    Log.e("LOG JSON", "Could not parse malformed JSON: \"" + json + "\"");
                }



            }


        }


    }
}
