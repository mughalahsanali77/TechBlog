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
public class Category {
    private int cid;
    private String name;
    private String discription;

    public Category(int cid, String name, String discription) {
        this.cid = cid;
        this.name = name;
        this.discription = discription;
    }

    public Category() {
    }

    public Category(String name, String discription) {
        this.name = name;
        this.discription = discription;
    }

    public int getCid() {
        return cid;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDiscription() {
        return discription;
    }

    public void setDiscription(String discription) {
        this.discription = discription;
    }
    
    
    
    
}
