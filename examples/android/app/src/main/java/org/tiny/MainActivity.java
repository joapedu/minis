package org.tiny;

import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;

public class MainActivity extends Activity {
    static {
        try {
            System.loadLibrary("tiny_android");
        } catch (UnsatisfiedLinkError e) {
            // library may not be present in local dev tree
        }
    }

    private native void nativeHello();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        TextView tv = new TextView(this);
        tv.setText("Tiny Android Example");
        setContentView(tv);
        nativeHello();
    }
}
