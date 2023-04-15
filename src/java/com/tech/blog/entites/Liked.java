/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tech.blog.entites;

/**
 *
 * @author Ahsan
 */
public class Liked {
    private int lid;
    private int pid;
    private int uid;

    public Liked() {
    }

    public Liked(int lid, int pid, int uid) {
        this.lid = lid;
        this.pid = pid;
        this.uid = uid;
    }

    public Liked(int pid, int uid) {
        this.pid = pid;
        this.uid = uid;
    }

    public int getLid() {
        return lid;
    }

    public void setLid(int lid) {
        this.lid = lid;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }
    
    
    
}
