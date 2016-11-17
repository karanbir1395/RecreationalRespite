package com.eapexpert.recrespite;

import android.content.Intent;
import android.os.Looper;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.EditText;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicHeader;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.protocol.HTTP;
import org.json.JSONObject;

import java.io.InputStream;

public class SignUp extends AppCompatActivity {

    EditText etUsername, etFirstname, etLastname, etEmailAddress, etPhone, etCity, etRegion;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sign_up);
    }

    public void addParticipant(View view) {

    }

    public void onClickNext(View view) {


        etUsername = (EditText) findViewById(R.id.username);
        etFirstname = (EditText) findViewById(R.id.etFirstName);
        etLastname = (EditText) findViewById(R.id.etLastName);
        etEmailAddress = (EditText) findViewById(R.id.email);
        etPhone = (EditText) findViewById(R.id.phone);
        etCity = (EditText) findViewById(R.id.city);
        etRegion = (EditText) findViewById(R.id.region);


        final String username = etUsername.getText().toString().trim();
        final String firstname = etFirstname.getText().toString().trim();
        final String lastname = etLastname.getText().toString().trim();
        final String emailAddress = etEmailAddress.getText().toString().trim();
        final String phone = etPhone.getText().toString().trim();
        final String city = etCity.getText().toString().trim();
        final String region = etRegion.getText().toString().trim();

        //Checking validations
        if (username.equals("")) {
            etUsername.setError("Username is required");
            etUsername.setHint("Username");
        }

        else if(username.contains(" "))
        {
            etUsername.setError("No spaces allowed");

        }

        else if(!username.matches("[a-zA-Z.@_0-9]*"))
        {
            etUsername.setError("Only alphabets, numbers, . _ and @ symbols allowed");
        }

        else if(emailAddress.equals(""))
        {
            etEmailAddress.setError("Email is required");
            etEmailAddress.setHint("Email");
        }


        //Putting(sending) data to firebase database
        else {
            Thread t = new Thread() {

                public void run() {
                    Looper.prepare(); //For Preparing Message Pool for the child Thread
                    HttpClient client = new DefaultHttpClient();
                    HttpConnectionParams.setConnectionTimeout(client.getParams(), 10000); //Timeout Limit
                    HttpResponse response;
                    JSONObject json = new JSONObject();


                    final String url = "https://recrespite-3c13b.firebaseio.com/UserInformation/" + username + ".json";

                    //URI uri = new URI("https://recrespite-3c13b.firebaseio.com/UserInformation/" +username+ ".json");

                    Log.v("url is ", url);
                    try {
                        HttpPut put = new HttpPut(url);
                        json.put("firstname", firstname);
                        json.put("lastname", lastname);
                        json.put("username", username);
                        json.put("email", emailAddress);
                        json.put("phoneNumber", phone);
                        json.put("city", city);
                        json.put("region", region);

                        StringEntity se = new StringEntity(json.toString());
                        se.setContentType(new BasicHeader(HTTP.CONTENT_TYPE, "application/json"));
                        put.setEntity(se);
                        response = client.execute(put);

                    /*Checking response */
                        if (response != null) {
                            InputStream in = response.getEntity().getContent(); //Get the data in the entity

                            intentParticipant(username);
                        }

                    } catch (Exception e) {
                        e.printStackTrace();
                        Log.v("Error", "Cannot Estabilish Connection");
                    }

                    Looper.loop(); //Loop in the message queue
                }
            };

            t.start();
        }


    }

    public void intentParticipant(String username)
    {
        Intent intent = new Intent(this, AddParticipants.class);
        intent.putExtra("passUsername", username);
        startActivity(intent);
    }
}