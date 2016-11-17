package com.eapexpert.recrespite;

import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Typeface;
import android.os.AsyncTask;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.text.Html;
import android.util.Log;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;

public class MainActivity extends AppCompatActivity {
    TextView signUp, explore, about;
    EditText email;
    Context context = this;
    String urlEmail;
    private static final String LOG_TAG = "ExampleApp";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        signUp = (TextView) findViewById(R.id.signUp);
        explore = (TextView) findViewById(R.id.explore);
        about = (TextView) findViewById(R.id.about);
        email = (EditText) findViewById(R.id.email);
        String signup = "<u>Sign Up</u>";
        String exploreApp = "<u>Explore the App</u>";
        String aboutUs = "<u>About Recreational Respite</u>";
        signUp.setText(Html.fromHtml(signup), TextView.BufferType.SPANNABLE);
        explore.setText(Html.fromHtml(exploreApp), TextView.BufferType.SPANNABLE);
        about.setText(Html.fromHtml(aboutUs), TextView.BufferType.SPANNABLE);

    }

    public void signUp(View view) {


        Intent intent = new Intent(this, Categories.class);
        startActivity(intent);
    }

    public void logIn(View view) {

        urlEmail = email.getText().toString();
        if (urlEmail.length() == 0) {
            AlertDialog.Builder builder = new AlertDialog.Builder(this);
            builder.setTitle("Error");
            builder.setMessage("The username cannot be null please try again");
            builder.setPositiveButton("OK", new DialogInterface.OnClickListener() {
                public void onClick(DialogInterface dialog, int id) {
                    // User clicked OK button
                }
            });
            AlertDialog dialog = builder.create();
            dialog.show();
            builder.setCancelable(false);
        } else {
            new checkEmailExists().execute();
        }


    }


    public class checkEmailExists extends AsyncTask {
        @Override
        protected void onPreExecute() {

        }

        protected Object doInBackground(Object[] params) {
            HttpURLConnection conn = null;
            final StringBuilder json = new StringBuilder();
            try {
                JSONParser jParser = new JSONParser(); // get JSON data fro
                //  JSONObject jsonObject=jParser.getJSONFromUrl("https://recrespite-3c13b.firebaseio.com/userlog/hallen.json");
                final String json1 = jParser.getJSONFromUrl("https://recrespite-3c13b.firebaseio.com/userlog/userlog/"+urlEmail.trim()+".json");
                Log.d("array", String.valueOf(json1));
                runOnUiThread(new Runnable() {
                    public void run() {
                        try {
                            loadData(json1);
                        } catch (JSONException e) {

                            Log.e(LOG_TAG, "Error processing JSON", e);
                        }
                    }
                });
            } catch (IOException e) {
                e.printStackTrace();
            } finally {

            }
            return null;
        }


        void loadData(String json) throws JSONException {

/*            for (int i = 0; i < json.length(); i++) {*/

            if(json.length()==4){

                AlertDialog.Builder builder = new AlertDialog.Builder(context);
                builder.setTitle("Error");
                builder.setMessage("The username does not exist");
                builder.setPositiveButton("OK", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int id) {
                        // User clicked OK button
                    }
                });
                AlertDialog dialog = builder.create();

                dialog.show();
                builder.setCancelable(false);
            }
          else {
                Intent intent=  new Intent(MainActivity.this,Home.class);
                startActivity(intent);

            }



            }
            }
        }




