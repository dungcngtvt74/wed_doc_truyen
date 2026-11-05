package com.web_doc_truyen.backend.chuong.laydulieu;


import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;

@Entity
@Table(name = "truyen")
public class laydulieu {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @JsonProperty("ten_truyen")
    @Column(name = "ten_truyen")
    private String tentruyen;


    public laydulieu() {
    }

    public laydulieu(Integer id, String tentruyen) {
        this.id = id;
        this.tentruyen = tentruyen;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTentruyen() {
        return tentruyen;
    }

    public void setTentruyen(String tentruyen) {
        this.tentruyen = tentruyen;
    }
}
