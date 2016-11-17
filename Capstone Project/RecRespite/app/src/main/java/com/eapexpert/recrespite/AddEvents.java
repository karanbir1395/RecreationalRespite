package com.eapexpert.recrespite;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.AsyncTask;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;

/**
 * Created by Navpreet on 2016-10-18.
 */
public class AddEvents extends BaseAdapter {
    Context context;


    LayoutInflater inflater;
    ArrayList<HashMap<String, String>> data;

    HashMap<String, String> resultp = new HashMap<String, String>();

    public AddEvents(Context context, ArrayList<HashMap<String, String>> eventlist) {
        this.context = context;
        data = eventlist;
    }

    @Override
    public int getCount() {
        return data.size();
    }

    @Override
    public Object getItem(int position) {
        return null;
    }

    @Override
    public long getItemId(int position) {
        return 0;
    }



    @Override
    public View getView(int position, View convertView, ViewGroup parent) {

        TextView date, title, location;
        ImageView image;
        inflater = (LayoutInflater) context
                .getSystemService(Context.LAYOUT_INFLATER_SERVICE);

        View itemView = inflater.inflate(R.layout.home_list_view, parent, false);

        // Get the position
        resultp = data.get(position);
        date = (TextView) itemView.findViewById(R.id.eventDate);
        // Locate the TextViews in item.xml

       // image = (ImageView) itemView.findViewById(R.id.eventImage);
        title = (TextView) itemView.findViewById(R.id.eventTitle);
        location = (TextView) itemView.findViewById(R.id.eventAddress);
        title.setText(resultp.get(Home.TITLE));
        location.setText(resultp.get(Home.LOCATION));
        date.setText(resultp.get(Home.DATE));
        String imageUrl= resultp.get(Home.IMAGE);
        String url =imageUrl.replace("www.dropbox.", "dl.dropboxusercontent.");
        new DownloadImageTask((ImageView) itemView.findViewById(R.id.eventImage))
               .execute(url);


        return itemView;
    }

    private class DownloadImageTask extends AsyncTask<String, Void, Bitmap> {
        ImageView bmImage;

        public DownloadImageTask(ImageView bmImage) {
            this.bmImage = bmImage;
        }

        protected Bitmap doInBackground(String... urls) {
            String urldisplay = urls[0];
            Bitmap mIcon11 = null;
            try {

                InputStream in = new java.net.URL(urldisplay).openStream();

                mIcon11 = BitmapFactory.decodeStream(in);
                // in.reset();
            } catch (Exception e) {
                Log.e("Error", e.getMessage());
                e.printStackTrace();
            }
            return mIcon11;
        }

        protected void onPostExecute(Bitmap result) {
            bmImage.setImageBitmap(result);
        }
    }
}