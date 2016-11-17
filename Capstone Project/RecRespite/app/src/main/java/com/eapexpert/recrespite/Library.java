package com.eapexpert.recrespite;

import android.content.Context;
import android.content.Intent;
import android.content.res.Configuration;
import android.os.AsyncTask;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.ActionBarDrawerToggle;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;

public class Library extends AppCompatActivity {
    Context context = this;
    private DrawerLayout mDrawerLayout;
    SideMenuBar sideBar;
    HashMap<String,String> url= new HashMap<>();
    private ListView mDrawerList;
    private ArrayAdapter<String> listAdapter ;
    ArrayList<String> arraylist = new ArrayList<>();
    ListView listViewLib;
    private static final String LOG_TAG = "ExampleApp";
    private String mActivityTitle;
    private ActionBarDrawerToggle mDrawerToggle;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_library);
        mDrawerList = (ListView) findViewById(R.id.navList);
        mDrawerLayout = (DrawerLayout) findViewById(R.id.drawer_layout);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        listViewLib=(ListView) findViewById(R.id.libArtcles) ;
        getSupportActionBar().setHomeButtonEnabled(true);
        mActivityTitle = getTitle().toString();
        sideBar = new SideMenuBar();
        sideBar.addDrawerItems(this, mDrawerLayout, mDrawerList);
        setupDrawer();
        new loadevents().execute();
    }

    private void setupDrawer() {
        mDrawerToggle = new ActionBarDrawerToggle(this, mDrawerLayout, R.string.drawer_open, R.string.drawer_close) {

            /** Called when a drawer has settled in a completely open state. */
            public void onDrawerOpened(View drawerView) {
                super.onDrawerOpened(drawerView);
                getSupportActionBar().setTitle("Navigation");
                invalidateOptionsMenu(); // creates call to onPrepareOptionsMenu()
            }

            /** Called when a drawer has settled in a completely closed state. */
            public void onDrawerClosed(View view) {
                super.onDrawerClosed(view);
                getSupportActionBar().setTitle(mActivityTitle);
                invalidateOptionsMenu(); // creates call to onPrepareOptionsMenu()
            }
        };

        mDrawerToggle.setDrawerIndicatorEnabled(true);
        mDrawerLayout.setDrawerListener(mDrawerToggle);
    }

    @Override
    protected void onPostCreate(Bundle savedInstanceState) {
        super.onPostCreate(savedInstanceState);
        // Sync the toggle state after onRestoreInstanceState has occurred.
        mDrawerToggle.syncState();
    }

    @Override
    public void onConfigurationChanged(Configuration newConfig) {
        super.onConfigurationChanged(newConfig);
        mDrawerToggle.onConfigurationChanged(newConfig);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        // Activate the navigation drawer toggle
        if (mDrawerToggle.onOptionsItemSelected(item)) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
    public class loadevents extends AsyncTask {

        protected Object doInBackground(Object[] params) {

            try {
                JSONParser jParser = new JSONParser(); // get JSON data from URL
                final String json1 = jParser.getJSONFromUrl("https://recrespite-3c13b.firebaseio.com/articles2/articles.json");

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

            JSONArray jsonArray = new JSONArray(json);
            for (int i = 0; i < jsonArray.length() - 1; i++) {



                JSONObject jsonObject = jsonArray.getJSONObject(i);
     arraylist.add(i,jsonObject.getString("name"));
                url.put(jsonObject.getString("name"),jsonObject.getString("articlePDF").replace("www.dropbox.", "dl.dropboxusercontent."));


            }

           // listAdapter=new ArrayAdapter<String>(context, R.layout.get_info_layout,list);
           // infoTitle.setAdapter(listAdapter);
       listAdapter= new ArrayAdapter<String>(context,R.layout.lib_list_lay,arraylist);
            listViewLib.setAdapter(listAdapter);
            listViewLib.setOnItemClickListener(new AdapterView.OnItemClickListener() {
                @Override
                public void onItemClick(AdapterView<?> parent, View view, int position,
                                        long id) {

                    Intent intent = new Intent(Library.this,SelectedLibraryItem.class);
                    String title=((TextView)view).getText().toString();
                    //Toast.makeText(Library.this,title,Toast.LENGTH_SHORT).show();
                    String pdf=url.get(((TextView) view).getText().toString());
                    intent.putExtra("title",((TextView) view).getText().toString());
                    intent.putExtra("url",pdf);
                    Toast.makeText(Library.this,((TextView) view).getText().toString()+pdf,Toast.LENGTH_SHORT).show();
                    startActivity(intent);

                }
            });
        }
        }


        protected void onPostExecute() {


        }
    }

