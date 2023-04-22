package com.example.pxf.hdfs.writable.dataschema;

import org.apache.hadoop.io.*;
import java.io.DataInput;
import java.io.DataOutput;
import java.io.IOException;
import java.lang.reflect.Field;

/**
 * PxfExample_CustomWritable class - used to serialize and deserialize data with
 * text, int, and float data types
 */
public class PxfExample_CustomWritable implements Writable {

    public String st1, st2;
    public int int1;
    public float ft;

    public PxfExample_CustomWritable() {
        st1 = new String("");
        st2 = new String("");
        int1 = 0;
        ft = 0.f;
    }

    public PxfExample_CustomWritable(int i1, int i2, int i3) {

        st1 = new String("short_string___" + i1);
        st2 = new String("short_string___" + i1);
        int1 = i2;
        ft = i1 * 10.f * 2.3f;

    }

    String GetSt1() {
        return st1;
    }

    String GetSt2() {
        return st2;
    }

    int GetInt1() {
        return int1;
    }

    float GetFt() {
        return ft;
    }

    @Override
    public void write(DataOutput out) throws IOException {

        Text txt = new Text();
        txt.set(st1);
        txt.write(out);
        txt.set(st2);
        txt.write(out);

        IntWritable intw = new IntWritable();
        intw.set(int1);
        intw.write(out);

        FloatWritable fw = new FloatWritable();
        fw.set(ft);
        fw.write(out);
    }

    @Override
    public void readFields(DataInput in) throws IOException {

        Text txt = new Text();
        txt.readFields(in);
        st1 = txt.toString();
        txt.readFields(in);
        st2 = txt.toString();

        IntWritable intw = new IntWritable();
        intw.readFields(in);
        int1 = intw.get();

        FloatWritable fw = new FloatWritable();
        fw.readFields(in);
        ft = fw.get();
    }

    public void printFieldTypes() {
        Class myClass = this.getClass();
        Field[] fields = myClass.getDeclaredFields();

        for (int i = 0; i < fields.length; i++) {
            System.out.println(fields[i].getType().getName());
        }
    }
}
