package com.eapexpert.recrespite;

import android.annotation.TargetApi;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.ActionBarDrawerToggle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import java.util.ArrayList;

/**
 * Created by Navpreet on 2016-10-17.
 */
public class SideMenuBar {
    ArrayList<NavItem> mNavItems = new ArrayList<NavItem>();
    public ListView mDrawerList;
    public DrawerLayout mDrawerLayout;
    Context context;
    String resultForEmail;
    View view1;
    public ArrayAdapter<String> mAdapter;
    public ActionBarDrawerToggle mDrawerToggle;
    public String mActivityTitle;

    public void addDrawerItems(final Context context, DrawerLayout mDrawerLayout, ListView mDrawerList)


    {
        mNavItems.add(new NavItem("Home", R.drawable.home_menu));
        mNavItems.add(new NavItem("My Profile", R.drawable.profile_menu));
        mNavItems.add(new NavItem("Library", R.drawable.info));
        mNavItems.add(new NavItem("Events", R.drawable.event_menu));
        mNavItems.add(new NavItem("Logout", R.drawable.logout_menu));
        this.mDrawerList = mDrawerList;
        //(ListView) findViewById(R.id.navList);
        DrawerListAdapter adapter = new DrawerListAdapter(context, mNavItems);
        mDrawerList.setAdapter(adapter);

        mDrawerList.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @TargetApi(Build.VERSION_CODES.LOLLIPOP)
            @Override
            public void onItemClick(AdapterView<?> parent, final View view, int position, long id) {
                if (position == 0) {
                    Intent intent = new Intent(context, Home.class);
                    context.startActivity(intent);
                }
                if (position == 2) {
                    Intent intent = new Intent(context, Library.class);
                    context.startActivity(intent);
                }

            }

        });
    }
}