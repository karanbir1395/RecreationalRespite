package com.eapexpert.recrespite;

import android.content.Intent;
import android.graphics.Bitmap;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.Toast;

public class SelectedLibraryItem extends AppCompatActivity {
    WebView web;
String pdf;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_selected_library_item);
        web=(WebView) findViewById(R.id.web);
        Intent in = getIntent();
        pdf=in.getStringExtra("url");
        Toast.makeText(this,pdf,Toast.LENGTH_SHORT).show();
     //   web.setWebViewClient(new myWebClient());
        //web.getSettings().setJavaScriptEnabled(true);



        web.loadUrl(pdf);

    }
    public class myWebClient extends WebViewClient
    {
        @Override
        public void onPageStarted(WebView view, String url, Bitmap favicon) {
            // TODO Auto-generated method stub
            super.onPageStarted(view, url, favicon);
        }

        @Override
        public boolean shouldOverrideUrlLoading(WebView view, String url) {
            // TODO Auto-generated method stub

            view.loadUrl(url);
            return true;

        }
    }
}
